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
CREATE PROCEDURE dbo.ssp_dimreseller_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimReseller];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimReseller](
			[ResellerKey] [int] IDENTITY(1,1) NOT NULL,
			[GeographyKey] [int] NULL,
			[ResellerAlternateKey] [nvarchar](15) NULL,
			[Phone] [nvarchar](25) NULL,
			[BusinessType] [varchar](20) NOT NULL,
			[ResellerName] [nvarchar](50) NOT NULL,
			[NumberEmployees] [int] NULL,
			[OrderFrequency] [char](1) NULL,
			[OrderMonth] [tinyint] NULL,
			[FirstOrderYear] [int] NULL,
			[LastOrderYear] [int] NULL,
			[ProductLine] [nvarchar](50) NULL,
			[AddressLine1] [nvarchar](60) NULL,
			[AddressLine2] [nvarchar](60) NULL,
			[AnnualSales] [money] NULL,
			[BankName] [nvarchar](50) NULL,
			[MinPaymentType] [tinyint] NULL,
			[MinPaymentAmount] [money] NULL,
			[AnnualRevenue] [money] NULL,
			[YearOpened] [int] NULL,
		 CONSTRAINT [PK_DimReseller_ResellerKey] PRIMARY KEY CLUSTERED 
		(
			[ResellerKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [AK_DimReseller_ResellerAlternateKey] UNIQUE NONCLUSTERED 
		(
			[ResellerAlternateKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimReseller] ON;
	with cte as
	(
		SELECT [ResellerKey]
			  ,[GeographyKey]
			  ,[ResellerAlternateKey]
			  ,[Phone]
			  ,[BusinessType]
			  ,[ResellerName]
			  ,[NumberEmployees]
			  ,[OrderFrequency]
			  ,[OrderMonth]
			  ,case when [FirstOrderYear] is not NULL then [FirstOrderYear] + @add_years else [FirstOrderYear] end as [FirstOrderYear]
			  ,case when [LastOrderYear] is not NULL then [LastOrderYear] + @add_years else [LastOrderYear] end as [LastOrderYear]
			  ,[ProductLine]
			  ,[AddressLine1]
			  ,[AddressLine2]
			  ,[AnnualSales]
			  ,[BankName]
			  ,[MinPaymentType]
			  ,[MinPaymentAmount]
			  ,[AnnualRevenue]
			  ,[YearOpened]
		  FROM [AdventureWorksDW].[dbo].[DimReseller]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[DimReseller] 
			(
				[ResellerKey]
			  ,[GeographyKey]
			  ,[ResellerAlternateKey]
			  ,[Phone]
			  ,[BusinessType]
			  ,[ResellerName]
			  ,[NumberEmployees]
			  ,[OrderFrequency]
			  ,[OrderMonth]
			  ,[FirstOrderYear]
			  ,[LastOrderYear]
			  ,[ProductLine]
			  ,[AddressLine1]
			  ,[AddressLine2]
			  ,[AnnualSales]
			  ,[BankName]
			  ,[MinPaymentType]
			  ,[MinPaymentAmount]
			  ,[AnnualRevenue]
			  ,[YearOpened]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
