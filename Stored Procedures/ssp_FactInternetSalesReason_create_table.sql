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
CREATE PROCEDURE dbo.ssp_FactInternetSalesReason_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactInternetSalesReason];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactInternetSalesReason](
			[SalesOrderNumber] [nvarchar](20) NOT NULL,
			[SalesOrderLineNumber] [tinyint] NOT NULL,
			[SalesReasonKey] [int] NOT NULL,
		 CONSTRAINT [PK_FactInternetSalesReason_SalesOrderNumber_SalesOrderLineNumber_SalesReasonKey] PRIMARY KEY CLUSTERED 
		(
			[SalesOrderNumber] ASC,
			[SalesOrderLineNumber] ASC,
			[SalesReasonKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	with cte as
	(
		SELECT [SalesOrderNumber]
			  ,[SalesOrderLineNumber]
			  ,[SalesReasonKey]
		  FROM [AdventureWorksDW].[dbo].[FactInternetSalesReason]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactInternetSalesReason] 
			(
				[SalesOrderNumber]
			  ,[SalesOrderLineNumber]
			  ,[SalesReasonKey]
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
