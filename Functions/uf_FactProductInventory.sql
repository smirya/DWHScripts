SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION uf_FactProductInventory 
(
	@dateKeyFrom	INT,
	@dateKeyTo		INT
)
RETURNS 
@result TABLE 
(
	[ProductKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[UnitsIn] [int] NOT NULL,
	[UnitsOut] [int] NOT NULL,
	[UnitsBalance] [int] NOT NULL
)
AS
BEGIN
	
	IF (@dateKeyFrom = NULL) 
	BEGIN
		SELECT 
			@dateKeyFrom = MIN([DateKey]) 
		FROM [AdventureWorksDWH].[dbo].[FactProductInventory]
	END

	IF (@dateKeyTo = NULL) 
	BEGIN
		SELECT 
			@dateKeyFrom = MAX([DateKey]) 
		FROM [AdventureWorksDWH].[dbo].[FactProductInventory]
	END

	INSERT INTO @result
	SELECT
		[ProductKey]
		,[DateKey]
		,[UnitCost]
		,[UnitsIn]
		,[UnitsOut]
		,[UnitsBalance]
	FROM [AdventureWorksDWH].[dbo].[FactProductInventory]
	WHERE [DateKey] BETWEEN @dateKeyFrom AND @dateKeyTo

	RETURN 
END
GO