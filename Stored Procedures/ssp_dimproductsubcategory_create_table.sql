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
CREATE PROCEDURE dbo.ssp_dimproductsubcategory_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimProductSubcategory];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimProductSubcategory](
			[ProductSubcategoryKey] [int] IDENTITY(1,1) NOT NULL,
			[ProductSubcategoryAlternateKey] [int] NULL,
			[EnglishProductSubcategoryName] [nvarchar](50) NOT NULL,
			[SpanishProductSubcategoryName] [nvarchar](50) NOT NULL,
			[FrenchProductSubcategoryName] [nvarchar](50) NOT NULL,
			[ProductCategoryKey] [int] NULL,
		 CONSTRAINT [PK_DimProductSubcategory_ProductSubcategoryKey] PRIMARY KEY CLUSTERED 
		(
			[ProductSubcategoryKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [AK_DimProductSubcategory_ProductSubcategoryAlternateKey] UNIQUE NONCLUSTERED 
		(
			[ProductSubcategoryAlternateKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimProductSubcategory] ON;
	with cte as
	(
		SELECT [ProductSubcategoryKey]
			  ,[ProductSubcategoryAlternateKey]
			  ,[EnglishProductSubcategoryName]
			  ,[SpanishProductSubcategoryName]
			  ,[FrenchProductSubcategoryName]
			  ,[ProductCategoryKey]
		  FROM [AdventureWorksDW].[dbo].[DimProductSubcategory]
		)
		INSERT INTO [AdventureWorksDWH].[dbo].[DimProductSubcategory] 
			(
				[ProductSubcategoryKey]
			  ,[ProductSubcategoryAlternateKey]
			  ,[EnglishProductSubcategoryName]
			  ,[SpanishProductSubcategoryName]
			  ,[FrenchProductSubcategoryName]
			  ,[ProductCategoryKey]
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
