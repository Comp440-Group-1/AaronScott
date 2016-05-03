SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert new product
-- =============================================
CREATE PROCEDURE InsertNewProduct

	@productName	nchar(50),
	@productDescription	nchar(50)
AS
BEGIN TRY
	DECLARE @exist INT;
	DECLARE @total INT;
	SET NOCOUNT ON;
	SET @total = (SELECT COUNT(*) FROM Products);
	SET @exist = (SELECT COUNT(*) FROM Products WHERE productName = @productName);
	
	IF @exist > 0
		BEGIN
			PRINT N'Product already exists';
		END
	ELSE
		BEGIN
			INSERT INTO Products (productID, productName, productDescription, currentReleaseVersion) 
			SELECT (@total + 1), @productName, @productDescription, '0.0';
		END
END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO
