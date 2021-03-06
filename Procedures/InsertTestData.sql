GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Aaron Scott
-- Create date: 05/01/2016
-- Description:	Inserts test data in to database
-- =============================================
CREATE PROCEDURE InsertTestData
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
