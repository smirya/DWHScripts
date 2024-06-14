USE [AdventureWorksDWH]
GO

/****** Object:  View [dbo].[vw_DimGeography]    Script Date: 6/11/2024 9:37:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_RegionalSecurity]
AS
SELECT [UserName]
      ,[SalesTerritoryKey]
FROM [dbo].[RegionalSecurity]
GO


