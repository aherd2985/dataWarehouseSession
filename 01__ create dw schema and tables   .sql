USE [dataWarehouse]
GO

CREATE SCHEMA [Stg];
GO

CREATE SCHEMA [Fact];
GO

CREATE TABLE Stg.Contract
(
  DwCnct_ID INT IDENTITY(1,1) NOT NULL,
  ActCnct_ID INT NULL,
  OpsCnct_ID INT NULL,
  ContractName VARCHAR(50) NOT NULL,
  PRIMARY KEY (DwCnct_ID)
);
GO

CREATE TABLE Stg.AOR_Type
(
  DwAT_ID INT IDENTITY(1,1) NOT NULL,
  AT_ID INT NOT NULL,
  AOR_Name VARCHAR(50) NOT NULL,
  PRIMARY KEY (DwAT_ID)
);
GO

CREATE TABLE Stg.Employees
(
  DwE_ID INT IDENTITY(1,1) NOT NULL,
  E_ID INT NOT NULL,
  EmployeeName VARCHAR(250) NOT NULL,
  PRIMARY KEY (DwE_ID)
);
GO

CREATE TABLE Stg.Revenue
(
  DwR_ID INT IDENTITY(1,1) NOT NULL,
  R_ID INT NOT NULL,
  ContractAmount decimal(10,2) NOT NULL,
  BilledAmount decimal(10,2) NOT NULL,
  ReceivedAmount decimal(10,2) NOT NULL,
  ActCnct_ID INT NOT NULL,
  [ReportMth] date NOT NULL,
  PRIMARY KEY (DwR_ID)
);
GO

CREATE TABLE Stg.Cost
(
  DwC_ID INT IDENTITY(1,1) NOT NULL,
  C_ID INT NOT NULL,
  CostType INT NOT NULL,
  CostAmount decimal(10,2) NOT NULL,
  ActCnct_ID INT NOT NULL,
  [ReportMth] date NOT NULL,
  PRIMARY KEY (DwC_ID)
);
GO

CREATE TABLE Stg.OpsAOR
(
  DwOA_ID INT IDENTITY(1,1) NOT NULL,
  OA_ID INT NOT NULL,
  StartDt DATE NOT NULL,
  EndDt DATE NULL,
  OpsCnct_ID INT NOT NULL,
  AT_ID INT NOT NULL,
  E_ID INT NOT NULL,
  PRIMARY KEY (OA_ID)
);
GO

CREATE TABLE Fact.ContributionMargin
(
  CM_ID INT IDENTITY(1,1) NOT NULL,
  BilledAmount decimal(10,2) NOT NULL,
  CostAmount decimal(10,2) NOT NULL,
  DwCnct_ID INT NOT NULL,
  ContractName varchar(50),
  SuperIntendentID INT NOT NULL,
  SuperIntendentName varchar(250),
  ProjMgrID INT NOT NULL,
  ProjMgrName varchar(250),
  [ReportMth] date NOT NULL,
  PRIMARY KEY (CM_ID)
);
GO