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
CREATE PROCEDURE dbo.ssp_FactFinance_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactFinance];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactFinance](
			[FinanceKey] [int] IDENTITY(1,1) NOT NULL,
			[DateKey] [int] NOT NULL,
			[OrganizationKey] [int] NOT NULL,
			[DepartmentGroupKey] [int] NOT NULL,
			[ScenarioKey] [int] NOT NULL,
			[AccountKey] [int] NOT NULL,
			[Amount] [float] NOT NULL,
			[Date] [datetime] NULL
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[FactFinance] ON;
	with cte as
	(
		SELECT [FinanceKey]
			  ,[DateKey] + @add_years * 10000 as [DateKey]
			  ,[OrganizationKey]
			  ,[DepartmentGroupKey]
			  ,[ScenarioKey]
			  ,[AccountKey]
			  ,[Amount]
			  ,case when [Date] is not NULL then DATEADD(year, @add_years, [Date]) else NULL end as [Date]
		  FROM [AdventureWorksDW].[dbo].[FactFinance]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactFinance] 
			(
				[FinanceKey]
				  ,[DateKey]
				  ,[OrganizationKey]
				  ,[DepartmentGroupKey]
				  ,[ScenarioKey]
				  ,[AccountKey]
				  ,[Amount]
				  ,[Date]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
