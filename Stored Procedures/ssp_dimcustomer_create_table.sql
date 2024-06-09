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
CREATE PROCEDURE dbo.ssp_dimcustomer_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimCustomer];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimCustomer](
			[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
			[GeographyKey] [int] NULL,
			[CustomerAlternateKey] [nvarchar](15) NOT NULL,
			[Title] [nvarchar](8) NULL,
			[FirstName] [nvarchar](50) NULL,
			[MiddleName] [nvarchar](50) NULL,
			[LastName] [nvarchar](50) NULL,
			[NameStyle] [bit] NULL,
			[BirthDate] [date] NULL,
			[MaritalStatus] [nchar](1) NULL,
			[Suffix] [nvarchar](10) NULL,
			[Gender] [nvarchar](1) NULL,
			[EmailAddress] [nvarchar](50) NULL,
			[YearlyIncome] [money] NULL,
			[TotalChildren] [tinyint] NULL,
			[NumberChildrenAtHome] [tinyint] NULL,
			[EnglishEducation] [nvarchar](40) NULL,
			[SpanishEducation] [nvarchar](40) NULL,
			[FrenchEducation] [nvarchar](40) NULL,
			[EnglishOccupation] [nvarchar](100) NULL,
			[SpanishOccupation] [nvarchar](100) NULL,
			[FrenchOccupation] [nvarchar](100) NULL,
			[HouseOwnerFlag] [nchar](1) NULL,
			[NumberCarsOwned] [tinyint] NULL,
			[AddressLine1] [nvarchar](120) NULL,
			[AddressLine2] [nvarchar](120) NULL,
			[Phone] [nvarchar](20) NULL,
			[DateFirstPurchase] [date] NULL,
			[CommuteDistance] [nvarchar](15) NULL,
		 CONSTRAINT [PK_DimCustomer_CustomerKey] PRIMARY KEY CLUSTERED 
		(
			[CustomerKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimCustomer] ON;
	with cte as
	(
		SELECT [CustomerKey]
		  ,[GeographyKey]
		  ,[CustomerAlternateKey]
		  ,[Title]
		  ,[FirstName]
		  ,[MiddleName]
		  ,[LastName]
		  ,[NameStyle]
		  ,[BirthDate]
		  ,[MaritalStatus]
		  ,[Suffix]
		  ,[Gender]
		  ,[EmailAddress]
		  ,[YearlyIncome]
		  ,[TotalChildren]
		  ,[NumberChildrenAtHome]
		  ,[EnglishEducation]
		  ,[SpanishEducation]
		  ,[FrenchEducation]
		  ,[EnglishOccupation]
		  ,[SpanishOccupation]
		  ,[FrenchOccupation]
		  ,[HouseOwnerFlag]
		  ,[NumberCarsOwned]
		  ,[AddressLine1]
		  ,[AddressLine2]
		  ,[Phone]
		  ,case when [DateFirstPurchase] is not NULL then DATEADD(year, @add_years, [DateFirstPurchase]) else NULL end as [DateFirstPurchase]
		  ,[CommuteDistance]
	  FROM [AdventureWorksDW].[dbo].[DimCustomer]
		)
		INSERT INTO [AdventureWorksDWH].[dbo].[DimCustomer] 
			(
				[CustomerKey]
			  ,[GeographyKey]
			  ,[CustomerAlternateKey]
			  ,[Title]
			  ,[FirstName]
			  ,[MiddleName]
			  ,[LastName]
			  ,[NameStyle]
			  ,[BirthDate]
			  ,[MaritalStatus]
			  ,[Suffix]
			  ,[Gender]
			  ,[EmailAddress]
			  ,[YearlyIncome]
			  ,[TotalChildren]
			  ,[NumberChildrenAtHome]
			  ,[EnglishEducation]
			  ,[SpanishEducation]
			  ,[FrenchEducation]
			  ,[EnglishOccupation]
			  ,[SpanishOccupation]
			  ,[FrenchOccupation]
			  ,[HouseOwnerFlag]
			  ,[NumberCarsOwned]
			  ,[AddressLine1]
			  ,[AddressLine2]
			  ,[Phone]
			  ,[DateFirstPurchase]
			  ,[CommuteDistance]	
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
