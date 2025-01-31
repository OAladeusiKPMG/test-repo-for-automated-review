USE [master]
GO
/****** Object:  Database [EncoreDB]    Script Date: 7/4/2023 8:18:43 AM ******/
CREATE DATABASE [EncoreDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EncoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQL_SERVER_2012\MSSQL\DATA\EncoreDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EncoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQL_SERVER_2012\MSSQL\DATA\EncoreDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EncoreDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EncoreDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EncoreDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EncoreDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EncoreDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EncoreDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EncoreDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EncoreDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EncoreDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EncoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EncoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EncoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EncoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EncoreDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EncoreDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EncoreDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EncoreDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EncoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EncoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EncoreDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EncoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EncoreDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EncoreDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EncoreDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EncoreDB] SET RECOVERY FULL 
GO
ALTER DATABASE [EncoreDB] SET  MULTI_USER 
GO
ALTER DATABASE [EncoreDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EncoreDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EncoreDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EncoreDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EncoreDB]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nominations]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nominations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nomineeId] [int] NOT NULL,
	[sponsorId] [int] NOT NULL,
	[approverId] [int] NULL,
	[categoryId] [int] NOT NULL,
	[statusId] [int] NOT NULL,
	[valueId] [int] NOT NULL,
	[justification] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[approvedAt] [datetimeoffset](7) NULL,
	[isDeleted] [int] NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SequelizeMeta]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SequelizeMeta](
	[name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staffs]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staffs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[personnelId] [int] NULL,
	[username] [nvarchar](255) NULL,
	[firstName] [nvarchar](255) NULL,
	[lastName] [nvarchar](255) NULL,
	[displayName] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[unit] [nvarchar](255) NULL,
	[division] [nvarchar](255) NULL,
	[jobTitle] [nvarchar](255) NULL,
	[level] [nvarchar](255) NULL,
	[status] [int] NULL,
	[birthDay] [date] NULL,
	[cardDownloadLink] [nvarchar](255) NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Units]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[roleId] [int] NOT NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[firstName] [nvarchar](255) NULL,
	[lastName] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[division] [nvarchar](255) NULL,
	[unit] [nvarchar](255) NULL,
	[jobTitle] [nvarchar](255) NULL,
	[profilePicture] [nvarchar](255) NULL,
	[isDeleted] [int] NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Values]    Script Date: 7/4/2023 8:18:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Values](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[createdAt] [datetimeoffset](7) NOT NULL,
	[updatedAt] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'thanks', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
INSERT [dbo].[Categories] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'cheers', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
INSERT [dbo].[Categories] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'aplause', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Nominations] ON 

INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (1, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:10:05.7840000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:10:05.7840000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (2, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:10:50.1930000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:10:50.1930000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (3, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:11:34.4310000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:11:34.4310000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (4, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:12:17.8470000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:12:17.8470000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (5, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:13:01.4060000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:13:01.4060000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (6, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:13:19.1110000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:13:19.1110000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (7, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:23:28.8290000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:23:28.8290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (8, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:33:40.6430000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:33:40.6430000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (9, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:33:54.9550000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:33:54.9550000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (10, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:34:44.9550000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:34:44.9550000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (11, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:41:20.6530000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:41:20.6530000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (12, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:41:53.8750000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:41:53.8750000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (13, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T00:48:03.9930000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T00:48:03.9930000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (14, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T06:50:13.5220000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T06:50:13.5220000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (15, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T06:51:14.3660000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T06:51:14.3660000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (16, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T06:55:00.7480000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T06:55:00.7480000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (17, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T06:56:51.5060000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T06:56:51.5060000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (18, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T06:58:20.0690000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T06:58:20.0690000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (19, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T07:03:58.9290000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T07:03:58.9290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (20, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T07:09:15.4880000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T07:09:15.4880000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (21, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T07:11:00.5910000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T07:11:00.5910000+00:00' AS DateTimeOffset))
INSERT [dbo].[Nominations] ([id], [nomineeId], [sponsorId], [approverId], [categoryId], [statusId], [valueId], [justification], [description], [approvedAt], [isDeleted], [createdAt], [updatedAt]) VALUES (22, 3, 3, NULL, 1, 1, 1, N'He deserve the award', N'He deserve the award', NULL, 0, CAST(N'2023-07-04T07:11:51.5560000+00:00' AS DateTimeOffset), CAST(N'2023-07-04T07:11:51.5560000+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[Nominations] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'staff', CAST(N'2022-11-17T16:15:09.1990000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:15:09.1990000+00:00' AS DateTimeOffset))
INSERT [dbo].[Roles] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'approver', CAST(N'2022-11-17T16:15:09.1990000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:15:09.1990000+00:00' AS DateTimeOffset))
INSERT [dbo].[Roles] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'admin', CAST(N'2022-11-17T16:15:09.1990000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:15:09.1990000+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[Roles] OFF
INSERT [dbo].[SequelizeMeta] ([name]) VALUES (N'1-noname.js')
SET IDENTITY_INSERT [dbo].[Staffs] ON 

INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (1, 15678469, N'WAndem', N'Willaims', N'Andem', N'Willaims, Andem', N'WAndem@ng.kpmg.com', N'audit-cm', N'Central Services', N'ea', N'Executive Assitant', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (2, 15678483, N'OAladeusi', N'Olugbenga', N'Aladeusi', N'Olugbenga, Aladeusi', N'OAladeusi@ng.kpmg.com', N'forensic', N'Central Services', NULL, N'Assitance Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (3, 15678427, N'Ujoseph', N'Utibe', N'Joseph', N'Utibe, josep', N'UJoseph@ng.kpmg.com', N'FRM', N'Audit', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (4, 15678458, N'user69', N'John69', N'Carson69', N'Carson69, user69', N'user69.carson69@ng.kpmg.com', N'MC', N'Central Services', NULL, N'Partner', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (5, 15678473, N'user84', N'John84', N'Carson84', N'Carson84, user84', N'user84.carson84@ng.kpmg.com', N'ITS', N'Central Services', N'Associate Director', N'Associate Director', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (6, 15678425, N'user36', N'John36', N'Carson36', N'Carson36, user36', N'user36.carson36@ng.kpmg.com', N'Audit-CM', N'Audit', N'Analyst', N'Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (7, 15678455, N'user66', N'John66', N'Carson66', N'Carson66, user66', N'user66.carson66@ng.kpmg.com', N'forensic', N'Audit', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (8, 15678396, N'user7', N'John7', N'Carson7', N'Carson7, user7', N'user7.carson7@ng.kpmg.com', N'D&A', N'Advisory', NULL, N'Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (9, 15678425, N'user36', N'John36', N'Carson36', N'Carson36, user36', N'user36.carson36@ng.kpmg.com', N'ITS', N'Tax', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (10, 15678469, N'user80', N'John80', N'Carson80', N'Carson80, user80', N'user80.carson80@ng.kpmg.com', N'forensic', N'Advisory', NULL, N'Associate Director', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (11, 15678402, N'user13', N'John13', N'Carson13', N'Carson13, user13', N'user13.carson13@ng.kpmg.com', N'MC', N'Central Services', NULL, N'Exp. Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (12, 15678450, N'user61', N'John61', N'Carson61', N'Carson61, user61', N'user61.carson61@ng.kpmg.com', N'ITS', N'Audit', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (13, 15678394, N'user5', N'John5', N'Carson5', N'Carson5, user5', N'user5.carson5@ng.kpmg.com', N'Deal Advisory', N'Advisory', NULL, N'Associate Director', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (14, 15678418, N'user29', N'John29', N'Carson29', N'Carson29, user29', N'user29.carson29@ng.kpmg.com', N'Audit-CM', N'Advisory', NULL, N'Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (15, 15678427, N'user38', N'John38', N'Carson38', N'Carson38, user38', N'user38.carson38@ng.kpmg.com', N'ITS', N'Central Services', NULL, N'Associate Director', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (16, 15678392, N'user3', N'John3', N'Carson3', N'Carson3, user3', N'user3.carson3@ng.kpmg.com', N'Deal Advisory', N'Audit', NULL, N'Associate Director', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (17, 15678457, N'user68', N'John68', N'Carson68', N'Carson68, user68', N'user68.carson68@ng.kpmg.com', N'Audit-FSI', N'Central Services', NULL, N'Associate Director', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (18, 15678467, N'user78', N'John78', N'Carson78', N'Carson78, user78', N'user78.carson78@ng.kpmg.com', N'forensic', N'Audit', NULL, N'Associate Director', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (19, 15678437, N'user48', N'John48', N'Carson48', N'Carson48, user48', N'user48.carson48@ng.kpmg.com', N'ITS', N'Central Services', NULL, N'Assitance Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (20, 15678389, N'user0', N'John0', N'Carson0', N'Carson0, user0', N'user0.carson0@ng.kpmg.com', N'Audit-FSI', N'Advisory', NULL, N'Partner', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (21, 15678455, N'user66', N'John66', N'Carson66', N'Carson66, user66', N'user66.carson66@ng.kpmg.com', N'Deal Advisory', N'Tax', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (22, 15678440, N'user51', N'John51', N'Carson51', N'Carson51, user51', N'user51.carson51@ng.kpmg.com', N'Audit-ENR', N'Central Services', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (23, 15678457, N'user68', N'John68', N'Carson68', N'Carson68, user68', N'user68.carson68@ng.kpmg.com', N'Audit-ENR', N'Central Services', NULL, N'Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (24, 15678393, N'user4', N'John4', N'Carson4', N'Carson4, user4', N'user4.carson4@ng.kpmg.com', N'IARCS', N'Advisory', NULL, N'Associate Director', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (25, 15678396, N'user7', N'John7', N'Carson7', N'Carson7, user7', N'user7.carson7@ng.kpmg.com', N'IARCS', N'Advisory', NULL, N'Partner', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (26, 15678396, N'user7', N'John7', N'Carson7', N'Carson7, user7', N'user7.carson7@ng.kpmg.com', N'FRM', N'Tax', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (27, 15678412, N'user23', N'John23', N'Carson23', N'Carson23, user23', N'user23.carson23@ng.kpmg.com', N'Audit-CM', N'Audit', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (28, 15678450, N'user61', N'John61', N'Carson61', N'Carson61, user61', N'user61.carson61@ng.kpmg.com', N'D&A', N'Audit', NULL, N'Senior Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (29, 15678422, N'user33', N'John33', N'Carson33', N'Carson33, user33', N'user33.carson33@ng.kpmg.com', N'forensic', N'Audit', NULL, N'Senior Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (30, 15678418, N'user29', N'John29', N'Carson29', N'Carson29, user29', N'user29.carson29@ng.kpmg.com', N'ITS', N'Audit', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (31, 15678467, N'user78', N'John78', N'Carson78', N'Carson78, user78', N'user78.carson78@ng.kpmg.com', N'Audit-CM', N'Audit', NULL, N'Associate Director', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (32, 15678474, N'user85', N'John85', N'Carson85', N'Carson85, user85', N'user85.carson85@ng.kpmg.com', N'FRM', N'Central Services', NULL, N'Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (33, 15678443, N'user54', N'John54', N'Carson54', N'Carson54, user54', N'user54.carson54@ng.kpmg.com', N'Audit-CM', N'Audit', NULL, N'Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (34, 15678413, N'user24', N'John24', N'Carson24', N'Carson24, user24', N'user24.carson24@ng.kpmg.com', N'Audit-ENR', N'Advisory', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (35, 15678446, N'user57', N'John57', N'Carson57', N'Carson57, user57', N'user57.carson57@ng.kpmg.com', N'MC', N'Tax', NULL, N'Partner', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (36, 15678473, N'user84', N'John84', N'Carson84', N'Carson84, user84', N'user84.carson84@ng.kpmg.com', N'IARCS', N'Central Services', NULL, N'Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (37, 15678395, N'user6', N'John6', N'Carson6', N'Carson6, user6', N'user6.carson6@ng.kpmg.com', N'Audit-DPP', N'Tax', NULL, N'Senior Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (38, 15678420, N'user31', N'John31', N'Carson31', N'Carson31, user31', N'user31.carson31@ng.kpmg.com', N'IARCS', N'Audit', NULL, N'Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (39, 15678475, N'user86', N'John86', N'Carson86', N'Carson86, user86', N'user86.carson86@ng.kpmg.com', N'forensic', N'Audit', NULL, N'Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (40, 15678473, N'user84', N'John84', N'Carson84', N'Carson84, user84', N'user84.carson84@ng.kpmg.com', N'TRPS-CM', N'Central Services', NULL, N'Partner', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (41, 15678483, N'user94', N'John94', N'Carson94', N'Carson94, user94', N'user94.carson94@ng.kpmg.com', N'IARCS', N'Audit', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (42, 15678479, N'user90', N'John90', N'Carson90', N'Carson90, user90', N'user90.carson90@ng.kpmg.com', N'IARCS', N'Central Services', NULL, N'Senior Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (43, 15678419, N'user30', N'John30', N'Carson30', N'Carson30, user30', N'user30.carson30@ng.kpmg.com', N'TRPS-CM', N'Tax', NULL, N'Associate Director', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (44, 15678463, N'user74', N'John74', N'Carson74', N'Carson74, user74', N'user74.carson74@ng.kpmg.com', N'D&A', N'Central Services', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (45, 15678451, N'user62', N'John62', N'Carson62', N'Carson62, user62', N'user62.carson62@ng.kpmg.com', N'Deal Advisory', N'Audit', NULL, N'Partner', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (46, 15678389, N'user0', N'John0', N'Carson0', N'Carson0, user0', N'user0.carson0@ng.kpmg.com', N'Audit-ENR', N'Central Services', NULL, N'Senior Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (47, 15678418, N'user29', N'John29', N'Carson29', N'Carson29, user29', N'user29.carson29@ng.kpmg.com', N'MC', N'Advisory', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (48, 15678487, N'user98', N'John98', N'Carson98', N'Carson98, user98', N'user98.carson98@ng.kpmg.com', N'Audit-FSI', N'Central Services', NULL, N'Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (49, 15678456, N'user67', N'John67', N'Carson67', N'Carson67, user67', N'user67.carson67@ng.kpmg.com', N'TRPS-CM', N'Advisory', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (50, 15678419, N'user30', N'John30', N'Carson30', N'Carson30, user30', N'user30.carson30@ng.kpmg.com', N'forensic', N'Tax', NULL, N'Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (51, 15678488, N'user99', N'John99', N'Carson99', N'Carson99, user99', N'user99.carson99@ng.kpmg.com', N'Audit-FSI', N'Tax', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (52, 15678474, N'user85', N'John85', N'Carson85', N'Carson85, user85', N'user85.carson85@ng.kpmg.com', N'MC', N'Tax', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (53, 15678415, N'user26', N'John26', N'Carson26', N'Carson26, user26', N'user26.carson26@ng.kpmg.com', N'TRPS-CM', N'Audit', NULL, N'Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (54, 15678410, N'user21', N'John21', N'Carson21', N'Carson21, user21', N'user21.carson21@ng.kpmg.com', N'Audit-DPP', N'Audit', NULL, N'Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (55, 15678436, N'user47', N'John47', N'Carson47', N'Carson47, user47', N'user47.carson47@ng.kpmg.com', N'MC', N'Central Services', NULL, N'Senior Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (56, 15678443, N'user54', N'John54', N'Carson54', N'Carson54, user54', N'user54.carson54@ng.kpmg.com', N'Audit-CM', N'Audit', NULL, N'Senior Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (57, 15678463, N'user74', N'John74', N'Carson74', N'Carson74, user74', N'user74.carson74@ng.kpmg.com', N'TRPS-CM', N'Central Services', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (58, 15678400, N'user11', N'John11', N'Carson11', N'Carson11, user11', N'user11.carson11@ng.kpmg.com', N'MC', N'Central Services', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (59, 15678394, N'user5', N'John5', N'Carson5', N'Carson5, user5', N'user5.carson5@ng.kpmg.com', N'IARCS', N'Central Services', NULL, N'Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (60, 15678484, N'user95', N'John95', N'Carson95', N'Carson95, user95', N'user95.carson95@ng.kpmg.com', N'Audit-FSI', N'Central Services', NULL, N'Assitance Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (61, 15678447, N'user58', N'John58', N'Carson58', N'Carson58, user58', N'user58.carson58@ng.kpmg.com', N'Audit-DPP', N'Audit', NULL, N'Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (62, 15678449, N'user60', N'John60', N'Carson60', N'Carson60, user60', N'user60.carson60@ng.kpmg.com', N'Deal Advisory', N'Advisory', NULL, N'Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (63, 15678469, N'user80', N'John80', N'Carson80', N'Carson80, user80', N'user80.carson80@ng.kpmg.com', N'TRPS-CM', N'Tax', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (64, 15678426, N'user37', N'John37', N'Carson37', N'Carson37, user37', N'user37.carson37@ng.kpmg.com', N'IARCS', N'Audit', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (65, 15678431, N'user42', N'John42', N'Carson42', N'Carson42, user42', N'user42.carson42@ng.kpmg.com', N'FRM', N'Tax', NULL, N'Assitance Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (66, 15678392, N'user3', N'John3', N'Carson3', N'Carson3, user3', N'user3.carson3@ng.kpmg.com', N'FRM', N'Central Services', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (67, 15678395, N'user6', N'John6', N'Carson6', N'Carson6, user6', N'user6.carson6@ng.kpmg.com', N'forensic', N'Central Services', NULL, N'Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (68, 15678389, N'user0', N'John0', N'Carson0', N'Carson0, user0', N'user0.carson0@ng.kpmg.com', N'D&A', N'Advisory', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (69, 15678419, N'user30', N'John30', N'Carson30', N'Carson30, user30', N'user30.carson30@ng.kpmg.com', N'TRPS-CM', N'Advisory', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (70, 15678456, N'user67', N'John67', N'Carson67', N'Carson67, user67', N'user67.carson67@ng.kpmg.com', N'Deal Advisory', N'Tax', NULL, N'Exp. Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (71, 15678450, N'user61', N'John61', N'Carson61', N'Carson61, user61', N'user61.carson61@ng.kpmg.com', N'TRPS-CM', N'Tax', NULL, N'Associate Director', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (72, 15678422, N'user33', N'John33', N'Carson33', N'Carson33, user33', N'user33.carson33@ng.kpmg.com', N'Deal Advisory', N'Tax', NULL, N'Senior Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (73, 15678474, N'user85', N'John85', N'Carson85', N'Carson85, user85', N'user85.carson85@ng.kpmg.com', N'Audit-DPP', N'Tax', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (74, 15678396, N'user7', N'John7', N'Carson7', N'Carson7, user7', N'user7.carson7@ng.kpmg.com', N'TRPS-CM', N'Advisory', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (75, 15678486, N'user97', N'John97', N'Carson97', N'Carson97, user97', N'user97.carson97@ng.kpmg.com', N'Deal Advisory', N'Advisory', NULL, N'Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (76, 15678408, N'user19', N'John19', N'Carson19', N'Carson19, user19', N'user19.carson19@ng.kpmg.com', N'Deal Advisory', N'Tax', NULL, N'Senior Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (77, 15678485, N'user96', N'John96', N'Carson96', N'Carson96, user96', N'user96.carson96@ng.kpmg.com', N'FRM', N'Audit', NULL, N'Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (78, 15678406, N'user17', N'John17', N'Carson17', N'Carson17, user17', N'user17.carson17@ng.kpmg.com', N'ITS', N'Tax', NULL, N'Exp. Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (79, 15678472, N'user83', N'John83', N'Carson83', N'Carson83, user83', N'user83.carson83@ng.kpmg.com', N'MC', N'Tax', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (80, 15678420, N'user31', N'John31', N'Carson31', N'Carson31, user31', N'user31.carson31@ng.kpmg.com', N'forensic', N'Audit', NULL, N'Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (81, 15678415, N'user26', N'John26', N'Carson26', N'Carson26, user26', N'user26.carson26@ng.kpmg.com', N'Audit-DPP', N'Advisory', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (82, 15678409, N'user20', N'John20', N'Carson20', N'Carson20, user20', N'user20.carson20@ng.kpmg.com', N'forensic', N'Central Services', NULL, N'Partner', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (83, 15678419, N'user30', N'John30', N'Carson30', N'Carson30, user30', N'user30.carson30@ng.kpmg.com', N'MC', N'Audit', NULL, N'Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (84, 15678395, N'user6', N'John6', N'Carson6', N'Carson6, user6', N'user6.carson6@ng.kpmg.com', N'ITS', N'Tax', NULL, N'Senior Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (85, 15678475, N'user86', N'John86', N'Carson86', N'Carson86, user86', N'user86.carson86@ng.kpmg.com', N'Deal Advisory', N'Tax', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (86, 15678416, N'user27', N'John27', N'Carson27', N'Carson27, user27', N'user27.carson27@ng.kpmg.com', N'ITS', N'Central Services', NULL, N'Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (87, 15678468, N'user79', N'John79', N'Carson79', N'Carson79, user79', N'user79.carson79@ng.kpmg.com', N'Deal Advisory', N'Central Services', NULL, N'Associate Director', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (88, 15678405, N'user16', N'John16', N'Carson16', N'Carson16, user16', N'user16.carson16@ng.kpmg.com', N'IARCS', N'Tax', NULL, N'Assitance Manager', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (89, 15678406, N'user17', N'John17', N'Carson17', N'Carson17, user17', N'user17.carson17@ng.kpmg.com', N'D&A', N'Advisory', NULL, N'Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (90, 15678425, N'user36', N'John36', N'Carson36', N'Carson36, user36', N'user36.carson36@ng.kpmg.com', N'Audit-FSI', N'Advisory', NULL, N'Partner', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (91, 15678405, N'user16', N'John16', N'Carson16', N'Carson16, user16', N'user16.carson16@ng.kpmg.com', N'D&A', N'Tax', NULL, N'Exp. Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (92, 15678394, N'user5', N'John5', N'Carson5', N'Carson5, user5', N'user5.carson5@ng.kpmg.com', N'forensic', N'Tax', NULL, N'Senior Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (93, 15678451, N'user62', N'John62', N'Carson62', N'Carson62, user62', N'user62.carson62@ng.kpmg.com', N'forensic', N'Advisory', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (94, 15678399, N'user10', N'John10', N'Carson10', N'Carson10, user10', N'user10.carson10@ng.kpmg.com', N'Audit-FSI', N'Advisory', NULL, N'Analyst', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (95, 15678438, N'user49', N'John49', N'Carson49', N'Carson49, user49', N'user49.carson49@ng.kpmg.com', N'IARCS', N'Audit', NULL, N'Senior Associate', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (96, 15678407, N'user18', N'John18', N'Carson18', N'Carson18, user18', N'user18.carson18@ng.kpmg.com', N'forensic', N'Central Services', NULL, N'Assitance Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (97, 15678482, N'user93', N'John93', N'Carson93', N'Carson93, user93', N'user93.carson93@ng.kpmg.com', N'FRM', N'Central Services', NULL, N'Exp. Analyst', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (98, 15678440, N'user51', N'John51', N'Carson51', N'Carson51, user51', N'user51.carson51@ng.kpmg.com', N'Deal Advisory', N'Audit', NULL, N'Manager', 0, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
INSERT [dbo].[Staffs] ([id], [personnelId], [username], [firstName], [lastName], [displayName], [email], [unit], [division], [jobTitle], [level], [status], [birthDay], [cardDownloadLink], [createdAt], [updatedAt]) VALUES (99, 15678474, N'user85', N'John85', N'Carson85', N'Carson85, user85', N'user85.carson85@ng.kpmg.com', N'IARCS', N'Advisory', NULL, N'Senior Associate', 1, NULL, NULL, CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset), CAST(N'2021-01-10T13:34:25.6290000+00:00' AS DateTimeOffset))
GO
SET IDENTITY_INSERT [dbo].[Staffs] OFF
SET IDENTITY_INSERT [dbo].[Statuses] ON 

INSERT [dbo].[Statuses] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'pending', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
INSERT [dbo].[Statuses] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'approved', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
INSERT [dbo].[Statuses] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'rejected', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[Statuses] OFF
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([id], [userId], [roleId], [createdAt], [updatedAt]) VALUES (2, 3, 1, CAST(N'2022-11-17T16:34:55.1730000+00:00' AS DateTimeOffset), CAST(N'2022-11-18T02:10:14.8360000+00:00' AS DateTimeOffset))
INSERT [dbo].[UserRoles] ([id], [userId], [roleId], [createdAt], [updatedAt]) VALUES (3, 4, 2, CAST(N'2022-11-17T16:41:04.7970000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:41:04.7970000+00:00' AS DateTimeOffset))
INSERT [dbo].[UserRoles] ([id], [userId], [roleId], [createdAt], [updatedAt]) VALUES (4, 5, 3, CAST(N'2022-11-17T16:58:01.7410000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:58:01.7410000+00:00' AS DateTimeOffset))
INSERT [dbo].[UserRoles] ([id], [userId], [roleId], [createdAt], [updatedAt]) VALUES (5, 6, 1, CAST(N'2022-11-17T16:59:05.6680000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:59:05.6680000+00:00' AS DateTimeOffset))
INSERT [dbo].[UserRoles] ([id], [userId], [roleId], [createdAt], [updatedAt]) VALUES (6, 7, 1, CAST(N'2022-11-17T17:00:14.5360000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T17:00:14.5360000+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [username], [password], [firstName], [lastName], [email], [division], [unit], [jobTitle], [profilePicture], [isDeleted], [createdAt], [updatedAt]) VALUES (3, N'WAndem', N'$2a$10$WStMd738JrliQoII/HeBeOiaX9tP.3EuYVcSoDx3yJgZJCRSzVXB2', N'Willaims', N'Andem', N'WAndem@ng.kpmg.com', N'Central Services', N'audit-cm', N'Analyst', N'https://pod51200.outlook.com/owa/service.svc/s/GetPersonaPhoto?email=WAndem@ng.kpmg.com&UA=0&size=HR96x96', 0, CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
INSERT [dbo].[Users] ([id], [username], [password], [firstName], [lastName], [email], [division], [unit], [jobTitle], [profilePicture], [isDeleted], [createdAt], [updatedAt]) VALUES (4, N'OAladeusi', N'$2a$10$kWWPJg.oJ48wIpbuIS48SeGH8dGu2EzjLB3X6kObLOcwQ8WwsiCf6', N'Olugbenga', N'Aladeusi', N'OAladeusi@ng.kpmg.com', N'Central Services', N'forensic', N'Analyst', N'https://pod51200.outlook.com/owa/service.svc/s/GetPersonaPhoto?email=OAladeusi@ng.kpmg.com&UA=0&size=HR96x96', 0, CAST(N'2022-11-17T16:41:04.7820000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:41:04.7820000+00:00' AS DateTimeOffset))
INSERT [dbo].[Users] ([id], [username], [password], [firstName], [lastName], [email], [division], [unit], [jobTitle], [profilePicture], [isDeleted], [createdAt], [updatedAt]) VALUES (5, N'Ujoseph', N'$2a$10$UGwWI26.U5FsyEbOO1aVrujgvNJQhOL8ornas.6BTka6FcSWoAB76', N'Utibe', N'Joseph', N'UJoseph@ng.kpmg.com', N'Audit', N'FRM', N'Analyst', N'https://pod51200.outlook.com/owa/service.svc/s/GetPersonaPhoto?email=UJoseph@ng.kpmg.com&UA=0&size=HR96x96', 0, CAST(N'2022-11-17T16:58:01.7190000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:58:01.7190000+00:00' AS DateTimeOffset))
INSERT [dbo].[Users] ([id], [username], [password], [firstName], [lastName], [email], [division], [unit], [jobTitle], [profilePicture], [isDeleted], [createdAt], [updatedAt]) VALUES (6, N'user69', N'$2a$10$l72LndAhJQp5gnUmm.xQeOLDlUz90hBAOny9/NbBl5a4BJ.3UWIZW', N'John69', N'Carson69', N'user69.carson69@ng.kpmg.com', N'Central Services', N'MC', N'Analyst', N'https://pod51200.outlook.com/owa/service.svc/s/GetPersonaPhoto?email=user69.carson69@ng.kpmg.com&UA=0&size=HR96x96', 0, CAST(N'2022-11-17T16:59:05.6600000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:59:05.6600000+00:00' AS DateTimeOffset))
INSERT [dbo].[Users] ([id], [username], [password], [firstName], [lastName], [email], [division], [unit], [jobTitle], [profilePicture], [isDeleted], [createdAt], [updatedAt]) VALUES (7, N'user36', N'$2a$10$zFM481S8ZtynwWkeqyZPCerNAkRFWKrnrLQ2FgnhqEzli1PEA1ox6', N'John36', N'Carson36', N'user36.carson36@ng.kpmg.com', N'Audit', N'Audit-CM', N'Analyst', N'https://pod51200.outlook.com/owa/service.svc/s/GetPersonaPhoto?email=user36.carson36@ng.kpmg.com&UA=0&size=HR96x96', 0, CAST(N'2022-11-17T17:00:14.5200000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T17:00:14.5200000+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[Values] ON 

INSERT [dbo].[Values] ([id], [name], [createdAt], [updatedAt]) VALUES (1, N'Value 1', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
INSERT [dbo].[Values] ([id], [name], [createdAt], [updatedAt]) VALUES (2, N'Value 2', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
INSERT [dbo].[Values] ([id], [name], [createdAt], [updatedAt]) VALUES (3, N'Value 3', CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset), CAST(N'2022-11-17T16:34:55.1570000+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[Values] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Sequeliz__72E12F1BF5036B44]    Script Date: 7/4/2023 8:18:43 AM ******/
ALTER TABLE [dbo].[SequelizeMeta] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([approverId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([approverId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Categories] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([nomineeId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([nomineeId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([sponsorId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([sponsorId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([statusId])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([statusId])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([valueId])
REFERENCES [dbo].[Values] ([id])
GO
ALTER TABLE [dbo].[Nominations]  WITH CHECK ADD FOREIGN KEY([valueId])
REFERENCES [dbo].[Values] ([id])
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[Roles] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
USE [master]
GO
ALTER DATABASE [EncoreDB] SET  READ_WRITE 
GO
