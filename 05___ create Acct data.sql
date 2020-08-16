USE [AcctDb]
GO
/*
	Create Financial data
*/
INSERT INTO [dbo].[Contract]
           ([ContractName])
     VALUES
           ('JC-01')
GO

INSERT INTO [dbo].[Revenue]
           ([ContractAmount]
           ,[BilledAmount]
           ,[ReceivedAmount]
           ,[Cnct_ID]
		   ,[ReportMth])
     VALUES
           (1000
           ,1000
           ,400
           ,1
		   ,'1/1/2020')
GO

INSERT INTO [dbo].[Cost]
           ([CostType]
           ,[CostAmount]
           ,[Cnct_ID]
		   ,[ReportMth])
     VALUES
           (1
           ,200
           ,1
		   ,'1/1/2020')
GO

INSERT INTO [dbo].[Cost]
           ([CostType]
           ,[CostAmount]
           ,[Cnct_ID]
		   ,[ReportMth])
     VALUES
           (2
           ,400
           ,1
		   ,'1/1/2020')
GO

INSERT INTO [dbo].[Cost]
           ([CostType]
           ,[CostAmount]
           ,[Cnct_ID]
		   ,[ReportMth])
     VALUES
           (3
           ,200
           ,1
		   ,'1/1/2020')
GO


