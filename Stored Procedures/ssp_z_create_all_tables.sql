USE [AdventureWorksDWH]
GO

/****** Object:  StoredProcedure [dbo].[ssp_dimdate_create_table]    Script Date: 5/27/2024 12:08:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ssp_create_all_tables] 
	@add_years INT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC [dbo].[ssp_dimaccount_create_table] 
	EXEC [dbo].[ssp_dimcurrency_create_table]
	EXEC [dbo].[ssp_dimcustomer_create_table]									@add_years
	EXEC [dbo].[ssp_dimdate_create_table]										@add_years
	EXEC [dbo].[ssp_dimdepartmentgroup_create_table]
	EXEC [dbo].[ssp_dimemployee_create_table]									@add_years
	EXEC [dbo].[ssp_dimgeography_create_table]
	EXEC [dbo].[ssp_dimorganization_create_table]
	EXEC [dbo].[ssp_dimproduct_create_table]									@add_years
	EXEC [dbo].[ssp_dimproductcategory_create_table]
	EXEC [dbo].[ssp_dimproductsubcategory_create_table]
	EXEC [dbo].[ssp_dimpromotion_create_table]									@add_years
	EXEC [dbo].[ssp_dimreseller_create_table]									@add_years
	EXEC [dbo].[ssp_dimsalesreason_create_table]
	EXEC [dbo].[ssp_dimsalesterritory_create_table]
	EXEC [dbo].[ssp_dimscenario_create_table]
	EXEC [dbo].[ssp_FactAdditionalInternationalProductDescription_create_table]
	EXEC [dbo].[ssp_FactCallCenter_create_table]								@add_years
	EXEC [dbo].[ssp_FactCurrencyRate_create_table]								@add_years
	EXEC [dbo].[ssp_FactFinance_create_table]									@add_years
	EXEC [dbo].[ssp_FactInternetSales_create_table]								@add_years
	EXEC [dbo].[ssp_FactInternetSalesReason_create_table]
	EXEC [dbo].[ssp_FactProductInventory_create_table]							@add_years
	EXEC [dbo].[ssp_FactResellerSales_create_table]								@add_years
	EXEC [dbo].[ssp_FactSalesQuota_create_table]								@add_years
	EXEC [dbo].[ssp_FactSurveyResponse_create_table]							@add_years
	EXEC [dbo].[ssp_NewFactCurrencyRate_create_table]							@add_years
	EXEC [dbo].[ssp_ProspectiveBuyer_create_table]

END
GO


