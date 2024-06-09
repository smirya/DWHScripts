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
CREATE PROCEDURE dbo.ssp_dimsalesreason_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimSalesReason];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimSalesReason](
			[SalesReasonKey] [int] IDENTITY(1,1) NOT NULL,
			[SalesReasonAlternateKey] [int] NOT NULL,
			[SalesReasonName] [nvarchar](50) NOT NULL,
			[SalesReasonReasonType] [nvarchar](50) NOT NULL,
		 CONSTRAINT [PK_DimSalesReason_SalesReasonKey] PRIMARY KEY CLUSTERED 
		(
			[SalesReasonKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimSalesReason] ON;
	with cte as
	(
		SELECT [SalesReasonKey]
			  ,[SalesReasonAlternateKey]
			  ,[SalesReasonName]
			  ,[SalesReasonReasonType]
		  FROM [AdventureWorksDW].[dbo].[DimSalesReason]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[DimSalesReason] 
			(
				[SalesReasonKey]
			  ,[SalesReasonAlternateKey]
			  ,[SalesReasonName]
			  ,[SalesReasonReasonType]
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
