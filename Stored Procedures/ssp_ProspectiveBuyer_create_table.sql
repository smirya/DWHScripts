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
CREATE PROCEDURE dbo.ssp_ProspectiveBuyer_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[ProspectiveBuyer];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[ProspectiveBuyer](
			[ProspectiveBuyerKey] [int] IDENTITY(1,1) NOT NULL,
			[ProspectAlternateKey] [nvarchar](15) NULL,
			[FirstName] [nvarchar](50) NULL,
			[MiddleName] [nvarchar](50) NULL,
			[LastName] [nvarchar](50) NULL,
			[BirthDate] [datetime] NULL,
			[MaritalStatus] [nchar](1) NULL,
			[Gender] [nvarchar](1) NULL,
			[EmailAddress] [nvarchar](50) NULL,
			[YearlyIncome] [money] NULL,
			[TotalChildren] [tinyint] NULL,
			[NumberChildrenAtHome] [tinyint] NULL,
			[Education] [nvarchar](40) NULL,
			[Occupation] [nvarchar](100) NULL,
			[HouseOwnerFlag] [nchar](1) NULL,
			[NumberCarsOwned] [tinyint] NULL,
			[AddressLine1] [nvarchar](120) NULL,
			[AddressLine2] [nvarchar](120) NULL,
			[City] [nvarchar](30) NULL,
			[StateProvinceCode] [nvarchar](3) NULL,
			[PostalCode] [nvarchar](15) NULL,
			[Phone] [nvarchar](20) NULL,
			[Salutation] [nvarchar](8) NULL,
			[Unknown] [int] NULL,
		 CONSTRAINT [PK_ProspectiveBuyer_ProspectiveBuyerKey] PRIMARY KEY CLUSTERED 
		(
			[ProspectiveBuyerKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[ProspectiveBuyer] ON;
	with cte as
	(
		SELECT [ProspectiveBuyerKey]
			  ,[ProspectAlternateKey]
			  ,[FirstName]
			  ,[MiddleName]
			  ,[LastName]
			  ,[BirthDate]
			  ,[MaritalStatus]
			  ,[Gender]
			  ,[EmailAddress]
			  ,[YearlyIncome]
			  ,[TotalChildren]
			  ,[NumberChildrenAtHome]
			  ,[Education]
			  ,[Occupation]
			  ,[HouseOwnerFlag]
			  ,[NumberCarsOwned]
			  ,[AddressLine1]
			  ,[AddressLine2]
			  ,[City]
			  ,[StateProvinceCode]
			  ,[PostalCode]
			  ,[Phone]
			  ,[Salutation]
			  ,[Unknown]
		  FROM [AdventureWorksDW].[dbo].[ProspectiveBuyer]

	)
	INSERT INTO [AdventureWorksDWH].[dbo].[ProspectiveBuyer] 
		(
			[ProspectiveBuyerKey]
			  ,[ProspectAlternateKey]
			  ,[FirstName]
			  ,[MiddleName]
			  ,[LastName]
			  ,[BirthDate]
			  ,[MaritalStatus]
			  ,[Gender]
			  ,[EmailAddress]
			  ,[YearlyIncome]
			  ,[TotalChildren]
			  ,[NumberChildrenAtHome]
			  ,[Education]
			  ,[Occupation]
			  ,[HouseOwnerFlag]
			  ,[NumberCarsOwned]
			  ,[AddressLine1]
			  ,[AddressLine2]
			  ,[City]
			  ,[StateProvinceCode]
			  ,[PostalCode]
			  ,[Phone]
			  ,[Salutation]
			  ,[Unknown]
		) 
	SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
