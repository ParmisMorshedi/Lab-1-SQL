USE [master]
GO
/****** Object:  Database [school]    Script Date: 2023-12-08 10:47:37 ******/
CREATE DATABASE [school]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'school', FILENAME = N'C:\Users\parmi\school.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'school_log', FILENAME = N'C:\Users\parmi\school_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [school] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [school].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [school] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [school] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [school] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [school] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [school] SET ARITHABORT OFF 
GO
ALTER DATABASE [school] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [school] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [school] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [school] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [school] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [school] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [school] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [school] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [school] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [school] SET  DISABLE_BROKER 
GO
ALTER DATABASE [school] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [school] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [school] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [school] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [school] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [school] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [school] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [school] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [school] SET  MULTI_USER 
GO
ALTER DATABASE [school] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [school] SET DB_CHAINING OFF 
GO
ALTER DATABASE [school] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [school] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [school] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [school] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [school] SET QUERY_STORE = ON
GO
ALTER DATABASE [school] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [school]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 2023-12-08 10:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassesID] [int] IDENTITY(1,1) NOT NULL,
	[ClassesName] [nvarchar](35) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 2023-12-08 10:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CoursesId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](10) NULL,
 CONSTRAINT [PK_Courses_1] PRIMARY KEY CLUSTERED 
(
	[CoursesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grades]    Script Date: 2023-12-08 10:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grades](
	[GradesID] [int] IDENTITY(1,1) NOT NULL,
	[Grade] [int] NOT NULL,
	[StudentsId_FK] [int] NOT NULL,
	[CoursesId_FK] [int] NOT NULL,
	[GradeDate] [date] NOT NULL,
 CONSTRAINT [PK__Grades__931A40BF1DDF7847] PRIMARY KEY CLUSTERED 
(
	[GradesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personal]    Script Date: 2023-12-08 10:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personal](
	[PersonalId] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nchar](50) NULL,
	[FirstName] [nchar](20) NULL,
 CONSTRAINT [PK_Personal_1] PRIMARY KEY CLUSTERED 
(
	[PersonalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 2023-12-08 10:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentsID] [int] IDENTITY(1,1) NOT NULL,
	[StudentsName] [nvarchar](35) NULL,
	[ClassesId_FK] [int] NOT NULL,
 CONSTRAINT [PK__Students__E956AB40CBBB9B28] PRIMARY KEY CLUSTERED 
(
	[StudentsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([ClassesID], [ClassesName]) VALUES (1, N'.net23')
INSERT [dbo].[Classes] ([ClassesID], [ClassesName]) VALUES (2, N'UX')
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([CoursesId], [Name]) VALUES (1, N'Backend   ')
INSERT [dbo].[Courses] ([CoursesId], [Name]) VALUES (2, N'Frontend  ')
INSERT [dbo].[Courses] ([CoursesId], [Name]) VALUES (3, N'IT Tech   ')
INSERT [dbo].[Courses] ([CoursesId], [Name]) VALUES (4, N'UX/UI     ')
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Grades] ON 

INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (1, 6, 1, 1, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (2, 8, 1, 1, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (3, 9, 1, 2, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (4, 10, 1, 2, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (5, 8, 1, 3, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (6, 4, 1, 3, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (7, 7, 2, 1, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (8, 5, 2, 1, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (9, 9, 2, 2, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (10, 4, 2, 2, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (11, 1, 2, 3, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (12, 5, 2, 3, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (13, 6, 3, 1, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (14, 9, 3, 1, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (15, 5, 3, 2, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (16, 10, 3, 2, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (17, 4, 3, 3, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (18, 7, 3, 3, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (19, 5, 4, 3, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (20, 3, 4, 3, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (21, 1, 4, 4, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (22, 3, 4, 4, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (23, 6, 5, 3, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (24, 8, 5, 3, CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (25, 9, 5, 4, CAST(N'2023-10-20' AS Date))
INSERT [dbo].[Grades] ([GradesID], [Grade], [StudentsId_FK], [CoursesId_FK], [GradeDate]) VALUES (26, 10, 5, 4, CAST(N'2023-11-20' AS Date))
SET IDENTITY_INSERT [dbo].[Grades] OFF
GO
SET IDENTITY_INSERT [dbo].[Personal] ON 

INSERT [dbo].[Personal] ([PersonalId], [Role], [FirstName]) VALUES (6, N'Teacher                                           ', N'Aldor               ')
INSERT [dbo].[Personal] ([PersonalId], [Role], [FirstName]) VALUES (7, N'Teacher                                           ', N'Christoffer         ')
INSERT [dbo].[Personal] ([PersonalId], [Role], [FirstName]) VALUES (8, N'Program Manager                                   ', N'Alexander           ')
INSERT [dbo].[Personal] ([PersonalId], [Role], [FirstName]) VALUES (1008, N'Teacher                                           ', N'Adam                ')
SET IDENTITY_INSERT [dbo].[Personal] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([StudentsID], [StudentsName], [ClassesId_FK]) VALUES (1, N'Parmis', 1)
INSERT [dbo].[Students] ([StudentsID], [StudentsName], [ClassesId_FK]) VALUES (2, N'Markus', 1)
INSERT [dbo].[Students] ([StudentsID], [StudentsName], [ClassesId_FK]) VALUES (3, N'Sara', 1)
INSERT [dbo].[Students] ([StudentsID], [StudentsName], [ClassesId_FK]) VALUES (4, N'Sina', 2)
INSERT [dbo].[Students] ([StudentsID], [StudentsName], [ClassesId_FK]) VALUES (5, N'John', 2)
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD  CONSTRAINT [FK__Grades__CoursesI__3D2915A8] FOREIGN KEY([CoursesId_FK])
REFERENCES [dbo].[Courses] ([CoursesId])
GO
ALTER TABLE [dbo].[Grades] CHECK CONSTRAINT [FK__Grades__CoursesI__3D2915A8]
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD  CONSTRAINT [FK__Grades__Students__3C34F16F] FOREIGN KEY([StudentsId_FK])
REFERENCES [dbo].[Students] ([StudentsID])
GO
ALTER TABLE [dbo].[Grades] CHECK CONSTRAINT [FK__Grades__Students__3C34F16F]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK__Students__Classe__1AD3FDA4] FOREIGN KEY([ClassesId_FK])
REFERENCES [dbo].[Classes] ([ClassesID])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK__Students__Classe__1AD3FDA4]
GO
USE [master]
GO
ALTER DATABASE [school] SET  READ_WRITE 
GO
