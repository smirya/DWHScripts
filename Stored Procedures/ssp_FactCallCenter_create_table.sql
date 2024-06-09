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
CREATE PROCEDURE dbo.ssp_FactCallCenter_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[FactCallCenter];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[FactCallCenter](
			[FactCallCenterID] [int] IDENTITY(1,1) NOT NULL,
			[DateKey] [int] NOT NULL,
			[WageType] [nvarchar](15) NOT NULL,
			[Shift] [nvarchar](20) NOT NULL,
			[LevelOneOperators] [smallint] NOT NULL,
			[LevelTwoOperators] [smallint] NOT NULL,
			[TotalOperators] [smallint] NOT NULL,
			[Calls] [int] NOT NULL,
			[AutomaticResponses] [int] NOT NULL,
			[Orders] [int] NOT NULL,
			[IssuesRaised] [smallint] NOT NULL,
			[AverageTimePerIssue] [smallint] NOT NULL,
			[ServiceGrade] [float] NOT NULL,
			[Date] [datetime] NULL,
		 CONSTRAINT [PK_FactCallCenter_FactCallCenterID] PRIMARY KEY CLUSTERED 
		(
			[FactCallCenterID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [AK_FactCallCenter_DateKey_Shift] UNIQUE NONCLUSTERED 
		(
			[DateKey] ASC,
			[Shift] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[FactCallCenter] ON;
	with cte as
	(
		SELECT [FactCallCenterID]
			  ,[DateKey] + @add_years * 10000 as [DateKey]
			  ,[WageType]
			  ,[Shift]
			  ,[LevelOneOperators]
			  ,[LevelTwoOperators]
			  ,[TotalOperators]
			  ,[Calls]
			  ,[AutomaticResponses]
			  ,[Orders]
			  ,[IssuesRaised]
			  ,[AverageTimePerIssue]
			  ,[ServiceGrade]
			  ,case when [Date] is not NULL then DATEADD(year, @add_years, [Date]) else NULL end as [Date]
		  FROM [AdventureWorksDW].[dbo].[FactCallCenter]

				)
				INSERT INTO [AdventureWorksDWH].[dbo].[FactCallCenter] 
			(
				[FactCallCenterID]
				  ,[DateKey]
				  ,[WageType]
				  ,[Shift]
				  ,[LevelOneOperators]
				  ,[LevelTwoOperators]
				  ,[TotalOperators]
				  ,[Calls]
				  ,[AutomaticResponses]
				  ,[Orders]
				  ,[IssuesRaised]
				  ,[AverageTimePerIssue]
				  ,[ServiceGrade]
				  ,[Date]
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
