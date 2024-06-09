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
CREATE PROCEDURE dbo.ssp_dimdate_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;
    SET DATEFIRST 1;

	DROP TABLE IF EXISTS [dbo].[DimDate];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [AdventureWorksDWH].[dbo].[DimDate](
		[DateKey] [int] NOT NULL,
		[FullDateAlternateKey] [date] NOT NULL,
		[DayNumberOfWeek] [tinyint] NOT NULL,
		[EnglishDayNameOfWeek] [nvarchar](10) NOT NULL,
		[SpanishDayNameOfWeek] [nvarchar](10) NOT NULL,
		[FrenchDayNameOfWeek] [nvarchar](10) NOT NULL,
		[DayNumberOfMonth] [tinyint] NOT NULL,
		[DayNumberOfYear] [smallint] NOT NULL,
		[WeekNumberOfYear] [tinyint] NOT NULL,
		[EnglishMonthName] [nvarchar](10) NOT NULL,
		[SpanishMonthName] [nvarchar](10) NOT NULL,
		[FrenchMonthName] [nvarchar](10) NOT NULL,
		[MonthNumberOfYear] [tinyint] NOT NULL,
		[CalendarQuarter] [tinyint] NOT NULL,
		[CalendarYear] [smallint] NOT NULL,
		[CalendarSemester] [tinyint] NOT NULL,
		[FiscalQuarter] [tinyint] NOT NULL,
		[FiscalYear] [smallint] NOT NULL,
		[FiscalSemester] [tinyint] NOT NULL,
	 CONSTRAINT [PK_DimDate_DateKey] PRIMARY KEY CLUSTERED 
	(
		[DateKey] DESC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	with cte as
	(
		SELECT [DateKey] + @add_years * 10000 as [DateKey]
			,DATEADD(year, 10, [FullDateAlternateKey]) as [FullDateAlternateKey]
			,DATEPART(weekday, DATEADD(year, @add_years, [FullDateAlternateKey])) as [DayNumberOfWeek]
			,FORMAT(DATEADD(year, @add_years, [FullDateAlternateKey]), ''dddd'', ''en-gb'') [EnglishDayNameOfWeek]
			,[AdventureWorksDW].[dbo].CapitalizeFirstLetter(FORMAT(DATEADD(year, @add_years, [FullDateAlternateKey]), ''dddd'', ''es-es'')) as [SpanishDayNameOfWeek]
			,[AdventureWorksDW].[dbo].CapitalizeFirstLetter(FORMAT(DATEADD(year, @add_years, [FullDateAlternateKey]), ''dddd'', ''fr-FR'')) as [FrenchDayNameOfWeek]
			,DATEPART(day, DATEADD(year, @add_years, [FullDateAlternateKey])) as [DayNumberOfMonth]
			,DATEPART(DAYOFYEAR, DATEADD(year, @add_years, [FullDateAlternateKey])) [DayNumberOfYear]
			,DATEPART(WEEK, DATEADD(year, @add_years, [FullDateAlternateKey])) [WeekNumberOfYear]
			,FORMAT(DATEADD(year, @add_years, [FullDateAlternateKey]), ''MMMM'', ''en-gb'') as [EnglishMonthName]
			,[AdventureWorksDW].[dbo].CapitalizeFirstLetter(FORMAT(DATEADD(year, @add_years, [FullDateAlternateKey]), ''MMMM'', ''es-es'')) as [SpanishMonthName]
			,[AdventureWorksDW].[dbo].CapitalizeFirstLetter(FORMAT(DATEADD(year, @add_years, [FullDateAlternateKey]), ''MMMM'', ''fr-FR'')) as [FrenchMonthName]
			,DATEPART(MONTH, DATEADD(year, @add_years, [FullDateAlternateKey])) as [MonthNumberOfYear]
			,DATEPART(QUARTER, DATEADD(year, @add_years, [FullDateAlternateKey])) as [CalendarQuarter]
			,DATEPART(YEAR, DATEADD(year, @add_years, [FullDateAlternateKey])) as [CalendarYear]
			,case 
			when DATEPART(MONTH, DATEADD(year, @add_years, [FullDateAlternateKey])) < 7 then 1 else 2 
			end as [CalendarSemester]
			,case 
			when DATEPART(MONTH, DATEADD(year, @add_years, [FullDateAlternateKey])) in (9,10,11) then 1
			when DATEPART(MONTH, DATEADD(year, @add_years, [FullDateAlternateKey])) in (12,1,2) then 2
			when DATEPART(MONTH, DATEADD(year, @add_years, [FullDateAlternateKey])) in (3,4,5) then 3 
			else 4
			end as[FiscalQuarter]
			,case 
			when DATEPART(MONTH, DATEADD(year, @add_years, [FullDateAlternateKey])) in (9,10,11,12) 
			then DATEPART(YEAR, DATEADD(year, @add_years, [FullDateAlternateKey])) + 1 else DATEPART(YEAR, DATEADD(year, 10, [FullDateAlternateKey]))
			end as [FiscalYear]
			,case	
			when DATEPART(MONTH, DATEADD(year, @add_years, [FullDateAlternateKey])) in (9,10,11,12,1,2)
			then 1 else 2
			end as [FiscalSemester]
		FROM [AdventureWorksDW].[dbo].[DimDate]
	)
	INSERT INTO [AdventureWorksDWH].[dbo].[DimDate] 
		(
			[DateKey]
		  ,[FullDateAlternateKey]
		  ,[DayNumberOfWeek]
		  ,[EnglishDayNameOfWeek]
		  ,[SpanishDayNameOfWeek]
		  ,[FrenchDayNameOfWeek]
		  ,[DayNumberOfMonth]
		  ,[DayNumberOfYear]
		  ,[WeekNumberOfYear]
		  ,[EnglishMonthName]
		  ,[SpanishMonthName]
		  ,[FrenchMonthName]
		  ,[MonthNumberOfYear]
		  ,[CalendarQuarter]
		  ,[CalendarYear]
		  ,[CalendarSemester]
		  ,[FiscalQuarter]
		  ,[FiscalYear]
		  ,[FiscalSemester]	
		) 
	SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
