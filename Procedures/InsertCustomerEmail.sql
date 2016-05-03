SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's email
-- =============================================
CREATE PROCEDURE InsertCustomerEmail
	
	@customerID	int	,
	@emailType nchar(15),
	@email nchar(254)
	
AS
BEGIN TRY
	DECLARE @exist INT;
	SET NOCOUNT ON;
	SET @exist = (SELECT COUNT(*) FROM CustomerEmails WHERE customerID = @customerID AND emailType = @emailType);
	
	IF @exist > 0
		BEGIN
			PRINT N'Email Already Exists';
		END
	ELSE
		BEGIN
			INSERT INTO CustomerEmails (customerID, emailType, email) 
			SELECT  @customerID, @emailType, @email;
		END
END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO
