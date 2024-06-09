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
CREATE PROCEDURE dbo.ssp_dimproductcategory_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimProductCategory];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimProductCategory](
			[ProductCategoryKey] [int] IDENTITY(1,1) NOT NULL,
			[ProductCategoryAlternateKey] [int] NULL,
			[EnglishProductCategoryName] [nvarchar](50) NOT NULL,
			[SpanishProductCategoryName] [nvarchar](50) NOT NULL,
			[FrenchProductCategoryName] [nvarchar](50) NOT NULL,
		 CONSTRAINT [PK_DimProductCategory_ProductCategoryKey] PRIMARY KEY CLUSTERED 
		(
			[ProductCategoryKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [AK_DimProductCategory_ProductCategoryAlternateKey] UNIQUE NONCLUSTERED 
		(
			[ProductCategoryAlternateKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimProductCategory] ON;
	with cte as
	(
		SELECT [ProductCategoryKey]
			  ,[ProductCategoryAlternateKey]
			  ,[EnglishProductCategoryName]
			  ,[SpanishProductCategoryName]
			  ,[FrenchProductCategoryName]
		  FROM [AdventureWorksDW].[dbo].[DimProductCategory]
		)
		INSERT INTO [AdventureWorksDWH].[dbo].[DimProductCategory] 
			(
				[ProductCategoryKey]
				  ,[ProductCategoryAlternateKey]
				  ,[EnglishProductCategoryName]
				  ,[SpanishProductCategoryName]
				  ,[FrenchProductCategoryName]
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
