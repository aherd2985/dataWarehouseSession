USE [dataWarehouse]
GO

/****** Object:  Table [Fact].[ContributionMargin]    Script Date: 8/14/2020 11:11:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Fact].[ContributionMargin](
	[CM_ID] [int] IDENTITY(1,1) NOT NULL,
	[DCnct_ID] [int] NOT NULL,
	[ContractName] [varchar](50) NULL,
	[FCT_ID] int NOT NULL,
	[BilledAmount] [decimal](10, 2) NOT NULL,
	[CostAmount] [decimal](10, 2) NOT NULL,
	[SuperFOA_ID] [int]  NULL,
	[SuperIntendentID] [int] NULL,
	[SuperIntendentName] [varchar](250) NULL,
	[ProjFOA_ID] [int]  NULL,
	[ProjMgrID] [int] NULL,
	[ProjMgrName] [varchar](250) NULL,
	[RM_ID] int NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CM_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Fact].[ContributionMargin]  WITH CHECK ADD FOREIGN KEY([SuperIntendentID])
REFERENCES [Dim].[Employees] ([DE_ID])
GO

ALTER TABLE [Fact].[ContributionMargin]  WITH CHECK ADD FOREIGN KEY([ProjMgrID])
REFERENCES [Dim].[Employees] ([DE_ID])
GO

ALTER TABLE [Fact].[ContributionMargin]  WITH CHECK ADD FOREIGN KEY([FCT_ID])
REFERENCES [Fact].[ContractTotals] ([FCT_ID])
GO

ALTER TABLE [Fact].[ContributionMargin]  WITH CHECK ADD FOREIGN KEY([DCnct_ID])
REFERENCES [Dim].[Contract] ([DCnct_ID])
GO

ALTER TABLE [Fact].[ContributionMargin]  WITH CHECK ADD FOREIGN KEY([SuperFOA_ID])
REFERENCES [Fact].[OpsAOR] ([FOA_ID])
GO

ALTER TABLE [Fact].[ContributionMargin]  WITH CHECK ADD FOREIGN KEY([ProjFOA_ID])
REFERENCES [Fact].[OpsAOR] ([FOA_ID])
GO

ALTER TABLE [Fact].[ContributionMargin]  WITH CHECK ADD FOREIGN KEY([RM_ID])
REFERENCES [Dim].[ReportMth] ([RM_ID])
GO


