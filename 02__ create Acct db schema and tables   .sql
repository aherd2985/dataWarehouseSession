Use [AcctDb]
GO

CREATE TABLE dbo.Contract
(
  Cnct_ID INT IDENTITY(1,1) NOT NULL,
  Contract VARCHAR(50) NOT NULL,
  PRIMARY KEY (Cnct_ID)
);
GO

CREATE TABLE dbo.Revenue
(
  R_ID INT IDENTITY(1,1) NOT NULL,
  ContractAmount decimal(10,2) NOT NULL,
  BilledAmount decimal(10,2) NOT NULL,
  ReceivedAmount decimal(10,2) NOT NULL,
  Cnct_ID INT NOT NULL,
  PRIMARY KEY (R_ID),
  FOREIGN KEY (Cnct_ID) REFERENCES dbo.Contract(Cnct_ID)
);
GO

CREATE TABLE dbo.Cost
(
  C_ID INT IDENTITY(1,1) NOT NULL,
  CostType INT NOT NULL,
  CostAmount decimal(10,2) NOT NULL,
  Cnct_ID INT NOT NULL,
  PRIMARY KEY (C_ID),
  FOREIGN KEY (Cnct_ID) REFERENCES dbo.Contract(Cnct_ID)
);
GO

