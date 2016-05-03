SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aaron Scott
-- Create date: 05/01/16
-- Description:	Procedure to report number of features for each release
-- =============================================
CREATE PROCEDURE ReportFeatures
AS
BEGIN
	DECLARE @currentProductID SMALLINT;
	DECLARE @currentVersion NCHAR(25);
	DECLARE @currentProductName NCHAR(50);

	DECLARE @idCount INT = 0;
	DECLARE @versionCount INT = 0;

	DECLARE @totalIDs INT;
	DECLARE @totalVersions INT;
	DECLARE @totalFeatures INT ;

	DECLARE @featureNumber INT;

	DECLARE @tempFeaturesTable TABLE
	(
		feature NCHAR(50)
	);
	DECLARE @tempIDTable Table
	(
		productID smallint
	);
	DECLARE @tempVersionTable Table
	(
		theVersion NCHAR(25)
	);

	SET NOCOUNT ON;

	INSERT INTO @tempIDTable SELECT DISTINCT productID FROM ProductFeatures
	SET @totalIDs = (SELECT COUNT(*) FROM @tempIDTABLE);
	WHILE @idCount < @totalIDs
		BEGIN
			SET @currentProductID =  (SELECT DISTINCT TOP (1) productID FROM @tempIDTable);
			SET @currentProductName = (SELECT TOP (1) productName FROM Products WHERE productID = @currentProductID);
			DELETE FROM @tempVersionTable;
			INSERT INTO @tempVersionTable SELECT DISTINCT developmentVersion FROM ProductFeatures WHERE productID = @currentProductID;
			SET @totalVersions = (SELECT COUNT(*) FROM @tempVersionTable);
			WHILE @versionCount < @totalVersions
				BEGIN
					SET @currentVersion =  (SELECT DISTINCT TOP (1) theVersion FROM  @tempVersionTable);
					DELETE FROM @tempFeaturesTable;
					INSERT INTO @tempFeaturesTable SELECT DISTINCT featureChange FROM ProductFeatures WHERE productID = @currentProductID AND developmentVersion = @currentVersion;
					SET @totalFeatures = (SELECT COUNT(*) FROM @tempFeaturesTable);
					IF @totalFeatures > 0
							PRINT N'' + RTRIM(CAST(@currentProductName AS NVARCHAR(50))) + N' version ' + RTRIM(CAST(@currentVersion AS NVARCHAR(25))) + N' Has ' + RTRIM(CAST(@totalFeatures AS NVARCHAR(5))) + N' New Features';
					ELSE
							PRINT N'' + RTRIM(CAST(@currentProductName AS NVARCHAR(50))) + N' version ' + RTRIM(CAST(@currentVersion AS NVARCHAR(25))) + N' is a bug–fix release. There are no new features.';
					DELETE TOP(1) FROM @tempVersionTable;
					SET @versionCount = @versionCount +1;
				END
			SET @versionCount = 0;
			DELETE TOP (1) FROM @tempIDTable;
			SET @idCount = @idCount + 1;
		END
END
GO
