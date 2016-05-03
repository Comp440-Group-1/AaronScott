SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert a new product version also updates currentversion
-- =============================================
CREATE PROCEDURE InsertNewProductVersion 
	
	@productID smallint,
	@developmentVersion nchar(25), 
	@sourceCodeFileLocation nchar(260),
	@isCustomerRelease bit, -- 0 false 1 true
	--below can be NULL if isCustomerRelease is False
	@releaseVersion nchar(25),
	@operatingSystem nchar(50), -- Operating System
	@executableFileLocation nchar(26),
	@isSupported bit -- 0 false 1 true

AS
BEGIN TRY
	DECLARE @exist INT;
	SET NOCOUNT ON;
	SET @exist = (SELECT COUNT(*) FROM Products WHERE Products.productID = @productID);
	IF @exist = 0
		BEGIN
			PRINT N'productID does not exist, plase add product to database first.';
		END
	ELSE
		BEGIN
			INSERT INTO ProductDevelopmentVersions (productID, developmentVersion,commitDate,sourceCodeFileLocation,isCustomerRelease) 
			SELECT  @productID, @developmentVersion, GETDATE (), @sourceCodeFileLocation, @isCustomerRelease;
		IF @isCustomerRelease = 1
			Begin
				INSERT INTO ProductCustomerReleases (productID, developmentVersion,releaseVersion,releaseDate, operatingSystem, executableFileLocation, isSupported)
				SELECT @productID, @developmentVersion,@releaseVersion, GETDATE (), @operatingSystem, @executableFileLocation, @isSupported;
				UPDATE Products SET currentReleaseVersion = @releaseVersion WHERE productID = @productID; 
			END
		END

END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH
GO
