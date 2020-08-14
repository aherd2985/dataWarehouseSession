USE [dataWarehouse]
GO

CREATE SCHEMA [Stg];
GO

CREATE SCHEMA [Fact];
GO

CREATE TABLE Stg.Contract
(
  Cnct_ID INT NOT NULL,
  Contract VARCHAR(50) NOT NULL,
  PRIMARY KEY (Cnct_ID)
);

CREATE TABLE Stg.Revenue
(
  R_ID INT NOT NULL,
  ContractAmount decimal(10,2) NOT NULL,
  BilledAmount decimal(10,2) NOT NULL,
  ReceivedAmount decimal(10,2) NOT NULL,
  Cnct_ID INT NOT NULL,
  PRIMARY KEY (R_ID),
  FOREIGN KEY (Cnct_ID) REFERENCES Stg.Contract(Cnct_ID)
);

CREATE TABLE Stg.Cost
(
  C_ID INT NOT NULL,
  CostType INT NOT NULL,
  CostAmount decimal(10,2) NOT NULL,
  Cnct_ID INT NOT NULL,
  PRIMARY KEY (C_ID),
  FOREIGN KEY (Cnct_ID) REFERENCES Stg.Contract(Cnct_ID)
);

CREATE TABLE Fact.ContributionMargin
(
  CM_ID INT NOT NULL,
  BilledAmount decimal(10,2) NOT NULL,
  CostAmount decimal(10,2) NOT NULL,
  Superintendent VARCHAR(250) NOT NULL,
  ProjMgr VARCHAR(250) NOT NULL,
  Cnct_ID INT NOT NULL,
  PRIMARY KEY (CM_ID),
  FOREIGN KEY (Cnct_ID) REFERENCES Stg.Contract(Cnct_ID)
);

CREATE TABLE Stg.OpsAOR
(
  OA_ID INT NOT NULL,
  AOR_Type INT NOT NULL,
  EmployeeName VARCHAR(250) NOT NULL,
  StartDt DATE NOT NULL,
  EndDt DATE NOT NULL,
  Cnct_ID INT NOT NULL,
  PRIMARY KEY (OA_ID),
  FOREIGN KEY (Cnct_ID) REFERENCES Stg.Contract(Cnct_ID)
);