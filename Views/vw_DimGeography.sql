USE [AdventureWorksDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_DimGeography]
AS
SELECT [City]
      ,[EnglishCountryRegionName] as [Region]
      ,[SalesTerritoryRegion]
	  ,st.SalesTerritoryGroup
	  ,st.SalesTerritoryKey
FROM [AdventureWorksDWH].[dbo].[DimGeography] g
INNER JOIN [AdventureWorksDWH].[dbo].[DimSalesTerritory] st on st.SalesTerritoryKey = g.SalesTerritoryKey
GO


