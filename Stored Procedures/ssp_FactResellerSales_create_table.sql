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
CREATE PROCEDURE dbo.ssp_FactResellerSales_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactResellerSales];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactResellerSales](
			[ProductKey] [int] NOT NULL,
			[OrderDateKey] [int] NOT NULL,
			[DueDateKey] [int] NOT NULL,
			[ShipDateKey] [int] NOT NULL,
			[ResellerKey] [int] NOT NULL,
			[EmployeeKey] [int] NOT NULL,
			[PromotionKey] [int] NOT NULL,
			[CurrencyKey] [int] NOT NULL,
			[SalesTerritoryKey] [int] NOT NULL,
			[SalesOrderNumber] [nvarchar](20) NOT NULL,
			[SalesOrderLineNumber] [tinyint] NOT NULL,
			[RevisionNumber] [tinyint] NULL,
			[OrderQuantity] [smallint] NULL,
			[UnitPrice] [money] NULL,
			[ExtendedAmount] [money] NULL,
			[UnitPriceDiscountPct] [float] NULL,
			[DiscountAmount] [float] NULL,
			[ProductStandardCost] [money] NULL,
			[TotalProductCost] [money] NULL,
			[SalesAmount] [money] NULL,
			[TaxAmt] [money] NULL,
			[Freight] [money] NULL,
			[CarrierTrackingNumber] [nvarchar](25) NULL,
			[CustomerPONumber] [nvarchar](25) NULL,
			[OrderDate] [datetime] NULL,
			[DueDate] [datetime] NULL,
			[ShipDate] [datetime] NULL,
		 CONSTRAINT [PK_FactResellerSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED 
		(
			[SalesOrderNumber] ASC,
			[SalesOrderLineNumber] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	with cte as
	(
		SELECT [ProductKey]
			  ,[OrderDateKey] + @add_years * 10000 as [OrderDateKey]
			  ,[DueDateKey] + @add_years * 10000 as [DueDateKey]
			  ,[ShipDateKey] + @add_years * 10000 as [ShipDateKey]
			  ,[ResellerKey]
			  ,[EmployeeKey]
			  ,[PromotionKey]
			  ,[CurrencyKey]
			  ,[SalesTerritoryKey]
			  ,[SalesOrderNumber]
			  ,[SalesOrderLineNumber]
			  ,[RevisionNumber]
			  ,[OrderQuantity]
			  ,[UnitPrice]
			  ,[ExtendedAmount]
			  ,[UnitPriceDiscountPct]
			  ,[DiscountAmount]
			  ,[ProductStandardCost]
			  ,[TotalProductCost]
			  ,[SalesAmount]
			  ,[TaxAmt]
			  ,[Freight]
			  ,[CarrierTrackingNumber]
			  ,[CustomerPONumber]
			  ,case when [OrderDate] is not NULL then DATEADD(year, @add_years, [OrderDate]) else NULL end as [OrderDate]
			  ,case when [DueDate] is not NULL then DATEADD(year, @add_years, [DueDate]) else NULL end as [DueDate]
			  ,case when [ShipDate] is not NULL then DATEADD(year, @add_years, [ShipDate]) else NULL end as [ShipDate]
		  FROM [AdventureWorksDW].[dbo].[FactResellerSales]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactResellerSales] 
			(
				[ProductKey]
				  ,[OrderDateKey]
				  ,[DueDateKey]
				  ,[ShipDateKey]
				  ,[ResellerKey]
				  ,[EmployeeKey]
				  ,[PromotionKey]
				  ,[CurrencyKey]
				  ,[SalesTerritoryKey]
				  ,[SalesOrderNumber]
				  ,[SalesOrderLineNumber]
				  ,[RevisionNumber]
				  ,[OrderQuantity]
				  ,[UnitPrice]
				  ,[ExtendedAmount]
				  ,[UnitPriceDiscountPct]
				  ,[DiscountAmount]
				  ,[ProductStandardCost]
				  ,[TotalProductCost]
				  ,[SalesAmount]
				  ,[TaxAmt]
				  ,[Freight]
				  ,[CarrierTrackingNumber]
				  ,[CustomerPONumber]
				  ,[OrderDate]
				  ,[DueDate]
				  ,[ShipDate]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
