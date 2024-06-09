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
CREATE PROCEDURE dbo.ssp_dimemployee_create_table 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS [dbo].[DimEmployee];
	
	DECLARE @create_sql nvarchar(max) =
	'
		CREATE TABLE [dbo].[DimEmployee](
			[EmployeeKey] [int] IDENTITY(1,1) NOT NULL,
			[ParentEmployeeKey] [int] NULL,
			[EmployeeNationalIDAlternateKey] [nvarchar](15) NULL,
			[ParentEmployeeNationalIDAlternateKey] [nvarchar](15) NULL,
			[SalesTerritoryKey] [int] NULL,
			[FirstName] [nvarchar](50) NOT NULL,
			[LastName] [nvarchar](50) NOT NULL,
			[MiddleName] [nvarchar](50) NULL,
			[NameStyle] [bit] NOT NULL,
			[Title] [nvarchar](50) NULL,
			[HireDate] [date] NULL,
			[BirthDate] [date] NULL,
			[LoginID] [nvarchar](256) NULL,
			[EmailAddress] [nvarchar](50) NULL,
			[Phone] [nvarchar](25) NULL,
			[MaritalStatus] [nchar](1) NULL,
			[EmergencyContactName] [nvarchar](50) NULL,
			[EmergencyContactPhone] [nvarchar](25) NULL,
			[SalariedFlag] [bit] NULL,
			[Gender] [nchar](1) NULL,
			[PayFrequency] [tinyint] NULL,
			[BaseRate] [money] NULL,
			[VacationHours] [smallint] NULL,
			[SickLeaveHours] [smallint] NULL,
			[CurrentFlag] [bit] NOT NULL,
			[SalesPersonFlag] [bit] NOT NULL,
			[DepartmentName] [nvarchar](50) NULL,
			[StartDate] [date] NULL,
			[EndDate] [date] NULL,
			[Status] [nvarchar](50) NULL,
			[EmployeePhoto] [varbinary](max) NULL,
		 CONSTRAINT [PK_DimEmployee_EmployeeKey] PRIMARY KEY CLUSTERED 
		(
			[EmployeeKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	'
	EXEC(@create_sql)
	DECLARE @insert_sql nvarchar(max) = 
	'
	SET IDENTITY_INSERT [AdventureWorksDWH].[dbo].[DimEmployee] ON;
	with cte as
	(
		SELECT [EmployeeKey]
		  ,[ParentEmployeeKey]
		  ,[EmployeeNationalIDAlternateKey]
		  ,[ParentEmployeeNationalIDAlternateKey]
		  ,[SalesTerritoryKey]
		  ,[FirstName]
		  ,[LastName]
		  ,[MiddleName]
		  ,[NameStyle]
		  ,[Title]
		  ,[HireDate]
		  ,[BirthDate]
		  ,[LoginID]
		  ,[EmailAddress]
		  ,[Phone]
		  ,[MaritalStatus]
		  ,[EmergencyContactName]
		  ,[EmergencyContactPhone]
		  ,[SalariedFlag]
		  ,[Gender]
		  ,[PayFrequency]
		  ,[BaseRate]
		  ,[VacationHours]
		  ,[SickLeaveHours]
		  ,[CurrentFlag]
		  ,[SalesPersonFlag]
		  ,[DepartmentName]
		  ,case when [StartDate] is not NULL then DATEADD(year, @add_years, [StartDate]) else NULL end as [StartDate]
		  ,case when [EndDate] is not NULL then DATEADD(year, @add_years, [EndDate]) else NULL end as [EndDate]
		  ,[Status]
		  ,[EmployeePhoto]
	  FROM [AdventureWorksDW].[dbo].[DimEmployee]
		)
		INSERT INTO [AdventureWorksDWH].[dbo].[DimEmployee] 
			(
				[EmployeeKey]
		  ,[ParentEmployeeKey]
		  ,[EmployeeNationalIDAlternateKey]
		  ,[ParentEmployeeNationalIDAlternateKey]
		  ,[SalesTerritoryKey]
		  ,[FirstName]
		  ,[LastName]
		  ,[MiddleName]
		  ,[NameStyle]
		  ,[Title]
		  ,[HireDate]
		  ,[BirthDate]
		  ,[LoginID]
		  ,[EmailAddress]
		  ,[Phone]
		  ,[MaritalStatus]
		  ,[EmergencyContactName]
		  ,[EmergencyContactPhone]
		  ,[SalariedFlag]
		  ,[Gender]
		  ,[PayFrequency]
		  ,[BaseRate]
		  ,[VacationHours]
		  ,[SickLeaveHours]
		  ,[CurrentFlag]
		  ,[SalesPersonFlag]
		  ,[DepartmentName]
		  ,[StartDate]
		  ,[EndDate]
		  ,[Status]
		  ,[EmployeePhoto]	
			) 
		SELECT * FROM cte
	'
	SET @insert_sql = REPLACE(@insert_sql, '@add_years', @add_years)
	EXEC(@insert_sql)

END
GO
