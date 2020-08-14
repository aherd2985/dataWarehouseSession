USE [OpsDb]
GO
/*
	Create Ops data
*/
INSERT INTO [dbo].[Contract]
           ([ContractName])
     VALUES
           ('JC-01')
GO

INSERT INTO [dbo].[AOR_Type]
           ([AOR_Name])
     VALUES
           ('Project Manager')
GO

INSERT INTO [dbo].[AOR_Type]
           ([AOR_Name])
     VALUES
           ('Superintendent')
GO

INSERT INTO [dbo].[Employees]
           ([EmployeeName])
     VALUES
           ('Bob Kane')
GO

INSERT INTO [dbo].[Employees]
           ([EmployeeName])
     VALUES
           ('Damian Wayne')
GO

INSERT INTO [dbo].[OpsAOR]
           ([StartDt]
           ,[EndDt]
           ,[Cnct_ID]
           ,[AT_ID]
           ,[E_ID])
     VALUES
           ('1/1/2020'
           ,CAST(null as date)
           ,1
           ,1
           ,1)
GO

INSERT INTO [dbo].[OpsAOR]
           ([StartDt]
           ,[EndDt]
           ,[Cnct_ID]
           ,[AT_ID]
           ,[E_ID])
     VALUES
           ('1/1/2020'
           ,CAST(null as date)
           ,1
           ,2
           ,2)
GO



