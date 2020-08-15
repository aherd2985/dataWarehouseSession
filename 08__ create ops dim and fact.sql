USE [dataWarehouse]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Dim].[Employees](
	[DE_ID] [int] IDENTITY(1,1) NOT NULL,
	[E_ID] [int] NOT NULL,
	[EmployeeName] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Dim].[AOR_Type](
	[DAT_ID] [int] IDENTITY(1,1) NOT NULL,
	[AT_ID] [int] NOT NULL,
	[AOR_Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DAT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [Dim].[Contract](
	[DCnct_ID] [int] IDENTITY(1,1) NOT NULL,
	[ActCnct_ID] [int] NULL,
	[OpsCnct_ID] [int] NULL,
	[ContractName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DCnct_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Dim].[ReportMth](
	[RM_ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportMth] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RM_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [Fact].[OpsAOR](
	[FOA_ID] [int] IDENTITY(1,1) NOT NULL,
	[DCnct_ID] [int] NOT NULL,
	[ContractName] [varchar](50) NOT NULL,
	[DAT_ID] [int] NOT NULL,
	[DE_ID] [int] NOT NULL,
	[EmployeeName] [varchar](250) NOT NULL,
	[StartDtRM_ID] [int] NOT NULL,
	[EndDtRM_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FOA_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Fact].[OpsAOR]  WITH CHECK ADD FOREIGN KEY([DE_ID])
REFERENCES [Dim].[Employees] ([DE_ID])
GO

ALTER TABLE [Fact].[OpsAOR]  WITH CHECK ADD FOREIGN KEY([DCnct_ID])
REFERENCES [Dim].[Contract] ([DCnct_ID])
GO

ALTER TABLE [Fact].[OpsAOR]  WITH CHECK ADD FOREIGN KEY([DAT_ID])
REFERENCES [Dim].[AOR_Type] ([DAT_ID])
GO

ALTER TABLE [Fact].[OpsAOR]  WITH CHECK ADD FOREIGN KEY([StartDtRM_ID])
REFERENCES [Dim].[ReportMth] ([RM_ID])
GO


