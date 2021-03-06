USE [master]
GO
/****** Object:  Database [BarterSystem1]    Script Date: 4/23/2019 8:45:45 AM ******/
CREATE DATABASE [BarterSystem1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BarterSystem1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BarterSystem1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BarterSystem1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BarterSystem1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BarterSystem1] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BarterSystem1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BarterSystem1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BarterSystem1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BarterSystem1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BarterSystem1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BarterSystem1] SET ARITHABORT OFF 
GO
ALTER DATABASE [BarterSystem1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BarterSystem1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BarterSystem1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BarterSystem1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BarterSystem1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BarterSystem1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BarterSystem1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BarterSystem1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BarterSystem1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BarterSystem1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BarterSystem1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BarterSystem1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BarterSystem1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BarterSystem1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BarterSystem1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BarterSystem1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BarterSystem1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BarterSystem1] SET RECOVERY FULL 
GO
ALTER DATABASE [BarterSystem1] SET  MULTI_USER 
GO
ALTER DATABASE [BarterSystem1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BarterSystem1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BarterSystem1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BarterSystem1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BarterSystem1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BarterSystem1', N'ON'
GO
ALTER DATABASE [BarterSystem1] SET QUERY_STORE = OFF
GO
USE [BarterSystem1]
GO
/****** Object:  UserDefinedFunction [dbo].[fnOwnerAddress]    Script Date: 4/23/2019 8:45:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Final Project Procedures

USE BarterSystem1
GO
CREATE PROC spCustomerFirstName
AS
SELECT FirstName 
FROM Customers;

EXEC spCustomerFirstName


USE BarterSystem1
GO
CREATE PROC spGetCustomerInfo
	@CustomerID int
AS
BEGIN
	SELECT * FROM Customers
	WHERE CustomerID = @CustomerID;
END
GO
EXEC spGetCustomerInfo 1


GO
CREATE PROC spItemOwnersContact
	@OwnerID varchar(30) OUTPUT,
	@FirstName varchar(30) OUTPUT,
	@LastNmame varchar(30) OUTPUT,
	@Address varchar(30) OUTPUT,
	@ZipCode varchar(12) OUTPUT
AS
SELECT @FirstName = FirstName, @LastNmame = LastName, @Address = Address
FROM Owner
WHERE OwnerID = @OwnerID;


DECLARE @FirstName varchar(30);
DECLARE @LastName varchar(30);
DECLARE @Address varchar(30);
DECLARE @ZipCode varchar(12);

EXEC spItemOwnersContact 1, @FirstName OUTPUT, @LastName OUTPUT, @Address OUTPUT,
							@ZipCode OUTPUT;
SELECT @FirstName AS [First Name], @LastName AS [Last Name], @Address AS Address, @ZipCode AS ZipCode;


USE BarterSystem1
GO
CREATE PROC spItemCount
AS
DECLARE @ItemCount int;
SELECT @ItemCount = COUNT(*)
FROM Items
RETURN @ItemCount;

GO
DECLARE @ItemCount int;
EXEC @ItemCount = spItemCount;
PRINT 'There are ' + CONVERT(varchar, @ItemCount) + ' ' + 'Items in your database';
GO

--USER Defined Functions 
GO
CREATE FUNCTION fnOwnerInfo
	( @OwnerID varchar)
	RETURNS varchar(30)
AS
BEGIN
	DECLARE @op varchar(30);
	SELECT @op = FirstName + LastName FROM Owner WHERE OwnerID = @OwnerID;
	RETURN @op;
	
END;
 
SELECT dbo.fnOwnerInfo(3) AS 'Full Name'


CREATE FUNCTION fnItems
	(@ItemID varchar(30) = '%')
	
	RETURNS table
RETURN (SELECT * FROM Items WHERE ItemID = @ItemID);

SELECT * FROM dbo.fnItems (2);

*/

CREATE FUNCTION [dbo].[fnOwnerAddress]
	(@OwnerID varchar)
	RETURNS varchar(30)
AS
BEGIN
	DECLARE @Address varchar(30);
	SELECT @Address = Address from Owner
	WHERE OwnerID = @OwnerID
	RETURN @Address
END;


--Triggers  



GO
/****** Object:  UserDefinedFunction [dbo].[fnOwnerInfo]    Script Date: 4/23/2019 8:45:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnOwnerInfo]
	( @OwnerID varchar)
	RETURNS varchar(30)
AS
BEGIN
	DECLARE @op varchar(30);
	SELECT @op = FirstName + LastName FROM Owner WHERE OwnerID = @OwnerID;
	RETURN @op;
	
END;
 
 
 



--SELECT * FROM Owner

--DROP FUNCTION fnGetItemDetails
  



GO
/****** Object:  Table [dbo].[Customers]    Script Date: 4/23/2019 8:45:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[Address] [varchar](25) NOT NULL,
	[Zipcode] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionDetails]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionDetails](
	[BarterID] [int] NOT NULL,
	[Date] [smalldatetime] NOT NULL,
	[ItemID] [int] NOT NULL,
	[ShippedDate] [smalldatetime] NOT NULL,
	[OwnerID] [varchar](30) NOT NULL,
	[CustomerID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BarterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_RecentTransactions]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Final Project Views

USE BarterSystem1;

--updatable view
GO
CREATE VIEW VW_CurrentItems
AS
SELECT Details, Quantity, CashValue, CategoryID
FROM Items;

GO
SELECT * FROM VW_CurrentItems;*/

CREATE VIEW [dbo].[VW_RecentTransactions]
AS
SELECT OwnerID, ItemID, BarterID, FirstName + lastName AS Name
FROM TransactionDetails
JOIN Customers ON Customers.CustomerID = TransactionDetails.CustomerID
WITH CHECK OPTION;
GO
/****** Object:  Table [dbo].[Owner]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Owner](
	[OwnerID] [varchar](30) NOT NULL,
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
	[Address] [varchar](30) NOT NULL,
	[ZipCode] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OwnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_OwnersLocation]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_OwnersLocation]
AS
SELECT OwnerID, FirstName + ' ' + LastName AS Name, Address, Zipcode
FROM Owner;
  
GO
/****** Object:  View [dbo].[VW_ShippedItems]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ShippedItems]
AS
SELECT ItemID, Date, ShippedDate
FROM TransactionDetails;
GO
/****** Object:  Table [dbo].[Items]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemID] [int] NOT NULL,
	[Details] [varchar](30) NOT NULL,
	[Quantity] [int] NULL,
	[CashValue] [money] NULL,
	[BarterTerms] [varchar](30) NOT NULL,
	[CategoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_CurrentItems]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_CurrentItems]
AS
SELECT Details, Quantity, CashValue, CategoryID, ItemID
FROM Items;



/*
GO
SELECT * FROM VW_CurrentItems;

CREATE VIEW VW_RecentTransactions
AS
SELECT OwnerID, ItemID, BarterID, FirstName + lastName AS Name
FROM TransactionDetails
JOIN Customers ON Customers.CustomerID = TransactionDetails.CustomerID
WITH CHECK OPTION;
GO

SELECT * FROM VW_RecentTransactions;


GO
CREATE VIEW VW_OwnersLocation
AS
SELECT OwnerID, FirstName + ' ' + LastName AS Name, Address, Zipcode
FROM Owner;

GO
SELECT * FROM VW_OwnersLocation;
  
GO
CREATE VIEW VW_ShippedItems
AS
SELECT ItemID, Date, ShippedDate
FROM TransactionDetails;
GO
SELECT * FROM VW_ShippedItems;
*/

--UPDATE VW_CurrentItems
--SET Quantity = 7
--where ItemID = '3'; 
GO
/****** Object:  UserDefinedFunction [dbo].[fnItems]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Final Project Procedures

USE BarterSystem1
GO
CREATE PROC spCustomerFirstName
AS
SELECT FirstName 
FROM Customers;

EXEC spCustomerFirstName


USE BarterSystem1
GO
CREATE PROC spGetCustomerInfo
	@CustomerID int
AS
BEGIN
	SELECT * FROM Customers
	WHERE CustomerID = @CustomerID;
END
GO
EXEC spGetCustomerInfo 1


GO
CREATE PROC spItemOwnersContact
	@OwnerID varchar(30) OUTPUT,
	@FirstName varchar(30) OUTPUT,
	@LastNmame varchar(30) OUTPUT,
	@Address varchar(30) OUTPUT,
	@ZipCode varchar(12) OUTPUT
AS
SELECT @FirstName = FirstName, @LastNmame = LastName, @Address = Address
FROM Owner
WHERE OwnerID = @OwnerID;


DECLARE @FirstName varchar(30);
DECLARE @LastName varchar(30);
DECLARE @Address varchar(30);
DECLARE @ZipCode varchar(12);

EXEC spItemOwnersContact 1, @FirstName OUTPUT, @LastName OUTPUT, @Address OUTPUT,
							@ZipCode OUTPUT;
SELECT @FirstName AS [First Name], @LastName AS [Last Name], @Address AS Address, @ZipCode AS ZipCode;


USE BarterSystem1
GO
CREATE PROC spItemCount
AS
DECLARE @ItemCount int;
SELECT @ItemCount = COUNT(*)
FROM Items
RETURN @ItemCount;

GO
DECLARE @ItemCount int;
EXEC @ItemCount = spItemCount;
PRINT 'There are ' + CONVERT(varchar, @ItemCount) + ' ' + 'Items in your database';
GO

--USER Defined Functions 
GO
CREATE FUNCTION fnOwnerInfo
	( @OwnerID varchar)
	RETURNS varchar(30)
AS
BEGIN
	DECLARE @op varchar(30);
	SELECT @op = FirstName + LastName FROM Owner WHERE OwnerID = @OwnerID;
	RETURN @op;
	
END;
 
SELECT dbo.fnOwnerInfo(3) AS 'Full Name'

*/

CREATE FUNCTION [dbo].[fnItems]
	(@ItemID varchar(30) = '%')
	
	RETURNS table
RETURN (SELECT * FROM Items WHERE ItemID = @ItemID);



--SELECT * FROM dbo.fnItems('Joe%');

--DROP FUNCTION fnItems
  



GO
/****** Object:  Table [dbo].[CustomersArchive]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomersArchive](
	[CustomerID] [int] NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[Address] [varchar](25) NOT NULL,
	[Zipcode] [varchar](12) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemCategories]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemCategories](
	[ID] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnerArchive]    Script Date: 4/23/2019 8:45:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerArchive](
	[OwnerID] [varchar](30) NOT NULL,
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
	[Address] [varchar](30) NOT NULL,
	[ZipCode] [varchar](12) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zipcode]    Script Date: 4/23/2019 8:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zipcode](
	[Zipcode] [varchar](12) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[State] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Zipcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Zipcode_Customers] FOREIGN KEY([Zipcode])
REFERENCES [dbo].[Zipcode] ([Zipcode])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Zipcode_Customers]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_CategoryID_Items] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ItemCategories] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_CategoryID_Items]
GO
ALTER TABLE [dbo].[Owner]  WITH CHECK ADD  CONSTRAINT [FK_Zipcode_Owner] FOREIGN KEY([ZipCode])
REFERENCES [dbo].[Zipcode] ([Zipcode])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Owner] CHECK CONSTRAINT [FK_Zipcode_Owner]
GO
ALTER TABLE [dbo].[TransactionDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerID_TransactionDetails] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[TransactionDetails] CHECK CONSTRAINT [FK_CustomerID_TransactionDetails]
GO
ALTER TABLE [dbo].[TransactionDetails]  WITH CHECK ADD  CONSTRAINT [FK_ItemID_TransactionDetails] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ItemID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[TransactionDetails] CHECK CONSTRAINT [FK_ItemID_TransactionDetails]
GO
ALTER TABLE [dbo].[TransactionDetails]  WITH CHECK ADD  CONSTRAINT [FK_OwnerID_TransactionDetails] FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Owner] ([OwnerID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[TransactionDetails] CHECK CONSTRAINT [FK_OwnerID_TransactionDetails]
GO
/****** Object:  StoredProcedure [dbo].[spCustomerFirstName]    Script Date: 4/23/2019 8:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCustomerFirstName]
AS
SELECT FirstName 
FROM Customers;
GO
/****** Object:  StoredProcedure [dbo].[spGetCustomerInfo]    Script Date: 4/23/2019 8:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetCustomerInfo]
	@CustomerID int
AS
BEGIN
	SELECT * FROM Customers
	WHERE CustomerID = @CustomerID;
END
EXEC spGetCustomerInfo 1
GO
/****** Object:  StoredProcedure [dbo].[spItemCount]    Script Date: 4/23/2019 8:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spItemCount]
AS
DECLARE @ItemCount int;
SELECT @ItemCount = COUNT(*)
FROM Items
RETURN @ItemCount;

GO
/****** Object:  StoredProcedure [dbo].[spItemOwnersContact]    Script Date: 4/23/2019 8:45:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spItemOwnersContact]
	@OwnerID varchar(30) OUTPUT,
	@FirstName varchar(30) OUTPUT,
	@LastNmame varchar(30) OUTPUT,
	@Address varchar(30) OUTPUT,
	@ZipCode varchar(12) OUTPUT
AS
SELECT @FirstName = FirstName, @LastNmame = LastName, @Address = Address
FROM Owner
WHERE OwnerID = @OwnerID;  



GO
USE [master]
GO
ALTER DATABASE [BarterSystem1] SET  READ_WRITE 
GO
