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
CREATE PROCEDURE dbo.ssp_FactSurveyResponse_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactSurveyResponse];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactSurveyResponse](
			[SurveyResponseKey] [int] IDENTITY(1,1) NOT NULL,
			[DateKey] [int] NOT NULL,
			[CustomerKey] [int] NOT NULL,
			[ProductCategoryKey] [int] NOT NULL,
			[EnglishProductCategoryName] [nvarchar](50) NOT NULL,
			[ProductSubcategoryKey] [int] NOT NULL,
			[EnglishProductSubcategoryName] [nvarchar](50) NOT NULL,
			[Date] [datetime] NULL,
		 CONSTRAINT [PK_FactSurveyResponse_SurveyResponseKey] PRIMARY KEY CLUSTERED 
		(
			[SurveyResponseKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[FactSurveyResponse] ON;
	with cte as
	(
		SELECT [SurveyResponseKey]
			  ,[DateKey] + @add_years * 10000 as [DateKey]
			  ,[CustomerKey]
			  ,[ProductCategoryKey]
			  ,[EnglishProductCategoryName]
			  ,[ProductSubcategoryKey]
			  ,[EnglishProductSubcategoryName]
			  ,case when [Date] is not NULL then DATEADD(year, @add_years, [Date]) else NULL end as [Date]
		  FROM [AdventureWorksDW].[dbo].[FactSurveyResponse]
				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactSurveyResponse] 
			(
				[SurveyResponseKey]
			  ,[DateKey]
			  ,[CustomerKey]
			  ,[ProductCategoryKey]
			  ,[EnglishProductCategoryName]
			  ,[ProductSubcategoryKey]
			  ,[EnglishProductSubcategoryName]
			  ,[Date]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
