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
CREATE PROCEDURE dbo.ssp_dimsalesterritory_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimSalesTerritory];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimSalesTerritory](
			[SalesTerritoryKey] [int] IDENTITY(1,1) NOT NULL,
			[SalesTerritoryAlternateKey] [int] NULL,
			[SalesTerritoryRegion] [nvarchar](50) NOT NULL,
			[SalesTerritoryCountry] [nvarchar](50) NOT NULL,
			[SalesTerritoryGroup] [nvarchar](50) NULL,
			[SalesTerritoryImage] [varbinary](max) NULL,
		 CONSTRAINT [PK_DimSalesTerritory_SalesTerritoryKey] PRIMARY KEY CLUSTERED 
		(
			[SalesTerritoryKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [AK_DimSalesTerritory_SalesTerritoryAlternateKey] UNIQUE NONCLUSTERED 
		(
			[SalesTerritoryAlternateKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimSalesTerritory] ON;
	with cte as
	(
		SELECT [SalesTerritoryKey]
			  ,[SalesTerritoryAlternateKey]
			  ,[SalesTerritoryRegion]
			  ,[SalesTerritoryCountry]
			  ,[SalesTerritoryGroup]
			  ,[SalesTerritoryImage]
		  FROM [AdventureWorksDW].[dbo].[DimSalesTerritory]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[DimSalesTerritory] 
			(
				[SalesTerritoryKey]
			  ,[SalesTerritoryAlternateKey]
			  ,[SalesTerritoryRegion]
			  ,[SalesTerritoryCountry]
			  ,[SalesTerritoryGroup]
			  ,[SalesTerritoryImage]
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
