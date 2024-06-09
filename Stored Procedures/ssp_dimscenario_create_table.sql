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
CREATE PROCEDURE dbo.ssp_dimscenario_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimScenario];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimScenario](
			[ScenarioKey] [int] IDENTITY(1,1) NOT NULL,
			[ScenarioName] [nvarchar](50) NULL,
		 CONSTRAINT [PK_DimScenario] PRIMARY KEY CLUSTERED 
		(
			[ScenarioKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimScenario] ON;
	with cte as
	(
		SELECT [ScenarioKey]
			  ,[ScenarioName]
		  FROM [AdventureWorksDW].[dbo].[DimScenario]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[DimScenario] 
			(
				[ScenarioKey]
			  ,[ScenarioName]
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
