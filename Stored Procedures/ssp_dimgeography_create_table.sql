USE [AdventureWorksDWH];
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.ssp_dimgeography_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimGeography];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimGeography](
			[GeographyKey] [int] IDENTITY(1,1) NOT NULL,
			[City] [nvarchar](30) NULL,
			[StateProvinceCode] [nvarchar](3) NULL,
			[StateProvinceName] [nvarchar](50) NULL,
			[CountryRegionCode] [nvarchar](3) NULL,
			[EnglishCountryRegionName] [nvarchar](50) NULL,
			[SpanishCountryRegionName] [nvarchar](50) NULL,
			[FrenchCountryRegionName] [nvarchar](50) NULL,
			[PostalCode] [nvarchar](15) NULL,
			[SalesTerritoryKey] [int] NULL,
			[IpAddressLocator] [nvarchar](15) NULL,
		 CONSTRAINT [PK_DimGeography_GeographyKey] PRIMARY KEY CLUSTERED 
		(
			[GeographyKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimGeography] ON;
	with cte as
	(
		SELECT [GeographyKey]
			  ,[City]
			  ,[StateProvinceCode]
			  ,[StateProvinceName]
			  ,[CountryRegionCode]
			  ,[EnglishCountryRegionName]
			  ,[SpanishCountryRegionName]
			  ,[FrenchCountryRegionName]
			  ,[PostalCode]
			  ,[SalesTerritoryKey]
			  ,[IpAddressLocator]
		  FROM [AdventureWorksDW].[dbo].[DimGeography]
				)
				INSERT INTO [AdventureWorksDWH].[dbo].[DimGeography] 
			(
				[GeographyKey]
			  ,[City]
			  ,[StateProvinceCode]
			  ,[StateProvinceName]
			  ,[CountryRegionCode]
			  ,[EnglishCountryRegionName]
			  ,[SpanishCountryRegionName]
			  ,[FrenchCountryRegionName]
			  ,[PostalCode]
			  ,[SalesTerritoryKey]
			  ,[IpAddressLocator]	
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
