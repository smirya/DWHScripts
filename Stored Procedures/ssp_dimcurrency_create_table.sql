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
CREATE PROCEDURE dbo.ssp_dimcurrency_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimCurrency];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimCurrency](
			[CurrencyKey] [int] IDENTITY(1,1) NOT NULL,
			[CurrencyAlternateKey] [nchar](3) NOT NULL,
			[CurrencyName] [nvarchar](50) NOT NULL,
		 CONSTRAINT [PK_DimCurrency_CurrencyKey] PRIMARY KEY CLUSTERED 
		(
			[CurrencyKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimCurrency] ON;
	with cte as
	(
		SELECT [CurrencyKey]
		  ,[CurrencyAlternateKey]
		  ,[CurrencyName]
	  FROM [AdventureWorksDW].[dbo].[DimCurrency]
	)
	INSERT INTO [AdventureWorksDWH].[dbo].[DimCurrency] 
		(
			[CurrencyKey]
		  ,[CurrencyAlternateKey]
		  ,[CurrencyName]	
		) 
	SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
