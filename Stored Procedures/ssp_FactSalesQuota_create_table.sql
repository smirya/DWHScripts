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
CREATE PROCEDURE dbo.ssp_FactSalesQuota_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactSalesQuota];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactSalesQuota](
			[SalesQuotaKey] [int] IDENTITY(1,1) NOT NULL,
			[EmployeeKey] [int] NOT NULL,
			[DateKey] [int] NOT NULL,
			[CalendarYear] [smallint] NOT NULL,
			[CalendarQuarter] [tinyint] NOT NULL,
			[SalesAmountQuota] [money] NOT NULL,
			[Date] [datetime] NULL,
		 CONSTRAINT [PK_FactSalesQuota_SalesQuotaKey] PRIMARY KEY CLUSTERED 
		(
			[SalesQuotaKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[FactSalesQuota] ON;
	with cte as
	(
		SELECT [SalesQuotaKey]
			  ,[EmployeeKey]
			  ,[DateKey] + @add_years * 10000 as [DateKey]
			  ,[CalendarYear] + @add_years as [CalendarYear]
			  ,[CalendarQuarter]
			  ,[SalesAmountQuota]
			  ,case when [Date] is not NULL then DATEADD(year, @add_years, [Date]) else NULL end as [Date]
		  FROM [AdventureWorksDW].[dbo].[FactSalesQuota]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactSalesQuota] 
			(
				[SalesQuotaKey]
				  ,[EmployeeKey]
				  ,[DateKey]
				  ,[CalendarYear]
				  ,[CalendarQuarter]
				  ,[SalesAmountQuota]
				  ,[Date]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
