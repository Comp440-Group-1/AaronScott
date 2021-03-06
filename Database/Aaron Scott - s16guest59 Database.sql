USE [master]
GO
/****** Object:  Database [s16guest59]    Script Date: 5/2/2016 10:15:06 PM ******/
CREATE DATABASE [s16guest59]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N's16guest59', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest59.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N's16guest59_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest59_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [s16guest59] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [s16guest59].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [s16guest59] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [s16guest59] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [s16guest59] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [s16guest59] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [s16guest59] SET ARITHABORT OFF 
GO
ALTER DATABASE [s16guest59] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [s16guest59] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest59] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [s16guest59] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest59] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [s16guest59] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [s16guest59] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [s16guest59] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [s16guest59] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [s16guest59] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [s16guest59] SET  ENABLE_BROKER 
GO
ALTER DATABASE [s16guest59] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [s16guest59] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [s16guest59] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [s16guest59] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [s16guest59] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [s16guest59] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [s16guest59] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [s16guest59] SET RECOVERY FULL 
GO
ALTER DATABASE [s16guest59] SET  MULTI_USER 
GO
ALTER DATABASE [s16guest59] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [s16guest59] SET DB_CHAINING OFF 
GO
ALTER DATABASE [s16guest59] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [s16guest59] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N's16guest59', N'ON'
GO
USE [s16guest59]
GO
/****** Object:  User [s16guest59]    Script Date: 5/2/2016 10:15:07 PM ******/
CREATE USER [s16guest59] FOR LOGIN [s16guest59] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s16guest59]
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerAddress]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's address
-- =============================================
CREATE PROCEDURE [dbo].[InsertCustomerAddress]
	
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
/****** Object:  StoredProcedure [dbo].[InsertCustomerCompany]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's company data
-- =============================================
CREATE PROCEDURE [dbo].[InsertCustomerCompany]
	
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
/****** Object:  StoredProcedure [dbo].[InsertCustomerEmail]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's email
-- =============================================
CREATE PROCEDURE [dbo].[InsertCustomerEmail]
	
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
/****** Object:  StoredProcedure [dbo].[InsertCustomerPhoneNumber]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert customer's phone number
-- =============================================
CREATE PROCEDURE [dbo].[InsertCustomerPhoneNumber]
	
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
/****** Object:  StoredProcedure [dbo].[InsertNewCustomer]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert new customer's basic data
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewCustomer]

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
/****** Object:  StoredProcedure [dbo].[InsertNewProduct]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert new product
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewProduct]

	@productName	nchar(50),
	@productDescription	nchar(50)
AS
BEGIN TRY
	DECLARE @exist INT;
	DECLARE @total INT;
	SET NOCOUNT ON;
	SET @total = (SELECT COUNT(*) FROM Products);
	SET @exist = (SELECT COUNT(*) FROM Products WHERE productName = @productName);
	
	IF @exist > 0
		BEGIN
			PRINT N'Product already exists';
		END
	ELSE
		BEGIN
			INSERT INTO Products (productID, productName, productDescription, currentReleaseVersion) 
			SELECT (@total + 1), @productName, @productDescription, '0.0';
		END
END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[InsertNewProductVersion]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert a new product version also updates currentversion
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewProductVersion] 
	
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
/****** Object:  StoredProcedure [dbo].[InsertNewTransaction]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert a new customer transaction with the download server
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewTransaction]

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
/****** Object:  StoredProcedure [dbo].[InsertProductFeature]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Procedure to insert product features
-- =============================================
CREATE PROCEDURE [dbo].[InsertProductFeature]
	
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
/****** Object:  StoredProcedure [dbo].[InsertTestData]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Inserts test Data in to database
-- =============================================
CREATE PROCEDURE [dbo].[InsertTestData]
	@mode bit -- 0 = Delete only 1 = Delete and Insert

AS
BEGIN TRY
	BEGIN
		SET NOCOUNT ON;
		--delete all test data
		DELETE FROM Transactions 
		DELETE FROM CustomerPhoneNumbers
		DELETE FROM CustomerEmails
		DELETE FROM CustomerCompany
		DELETE FROM CustomerAddress
		DELETE FROM Customers
		DELETE FROM ProductWebPage
		DELETE FROM ProductCustomerReleases
		DELETE FROM ProductFeatures
		DELETE FROM ProductDevelopmentVersions
		DELETE FROM Products
		PRINT N'All Table Data Deleted'
	
	END
	--insert all test data
	IF @mode = 1
	Begin

		EXEC InsertNewCustomer 'pSmith', 'pSmith', 'Peter', 'Smith', NULL
		EXEC InsertNewCustomer 'mBounte', 'mBounte', 'Maria', 'Bounte', NULL
		EXEC InsertNewCustomer 'dSommerset', 'dSommerset', 'David', 'Sommerset', NULL
		EXEC InsertNewCustomer 'mBounte2', 'mBounte2', 'Maria', 'Bounte', NULL

		EXEC InsertCustomerCompany 1, 'ABC records', NULL, '123 Privet Street', 'United States of America', 'CA', 'Los Angeles', '91601'
		EXEC InsertCustomerCompany 2, 'ZYX Corp', NULL, '348 Jinx Road', 'England', NULL, 'London', NULL
		EXEC InsertCustomerCompany 3, '99 Store', NULL, NULL, NULL, NULL, NULL, NULL
		EXEC InsertCustomerCompany 4, '99 Store', NULL, NULL, NULL, NULL, NULL, NULL

		EXEC InsertCustomerPhoneNumber 1, work , '123-485-8973'
		EXEC InsertCustomerPhoneNumber 2, work, '1-28-397863896'
		EXEC InsertCustomerPhoneNumber 3, mobile, '179-397-87968'
		EXEC InsertCustomerPhoneNumber 4, mobile, '178-763-98764'

		EXEC InsertCustomerEmail 1, work , 'p.smith@abc.com'
		EXEC InsertCustomerEmail 2, work, 'maria@zyx.com'
		EXEC InsertCustomerEmail 3, work, 'david.sommerset@99cents.store'
		EXEC InsertCustomerEmail 4, work, 'maria.bounte@99cents.store'

		EXEC InsertNewProduct 'EHR System', 'health records system for the patients'

		EXEC InsertNewProductVersion 1, 1.1, 'EHR_Windows_1.1.c', 1, 1.1, 'Windows', 'EHR_Windows_1.1.exe', 1;
		EXEC InsertNewProductVersion 1, 1.2, 'EHR_Linux_1.2.c', 1, 1.1, 'Linux', 'EHR_Linux_1.1', 1;
		EXEC InsertNewProductVersion 1, 2.1, 'EHR_Window_2.1.c', 1, 2.1, 'Windows', 'EHR_Windows_2.1.exe', 1;
		EXEC InsertNewProductVersion 1, 2.2, 'EHR_Linux_2.2.c', 1, 2.1, 'Linux', 'EHR_Linux_2.1', 1;
		--next one doesn't match test data to fit with my database design i changed bugfix to version 2.21 and release to 2.11
		EXEC InsertNewProductVersion 1, 2.21, 'EHR_Linux_2.21.c', 1, 2.11, 'Linux', 'EHR_Linux_2.11', 1;

		EXEC InsertProductFeature 1, 1.1, 'login module'
		EXEC InsertProductFeature 1, 1.1, 'patient registration'
		EXEC InsertProductFeature 1, 1.1, 'patient profile'
		EXEC InsertProductFeature 1, 1.1, 'patient release form'
		EXEC InsertProductFeature 1, 1.1, 'physician profile'
		EXEC InsertProductFeature 1, 1.1, 'address verification'
		EXEC InsertProductFeature 1, 1.2, 'login module'
		EXEC InsertProductFeature 1, 1.2, 'patient registration'
		EXEC InsertProductFeature 1, 1.2, 'patient profile'
		EXEC InsertProductFeature 1, 1.2, 'patient release form'
		EXEC InsertProductFeature 1, 1.2, 'physician profile'
		EXEC InsertProductFeature 1, 1.2, 'address verification'
		EXEC InsertProductFeature 1, 2.1, 'patient medication form'
		EXEC InsertProductFeature 1, 2.1, 'patient e-bill'
		EXEC InsertProductFeature 1, 2.1, 'patient reporting'
		EXEC InsertProductFeature 1, 2.1, 'patient authentication'
		EXEC InsertProductFeature 1, 2.2, 'patient medication form'
		EXEC InsertProductFeature 1, 2.2, 'patient e-bill'
		EXEC InsertProductFeature 1, 2.2, 'patient reporting'
		EXEC InsertProductFeature 1, 2.2, 'patient authentication'
		EXEC InsertProductFeature 1, 2.21, 'patient reporting bug fix'

		EXEC InsertNewTransaction '03/01/2000' , 2, 1, 2.1
		EXEC InsertNewTransaction '06/01/2000' , 1, 1, 2.1
		EXEC InsertNewTransaction '07/01/2000' , 3, 1, 2.2
		EXEC InsertNewTransaction '09/01/2000' , 4, 1, 2.2

		PRINT N'TestData Successfully Entered'

		EXEC ReportFeatures
		EXEC ReportTransactions
	END
END  TRY
BEGIN CATCH
	PRINT N'Incorrectly formatted Data Entered';
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[ReportFeatures]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aaron Scott
-- Create date: 05/01/16
-- Description:	Procedure to report number of features for each release
-- =============================================
CREATE PROCEDURE [dbo].[ReportFeatures]
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
/****** Object:  StoredProcedure [dbo].[ReportTransactions]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aaron Scott
-- Create date: 05/01/16
-- Description:	Procedure to report on Product Download Transaction
-- =============================================
CREATE PROCEDURE [dbo].[ReportTransactions]
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
/****** Object:  Table [dbo].[CustomerAddress]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAddress](
	[customerID] [int] NOT NULL,
	[customerAddress] [nchar](95) NULL,
	[customerCountry] [nchar](70) NULL,
	[customerProvince] [nchar](35) NULL,
	[customerCity] [nchar](35) NULL,
	[customerPostalCode] [nchar](12) NULL,
 CONSTRAINT [PK_CustomerAddress] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerCompany]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCompany](
	[customerID] [int] NOT NULL,
	[companyName] [nchar](50) NOT NULL,
	[companyPhoneNumber] [nchar](19) NULL,
	[companyAddress] [nchar](95) NULL,
	[companyCountry] [nchar](70) NULL,
	[companyProvince] [nchar](35) NULL,
	[companyCity] [nchar](35) NULL,
	[companyPostalCode] [nchar](12) NULL,
 CONSTRAINT [PK_Companies_1] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerEmails]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEmails](
	[customerID] [int] NOT NULL,
	[emailType] [nchar](10) NOT NULL,
	[email] [nchar](254) NOT NULL,
 CONSTRAINT [PK_CustomerEmails] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC,
	[emailType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerPhoneNumbers]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerPhoneNumbers](
	[customerID] [int] NOT NULL,
	[phoneType] [nchar](10) NOT NULL,
	[phoneNumber] [nchar](19) NOT NULL,
 CONSTRAINT [PK_CustomerPhoneNumbers] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC,
	[phoneType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customerID] [int] NOT NULL,
	[username] [nchar](25) NOT NULL,
	[passKey] [nchar](25) NOT NULL,
	[firstName] [nchar](35) NOT NULL,
	[lastName] [nchar](35) NOT NULL,
	[jobTitle] [nchar](50) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductCustomerReleases]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCustomerReleases](
	[productID] [smallint] NOT NULL,
	[developmentVersion] [nchar](25) NOT NULL,
	[releaseVersion] [nchar](25) NOT NULL,
	[releaseDate] [datetime] NOT NULL,
	[operatingSystem] [nchar](50) NOT NULL,
	[executableFileLocation] [nchar](260) NOT NULL,
	[isSupported] [bit] NOT NULL,
 CONSTRAINT [PK_ProductCustomerReleases_1] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[developmentVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductDevelopmentVersions]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDevelopmentVersions](
	[productID] [smallint] NOT NULL,
	[developmentVersion] [nchar](25) NOT NULL,
	[commitDate] [datetime] NOT NULL,
	[sourceCodeFileLocation] [nchar](260) NOT NULL,
	[isCustomerRelease] [bit] NOT NULL,
 CONSTRAINT [PK_ProductDevelopmentVersions] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[developmentVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductFeatures]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductFeatures](
	[productID] [smallint] NOT NULL,
	[developmentVersion] [nchar](25) NOT NULL,
	[featureChange] [nchar](50) NOT NULL,
 CONSTRAINT [PK_ProductFeatures] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[developmentVersion] ASC,
	[featureChange] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[productID] [smallint] NOT NULL,
	[productName] [nchar](50) NOT NULL,
	[productDescription] [nchar](50) NOT NULL,
	[currentReleaseVersion] [nchar](25) NOT NULL,
 CONSTRAINT [PK_ProductReleases] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductWebPage]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductWebPage](
	[productID] [smallint] NOT NULL,
	[customerID] [int] NOT NULL,
	[ProductsListPageURL] [nchar](1000) NOT NULL,
	[companyInfoPageURL] [nchar](1000) NOT NULL,
	[supportPageURL] [nchar](1000) NOT NULL,
 CONSTRAINT [PK_productWebPage] PRIMARY KEY CLUSTERED 
(
	[productID] ASC,
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 5/2/2016 10:15:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[transactionID] [int] NOT NULL,
	[transactionDate] [datetime] NOT NULL,
	[customerID] [int] NOT NULL,
	[productID] [smallint] NOT NULL,
	[developmentVersion] [nchar](25) NOT NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[transactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CustomerAddress]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddress_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
GO
ALTER TABLE [dbo].[CustomerAddress] CHECK CONSTRAINT [FK_CustomerAddress_Customers]
GO
ALTER TABLE [dbo].[CustomerCompany]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
GO
ALTER TABLE [dbo].[CustomerCompany] CHECK CONSTRAINT [FK_Companies_Customers]
GO
ALTER TABLE [dbo].[CustomerEmails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEmails_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
GO
ALTER TABLE [dbo].[CustomerEmails] CHECK CONSTRAINT [FK_CustomerEmails_Customers]
GO
ALTER TABLE [dbo].[CustomerPhoneNumbers]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPhoneNumbers_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
GO
ALTER TABLE [dbo].[CustomerPhoneNumbers] CHECK CONSTRAINT [FK_CustomerPhoneNumbers_Customers]
GO
ALTER TABLE [dbo].[ProductCustomerReleases]  WITH CHECK ADD  CONSTRAINT [FK_ProductCustomerReleases_ProductDevelopmentVersions] FOREIGN KEY([productID], [developmentVersion])
REFERENCES [dbo].[ProductDevelopmentVersions] ([productID], [developmentVersion])
GO
ALTER TABLE [dbo].[ProductCustomerReleases] CHECK CONSTRAINT [FK_ProductCustomerReleases_ProductDevelopmentVersions]
GO
ALTER TABLE [dbo].[ProductDevelopmentVersions]  WITH CHECK ADD  CONSTRAINT [FK_ProductDevelopmentVersions_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[Products] ([productID])
GO
ALTER TABLE [dbo].[ProductDevelopmentVersions] CHECK CONSTRAINT [FK_ProductDevelopmentVersions_Products]
GO
ALTER TABLE [dbo].[ProductFeatures]  WITH CHECK ADD  CONSTRAINT [FK_ProductFeatures_ProductDevelopmentVersions] FOREIGN KEY([productID], [developmentVersion])
REFERENCES [dbo].[ProductDevelopmentVersions] ([productID], [developmentVersion])
GO
ALTER TABLE [dbo].[ProductFeatures] CHECK CONSTRAINT [FK_ProductFeatures_ProductDevelopmentVersions]
GO
ALTER TABLE [dbo].[ProductWebPage]  WITH CHECK ADD  CONSTRAINT [FK_productWebPage_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
GO
ALTER TABLE [dbo].[ProductWebPage] CHECK CONSTRAINT [FK_productWebPage_Customers]
GO
ALTER TABLE [dbo].[ProductWebPage]  WITH CHECK ADD  CONSTRAINT [FK_productWebPage_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[Products] ([productID])
GO
ALTER TABLE [dbo].[ProductWebPage] CHECK CONSTRAINT [FK_productWebPage_Products]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Customers]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_ProductCustomerReleases] FOREIGN KEY([productID], [developmentVersion])
REFERENCES [dbo].[ProductCustomerReleases] ([productID], [developmentVersion])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_ProductCustomerReleases]
GO
USE [master]
GO
ALTER DATABASE [s16guest59] SET  READ_WRITE 
GO
