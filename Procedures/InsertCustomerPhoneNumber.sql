SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's phone number
-- =============================================
CREATE PROCEDURE InsertCustomerPhoneNumber
	
	@customerID	int	,
	@phoneNumber nchar(15),
	@phoneType nchar(10)
	
AS
BEGIN TRY
	DECLARE @exist INT;
	SET NOCOUNT ON;
	SET @exist = (SELECT COUNT(*) FROM CustomerPhoneNumbers WHERE customerID = @customerID AND phoneType = @phoneType);
	
	IF @exist > 0
		BEGIN
			PRINT N'Phone Number Already Exists';
		END
	ELSE
		BEGIN
			INSERT INTO CustomerPhoneNumbers (customerID, phoneType, phoneNumber) 
			SELECT  @customerID, @phoneType, @phoneNumber;
		END
END TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO
