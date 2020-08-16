USE [dataWarehouse]
GO


MERGE [Dim].[Employees] AS TARGET
USING [Stg].[Employees] AS SOURCE 
ON (TARGET.[E_ID] = SOURCE.[E_ID]) 
--When records are matched, update the records if there is any change
WHEN MATCHED AND TARGET.[EmployeeName] <> SOURCE.[EmployeeName] 
THEN UPDATE SET 
  TARGET.[EmployeeName] = SOURCE.[EmployeeName]
--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET 
THEN INSERT ([E_ID], [EmployeeName]) 
VALUES (SOURCE.[E_ID], SOURCE.[EmployeeName])
--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE 
THEN DELETE 
--$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
--one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
OUTPUT $action, 
DELETED.DE_ID AS TargetDE_ID, 
DELETED.[E_ID] AS TargetE_ID,
DELETED.EmployeeName AS TargetEmployeeName,
INSERTED.DE_ID AS SourceDE_ID, 
INSERTED.E_ID AS SourceE_ID, 
INSERTED.EmployeeName AS SourceEmployeeName; 


SELECT @@ROWCOUNT;
GO


;
GO


