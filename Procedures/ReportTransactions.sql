SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aaron Scott
-- Create date: 05/01/16
-- Description:	Procedure to report on Product Download Transaction
-- =============================================
CREATE PROCEDURE ReportTransactions
AS
BEGIN
	DECLARE @idCount INT = 0;
	DECLARE @versionCount INT = 0;
	DECLARE @monthCount INT = 0;

	DECLARE @currentProductID SMALLINT;
	DECLARE @currentProductName NCHAR(50);
	DECLARE @currentVersion NCHAR(25);
	DECLARE @currentMonth NCHAR(2);
	DECLARE @CurrentYear NCHAR(4);

	DECLARE @totalID INT;
	DECLARE @totalVersions INT;
	DECLARE @totalMonths INT;
	
	DECLARE @number INT = 0;

	DECLARE @tempIDTable Table
	(
		productID smallint
	);

	DECLARE @tempVersionTable Table
	(
		theVersion NCHAR(25)
	);


	DECLARE @tempMonthTable Table
	(
		theMonth int,
		theYear int 
	);
	SET NOCOUNT ON;
	INSERT INTO @tempIDTable SELECT DISTINCT productID FROM Transactions;
	SET @totalID = (SELECT COUNT(*) FROM @tempIDTABLE);
	WHILE @idCount < @totalID
		BEGIN
			SET @currentProductID =  (SELECT DISTINCT TOP (1) productID FROM @tempIDTable);
			SET @currentProductName = (SELECT TOP (1) productName FROM Products WHERE productID = @currentProductID);
			DELETE FROM @tempversiontable;
			INSERT INTO @tempVersionTable SELECT DISTINCT developmentVersion FROM Transactions WHERE productID = @currentProductID;
			SET @totalVersions = (SELECT COUNT(*) FROM @tempVersionTable);
			WHILE @versionCount < @totalVersions
				BEGIN
					SET @currentVersion =  (SELECT DISTINCT TOP (1) theVersion FROM  @tempVersionTable);
					DELETE FROM @tempMonthTable
					INSERT INTO @tempMonthTable SELECT DISTINCT datepart(month,transactionDate), datepart(year,transactionDate) FROM Transactions WHERE productID = @currentProductID AND developmentVersion = @currentVersion;
					SET @totalMonths = (SELECT COUNT(*) FROM @tempMonthTable);
					WHILE @monthCount < @totalMonths
						BEGIN
							SET @currentMonth = (SELECT DISTINCT TOP (1) theMonth FROM @tempMonthTable);
							SET @currentYear = (SELECT DISTINCT TOP (1) theYear FROM @tempMonthTable);
							SET @number = (SELECT COUNT(transactionDate) FROM Transactions WHERE productID = @currentProductID AND developmentVersion = @currentVersion AND datepart(month,transactionDate) = @currentMonth AND datepart(year,transactionDate) = @currentYear);
							PRINT N'' + RTRIM(CAST(@currentProductName AS NVARCHAR(50))) + N', ' + RTRIM(CAST(@currentVersion AS NVARCHAR(25))) + N', ' + RTRIM(CAST(@currentMonth AS NVARCHAR(2))) + N' ' + CAST(@currentYear AS NVARCHAR(4)) + N', ' + RTRIM(CAST(@number AS NVARCHAR(10)));
							DELETE TOP (1) FROM @tempMonthTable;
							SET @monthCount = @monthCount + 1;
						END
					SET @monthCount = 0;
					DELETE TOP (1) FROM @tempVersionTable;
					SET @versionCount = @versionCount +1;
				END
			SET @versionCount = 0;
			DELETE TOP (1) FROM @tempIDTable;
			SET @idCount = @idCount + 1;
		END
END
GO
