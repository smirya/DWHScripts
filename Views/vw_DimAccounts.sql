USE [AdventureWorksDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_DimAccounts]
AS
SELECT 
	AccountKey, 
	ParentAccountKey, 
	AccountCodeAlternateKey, 
	ParentAccountCodeAlternateKey, 
	AccountDescription, 
	AccountType, 
	ValueType
FROM dbo.DimAccount
GO


