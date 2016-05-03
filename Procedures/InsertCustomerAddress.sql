SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's address
-- =============================================
CREATE PROCEDURE InsertCustomerAddress
	
	@customerID	int,
	@customerAddress	nchar(95),
	@customerCountry	nchar(70),
	@customerProvince	nchar(35),
	@customerCity	nchar(35),
	@customerPostalCode	nchar(12)

AS
BEGIN TRY 
	DECLARE @exist INT;
	SET NOCOUNT ON;
	SET @exist = (SELECT COUNT(*)  FROM CustomerAddress WHERE customerID = @customerID);
	
	IF @exist > 0
		BEGIN
			PRINT N'Address Already Exists, please update instead';
		END
	ELSE
		BEGIN
			INSERT INTO CustomerAddress (customerID, customerAddress, customerCountry, customerProvince, customerCity, customerPostalCode) 
			SELECT  @customerID, @customerAddress, @customerCountry, @customerProvince, @customerCity, @customerPostalCode;
		END
END TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO