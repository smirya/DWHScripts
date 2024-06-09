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
CREATE PROCEDURE dbo.ssp_FactAdditionalInternationalProductDescription_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactAdditionalInternationalProductDescription];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactAdditionalInternationalProductDescription](
			[ProductKey] [int] NOT NULL,
			[CultureName] [nvarchar](50) NOT NULL,
			[ProductDescription] [nvarchar](max) NOT NULL,
		 CONSTRAINT [PK_FactAdditionalInternationalProductDescription_ProductKey_CultureName] PRIMARY KEY CLUSTERED 
		(
			[ProductKey] ASC,
			[CultureName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimScenario] ON;
	with cte as
	(
		SELECT [ProductKey]
			  ,[CultureName]
			  ,[ProductDescription]
		  FROM [AdventureWorksDW].[dbo].[FactAdditionalInternationalProductDescription]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactAdditionalInternationalProductDescription] 
			(
				[ProductKey]
			  ,[CultureName]
			  ,[ProductDescription]
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
