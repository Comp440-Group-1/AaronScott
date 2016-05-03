SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert product features
-- =============================================
CREATE PROCEDURE InsertProductFeature
	
	@productID	smallint,
	@developmentVersion	nchar(25),
	@featureChange	nchar(50)
	
AS
BEGIN TRY
	DECLARE @exist INT;
	SET NOCOUNT ON;
	SET @exist = (SELECT COUNT(*) FROM ProductFeatures WHERE productID = @productID AND developmentVersion = @developmentVersion AND featureChange = @featureChange);
	
	IF @exist > 0
		BEGIN
			PRINT N'Feature already Exists';
		END
	ELSE
		BEGIN
			INSERT INTO ProductFeatures (productID, developmentVersion, featureChange) 
			SELECT  @productID, @developmentVersion, @featureChange;
		END
END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO
