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
CREATE PROCEDURE dbo.ssp_dimdepartmentgroup_create_table 
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimDepartmentGroup];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimDepartmentGroup](
			[DepartmentGroupKey] [int] IDENTITY(1,1) NOT NULL,
			[ParentDepartmentGroupKey] [int] NULL,
			[DepartmentGroupName] [nvarchar](50) NULL,
		 CONSTRAINT [PK_DimDepartmentGroup] PRIMARY KEY CLUSTERED 
		(
			[DepartmentGroupKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimDepartmentGroup] ON;
	with cte as
	(
		SELECT [DepartmentGroupKey]
			  ,[ParentDepartmentGroupKey]
			  ,[DepartmentGroupName]
		  FROM [AdventureWorksDW].[dbo].[DimDepartmentGroup]
		)
		INSERT INTO [AdventureWorksDWH].[dbo].[DimDepartmentGroup] 
			(
				[DepartmentGroupKey]
			  ,[ParentDepartmentGroupKey]
			  ,[DepartmentGroupName]	
			) 
		SELECT * FROM cte
	'
	EXEC(@insert_sql)

END
GO
