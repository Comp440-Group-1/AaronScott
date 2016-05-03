SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's company data
-- =============================================
CREATE PROCEDURE InsertCustomerCompany
	
	@customerID	int,
	@companyName	nchar(50),
	@companyPhoneNumber	nchar(15),
	@companyAddress	nchar(95),
	@companyCountry	nchar(70),
	@companyProvince	nchar(35),
	@companyCity	nchar(35),
	@companyPostalCode	nchar(12)

AS
BEGIN TRY 
	DECLARE @exist INT;
	SET NOCOUNT ON;
	SET @exist = (SELECT COUNT(*) FROM CustomerCompany WHERE customerID = @customerID);
	
	IF @exist > 0
		BEGIN
			PRINT N'Company Already Exists, please update instead';
		END
	ELSE
		BEGIN
			INSERT INTO CustomerCompany (customerID, companyName, companyPhoneNumber, companyAddress, companyCountry, companyProvince, companyCity, companyPostalCode) 
			SELECT  @customerID, @companyName, @companyPhoneNumber, @companyAddress, @companyCountry, @companyProvince, @companyCity, @companyPostalCode;
		END
END TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO