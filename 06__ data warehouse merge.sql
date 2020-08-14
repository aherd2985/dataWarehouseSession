USE [dataWarehouse]
GO

WITH RevCTE AS (
SELECT A.ActCnct_ID, SUM(B.BilledAmount) Revenue
  FROM [STG].[Contract] A LEFT JOIN
	   [STG].[Revenue] B ON A.ActCnct_ID = B.ActCnct_ID
GROUP BY A.ActCnct_ID
)
, CA_CTE AS (
SELECT A.ActCnct_ID, SUM(B.CostAmount) Costs
  FROM [STG].[Contract] A LEFT JOIN
	   [STG].[Cost] B ON A.ActCnct_ID = B.ActCnct_ID
GROUP BY A.ActCnct_ID
)


MERGE [Fact].[ContributionMargin] AS TARGET
USING (
SELECT A.[DwCnct_ID], B.Revenue, C.Costs, D.E_ID 'ProjMgr', E.E_ID 'SI'
  FROM [STG].[Contract] A LEFT JOIN
	   RevCTE B ON A.ActCnct_ID = B.ActCnct_ID LEFT JOIN
	   CA_CTE C ON A.ActCnct_ID = C.ActCnct_ID LEFT JOIN
	   [STG].[OpsAOR] D ON A.OpsCnct_ID = D.OpsCnct_ID AND D.AT_ID = 1 LEFT JOIN
	   [STG].[OpsAOR] E ON A.OpsCnct_ID = E.OpsCnct_ID AND E.AT_ID = 2
WHERE GetDate() BETWEEN D.StartDt AND COALESCE(D.EndDt, GetDate())
AND GetDate() BETWEEN E.StartDt AND COALESCE(E.EndDt, GetDate())
) AS SOURCE 
ON (TARGET.[DwCnct_ID] = SOURCE.[DwCnct_ID]) 
--When records are matched, update the records if there is any change
WHEN MATCHED AND TARGET.[BilledAmount] <> SOURCE.Revenue OR TARGET.[CostAmount] <> SOURCE.Costs  OR TARGET.[SuperIntendent] <> SOURCE.SI OR TARGET.[ProjMgr] <> SOURCE.[ProjMgr]
THEN UPDATE SET 
  TARGET.[BilledAmount] = SOURCE.Revenue
, TARGET.[CostAmount] = SOURCE.Costs 
, TARGET.[SuperIntendent] = SOURCE.SI 
, TARGET.[ProjMgr] = SOURCE.ProjMgr 
--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET 
THEN INSERT ([DwCnct_ID], [BilledAmount], [CostAmount], [SuperIntendent], [ProjMgr]) VALUES (SOURCE.[DwCnct_ID], SOURCE.Revenue, SOURCE.Costs, SOURCE.SI, SOURCE.[ProjMgr])
--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE 
THEN DELETE 
--$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
--one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
OUTPUT $action, 
DELETED.[DwCnct_ID] AS TargetDwCnct_ID,
DELETED.[BilledAmount] AS TargetBilledAmount, 
DELETED.CostAmount AS TargetCostAmount, 
DELETED.SuperIntendent AS TargetSuperIntendent, 
DELETED.ProjMgr AS TargetProjMgr, 
INSERTED.DwCnct_ID AS SourceDwCnct_ID, 
INSERTED.[BilledAmount] AS SourceRevenue, 
INSERTED.CostAmount AS SourceCosts, 
INSERTED.SuperIntendent AS SourceSI, 
INSERTED.ProjMgr AS SourceProjMgr; 

SELECT @@ROWCOUNT;
GO


;
GO


