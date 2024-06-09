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
CREATE PROCEDURE dbo.ssp_dimproduct_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimProduct];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimProduct](
			[ProductKey] [int] IDENTITY(1,1) NOT NULL,
			[ProductAlternateKey] [nvarchar](25) NULL,
			[ProductSubcategoryKey] [int] NULL,
			[WeightUnitMeasureCode] [nchar](3) NULL,
			[SizeUnitMeasureCode] [nchar](3) NULL,
			[EnglishProductName] [nvarchar](50) NOT NULL,
			[SpanishProductName] [nvarchar](50) NOT NULL,
			[FrenchProductName] [nvarchar](50) NOT NULL,
			[StandardCost] [money] NULL,
			[FinishedGoodsFlag] [bit] NOT NULL,
			[Color] [nvarchar](15) NOT NULL,
			[SafetyStockLevel] [smallint] NULL,
			[ReorderPoint] [smallint] NULL,
			[ListPrice] [money] NULL,
			[Size] [nvarchar](50) NULL,
			[SizeRange] [nvarchar](50) NULL,
			[Weight] [float] NULL,
			[DaysToManufacture] [int] NULL,
			[ProductLine] [nchar](2) NULL,
			[DealerPrice] [money] NULL,
			[Class] [nchar](2) NULL,
			[Style] [nchar](2) NULL,
			[ModelName] [nvarchar](50) NULL,
			[LargePhoto] [varbinary](max) NULL,
			[EnglishDescription] [nvarchar](400) NULL,
			[FrenchDescription] [nvarchar](400) NULL,
			[ChineseDescription] [nvarchar](400) NULL,
			[ArabicDescription] [nvarchar](400) NULL,
			[HebrewDescription] [nvarchar](400) NULL,
			[ThaiDescription] [nvarchar](400) NULL,
			[GermanDescription] [nvarchar](400) NULL,
			[JapaneseDescription] [nvarchar](400) NULL,
			[TurkishDescription] [nvarchar](400) NULL,
			[StartDate] [datetime] NULL,
			[EndDate] [datetime] NULL,
			[Status] [nvarchar](7) NULL,
		 CONSTRAINT [PK_DimProduct_ProductKey] PRIMARY KEY CLUSTERED 
		(
			[ProductKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [AK_DimProduct_ProductAlternateKey_StartDate] UNIQUE NONCLUSTERED 
		(
			[ProductAlternateKey] ASC,
			[StartDate] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimProduct] ON;
	with cte as
	(
		SELECT [ProductKey]
		  ,[ProductAlternateKey]
		  ,[ProductSubcategoryKey]
		  ,[WeightUnitMeasureCode]
		  ,[SizeUnitMeasureCode]
		  ,[EnglishProductName]
		  ,[SpanishProductName]
		  ,[FrenchProductName]
		  ,[StandardCost]
		  ,[FinishedGoodsFlag]
		  ,[Color]
		  ,[SafetyStockLevel]
		  ,[ReorderPoint]
		  ,[ListPrice]
		  ,[Size]
		  ,[SizeRange]
		  ,[Weight]
		  ,[DaysToManufacture]
		  ,[ProductLine]
		  ,[DealerPrice]
		  ,[Class]
		  ,[Style]
		  ,[ModelName]
		  ,[LargePhoto]
		  ,[EnglishDescription]
		  ,[FrenchDescription]
		  ,[ChineseDescription]
		  ,[ArabicDescription]
		  ,[HebrewDescription]
		  ,[ThaiDescription]
		  ,[GermanDescription]
		  ,[JapaneseDescription]
		  ,[TurkishDescription]
		  ,case when [StartDate] is not NULL then DATEADD(year, @add_years, [StartDate]) else NULL end as [StartDate]
		  ,case when [EndDate] is not NULL then DATEADD(year, @add_years, [EndDate]) else NULL end as [EndDate]
		  ,[Status]
	  FROM [AdventureWorksDW].[dbo].[DimProduct]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[DimProduct] 
			(
				[ProductKey]
			  ,[ProductAlternateKey]
			  ,[ProductSubcategoryKey]
			  ,[WeightUnitMeasureCode]
			  ,[SizeUnitMeasureCode]
			  ,[EnglishProductName]
			  ,[SpanishProductName]
			  ,[FrenchProductName]
			  ,[StandardCost]
			  ,[FinishedGoodsFlag]
			  ,[Color]
			  ,[SafetyStockLevel]
			  ,[ReorderPoint]
			  ,[ListPrice]
			  ,[Size]
			  ,[SizeRange]
			  ,[Weight]
			  ,[DaysToManufacture]
			  ,[ProductLine]
			  ,[DealerPrice]
			  ,[Class]
			  ,[Style]
			  ,[ModelName]
			  ,[LargePhoto]
			  ,[EnglishDescription]
			  ,[FrenchDescription]
			  ,[ChineseDescription]
			  ,[ArabicDescription]
			  ,[HebrewDescription]
			  ,[ThaiDescription]
			  ,[GermanDescription]
			  ,[JapaneseDescription]
			  ,[TurkishDescription]
			  ,[StartDate]
			  ,[EndDate]
			  ,[Status]	
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
