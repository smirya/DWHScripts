USE [AdventureWorksDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_DimCurrency]
AS
SELECT 
	[CurrencyKey]
      ,[CurrencyAlternateKey]
      ,[CurrencyName]
  FROM [AdventureWorksDWH].[dbo].[DimCurrency]
GO


