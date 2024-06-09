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
CREATE PROCEDURE dbo.ssp_dimaccount_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimAccount];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimAccount](
			[AccountKey] [int] IDENTITY(1,1) NOT NULL,
			[ParentAccountKey] [int] NULL,
			[AccountCodeAlternateKey] [int] NULL,
			[ParentAccountCodeAlternateKey] [int] NULL,
			[AccountDescription] [nvarchar](50) NULL,
			[AccountType] [nvarchar](50) NULL,
			[Operator] [nvarchar](50) NULL,
			[CustomMembers] [nvarchar](300) NULL,
			[ValueType] [nvarchar](50) NULL,
			[CustomMemberOptions] [nvarchar](200) NULL,
		 CONSTRAINT [PK_DimAccount] PRIMARY KEY CLUSTERED 
		(
			[AccountKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimAccount] ON;
	with cte as
	(
		SELECT [AccountKey]
		  ,[ParentAccountKey]
		  ,[AccountCodeAlternateKey]
		  ,[ParentAccountCodeAlternateKey]
		  ,[AccountDescription]
		  ,[AccountType]
		  ,[Operator]
		  ,[CustomMembers]
		  ,[ValueType]
		  ,[CustomMemberOptions]
	  FROM [AdventureWorksDW].[dbo].[DimAccount]
	)
	INSERT INTO [AdventureWorksDWH].[dbo].[DimAccount] 
		(
			[AccountKey]
		  ,[ParentAccountKey]
		  ,[AccountCodeAlternateKey]
		  ,[ParentAccountCodeAlternateKey]
		  ,[AccountDescription]
		  ,[AccountType]
		  ,[Operator]
		  ,[CustomMembers]
		  ,[ValueType]
		  ,[CustomMemberOptions]	
		) 
	SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
