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
CREATE PROCEDURE dbo.ssp_NewFactCurrencyRate_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[NewFactCurrencyRate];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[NewFactCurrencyRate](
			[AverageRate] [real] NULL,
			[CurrencyID] [nvarchar](3) NULL,
			[CurrencyDate] [date] NULL,
			[EndOfDayRate] [real] NULL,
			[CurrencyKey] [int] NULL,
			[DateKey] [int] NULL
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	with cte as
	(
		SELECT [AverageRate]
			  ,[CurrencyID]
			  ,case when [CurrencyDate] is not NULL then DATEADD(year, @add_years, [CurrencyDate]) else NULL end as [CurrencyDate]
			  ,[EndOfDayRate]
			  ,[CurrencyKey]
			  ,case when [DateKey] is not null then [DateKey] + @add_years * 10000  else NULL end as [DateKey]
		  FROM [AdventureWorksDW].[dbo].[NewFactCurrencyRate]
	)
	INSERT INTO [AdventureWorksDWH].[dbo].[NewFactCurrencyRate] 
		(
			[AverageRate]
			,[CurrencyID]
			,[CurrencyDate]
			,[EndOfDayRate]
			,[CurrencyKey]
			,[DateKey]
		) 
	SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
