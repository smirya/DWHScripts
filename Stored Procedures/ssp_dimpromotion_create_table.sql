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
CREATE PROCEDURE dbo.ssp_dimpromotion_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimPromotion];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimPromotion](
			[PromotionKey] [int] IDENTITY(1,1) NOT NULL,
			[PromotionAlternateKey] [int] NULL,
			[EnglishPromotionName] [nvarchar](255) NULL,
			[SpanishPromotionName] [nvarchar](255) NULL,
			[FrenchPromotionName] [nvarchar](255) NULL,
			[DiscountPct] [float] NULL,
			[EnglishPromotionType] [nvarchar](50) NULL,
			[SpanishPromotionType] [nvarchar](50) NULL,
			[FrenchPromotionType] [nvarchar](50) NULL,
			[EnglishPromotionCategory] [nvarchar](50) NULL,
			[SpanishPromotionCategory] [nvarchar](50) NULL,
			[FrenchPromotionCategory] [nvarchar](50) NULL,
			[StartDate] [datetime] NOT NULL,
			[EndDate] [datetime] NULL,
			[MinQty] [int] NULL,
			[MaxQty] [int] NULL,
		 CONSTRAINT [PK_DimPromotion_PromotionKey] PRIMARY KEY CLUSTERED 
		(
			[PromotionKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [AK_DimPromotion_PromotionAlternateKey] UNIQUE NONCLUSTERED 
		(
			[PromotionAlternateKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimPromotion] ON;
	with cte as
	(
		SELECT [PromotionKey]
			  ,[PromotionAlternateKey]
			  ,[EnglishPromotionName]
			  ,[SpanishPromotionName]
			  ,[FrenchPromotionName]
			  ,[DiscountPct]
			  ,[EnglishPromotionType]
			  ,[SpanishPromotionType]
			  ,[FrenchPromotionType]
			  ,[EnglishPromotionCategory]
			  ,[SpanishPromotionCategory]
			  ,[FrenchPromotionCategory]
			  ,case when [StartDate] is not NULL then DATEADD(year, @add_years, [StartDate]) else NULL end as [StartDate]
			  ,case when [EndDate] is not NULL then DATEADD(year, @add_years, [EndDate]) else NULL end as [EndDate]
			  ,[MinQty]
			  ,[MaxQty]
		  FROM [AdventureWorksDW].[dbo].[DimPromotion]
		)
		INSERT INTO [AdventureWorksDWH].[dbo].[DimPromotion] 
			(
				[PromotionKey]
			  ,[PromotionAlternateKey]
			  ,[EnglishPromotionName]
			  ,[SpanishPromotionName]
			  ,[FrenchPromotionName]
			  ,[DiscountPct]
			  ,[EnglishPromotionType]
			  ,[SpanishPromotionType]
			  ,[FrenchPromotionType]
			  ,[EnglishPromotionCategory]
			  ,[SpanishPromotionCategory]
			  ,[FrenchPromotionCategory]
			  ,[StartDate]
			  ,[EndDate]
			  ,[MinQty]
			  ,[MaxQty]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
