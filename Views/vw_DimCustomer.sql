USE [AdventureWorksDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_DimCustomer]
AS
SELECT DISTINCT [CustomerKey]
      ,[FirstName]
      ,[LastName]
      ,[EmailAddress]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[Phone]
FROM [AdventureWorksDWH].[dbo].[DimCustomer]
GO


