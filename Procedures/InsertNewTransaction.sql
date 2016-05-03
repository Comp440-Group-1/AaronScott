SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert a new customer transaction with the download server
-- =============================================
CREATE PROCEDURE InsertNewTransaction

	@transactionDate datetime,
	@customerID	int,
	@productID smallint,
	@developmentVersion	nchar(25)

AS
BEGIN TRY
	DECLARE @total INT;
	SET NOCOUNT ON;
	SET @total = (SELECT COUNT(*) FROM Transactions);
	BEGIN
		INSERT INTO Transactions (transactionID, transactionDate, customerID, productID, developmentVersion) 
		SELECT (@total + 1), @transactionDate, @customerID, @productID, @developmentVersion;
	END
END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO
