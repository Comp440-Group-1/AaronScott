SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert new customer's basic data
-- =============================================
CREATE PROCEDURE InsertNewCustomer

	@username	nchar(25),
	@passKey	nchar(25),
	@firstName	nchar(35),
	@lastName	nchar(35),
	@jobTitle	nchar(50)
	
AS
BEGIN TRY
	DECLARE @exist INT;
	DECLARE @total INT;
	SET NOCOUNT ON;
	SET @total = (SELECT COUNT(*) FROM Customers);
	SET @exist = (SELECT COUNT(*) FROM Customers WHERE userName = @username);
	IF @exist > 0
		BEGIN
			PRINT N'Username already exists please try another';
		END
	ELSE
		BEGIN
			INSERT INTO Customers (customerID, username, passKey, firstName, lastName, jobTitle) 
			SELECT  (@total +1) , @username, @passKey, @firstName, @lastName, @jobTitle;
		END
END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO
