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
CREATE PROCEDURE dbo.ssp_FactCurrencyRate_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactCurrencyRate];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactCurrencyRate](
			[CurrencyKey] [int] NOT NULL,
			[DateKey] [int] NOT NULL,
			[AverageRate] [float] NOT NULL,
			[EndOfDayRate] [float] NOT NULL,
			[Date] [datetime] NULL,
		 CONSTRAINT [PK_FactCurrencyRate_CurrencyKey_DateKey] PRIMARY KEY CLUSTERED 
		(
			[CurrencyKey] ASC,
			[DateKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	with cte as
	(
		SELECT [CurrencyKey]
		  ,[DateKey] + @add_years * 10000 as [DateKey]
		  ,[AverageRate]
		  ,[EndOfDayRate]
		  ,case when [Date] is not NULL then DATEADD(year, @add_years, [Date]) else NULL end as [Date]
	  FROM [AdventureWorksDW].[dbo].[FactCurrencyRate]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactCurrencyRate] 
			(
				[CurrencyKey]
				  ,[DateKey]
				  ,[AverageRate]
				  ,[EndOfDayRate]
				  ,[Date]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
