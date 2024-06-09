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
CREATE PROCEDURE dbo.ssp_FactProductInventory_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactProductInventory];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactProductInventory](
			[ProductKey] [int] NOT NULL,
			[DateKey] [int] NOT NULL,
			[MovementDate] [date] NOT NULL,
			[UnitCost] [money] NOT NULL,
			[UnitsIn] [int] NOT NULL,
			[UnitsOut] [int] NOT NULL,
			[UnitsBalance] [int] NOT NULL,
		 CONSTRAINT [PK_FactProductInventory] PRIMARY KEY CLUSTERED 
		(
			[ProductKey] ASC,
			[DateKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	with cte as
	(
		SELECT [ProductKey]
			  ,[DateKey] + @add_years * 10000 as [DateKey]	 
			  ,case when [MovementDate] is not NULL then DATEADD(year, @add_years, [MovementDate]) else NULL end as [MovementDate]
			  ,[UnitCost]
			  ,[UnitsIn]
			  ,[UnitsOut]
			  ,[UnitsBalance]
		  FROM [AdventureWorksDW].[dbo].[FactProductInventory]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactProductInventory] 
			(
				[ProductKey]
			  ,[DateKey]
			  ,[MovementDate]
			  ,[UnitCost]
			  ,[UnitsIn]
			  ,[UnitsOut]
			  ,[UnitsBalance]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
