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
CREATE PROCEDURE dbo.ssp_dimorganization_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[dimorganization];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimOrganization](
			[OrganizationKey] [int] IDENTITY(1,1) NOT NULL,
			[ParentOrganizationKey] [int] NULL,
			[PercentageOfOwnership] [nvarchar](16) NULL,
			[OrganizationName] [nvarchar](50) NULL,
			[CurrencyKey] [int] NULL,
		 CONSTRAINT [PK_DimOrganization] PRIMARY KEY CLUSTERED 
		(
			[OrganizationKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimOrganization] ON;
	with cte as
	(
		SELECT [OrganizationKey]
			  ,[ParentOrganizationKey]
			  ,[PercentageOfOwnership]
			  ,[OrganizationName]
			  ,[CurrencyKey]
		  FROM [AdventureWorksDW].[dbo].[DimOrganization]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[DimOrganization] 
			(
				[OrganizationKey]
			  ,[ParentOrganizationKey]
			  ,[PercentageOfOwnership]
			  ,[OrganizationName]
			  ,[CurrencyKey]	
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
