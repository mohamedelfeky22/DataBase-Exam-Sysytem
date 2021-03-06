USE [ITIDB]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 3/1/2020 6:51:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Course]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[Course_code] [int] NOT NULL,
	[Course_Name] [varchar](20) NULL,
	[Instructor_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Course_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Course_Track]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course_Track](
	[CourseID] [int] NOT NULL,
	[TrackID] [int] NOT NULL,
 CONSTRAINT [c2] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[TrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Courses_Topics]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses_Topics](
	[Course_id] [int] NOT NULL,
	[Topic_id] [int] NOT NULL,
 CONSTRAINT [c37] PRIMARY KEY CLUSTERED 
(
	[Course_id] ASC,
	[Topic_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Exam]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[Exam_id] [int] IDENTITY(1,1) NOT NULL,
	[Stu_ID] [int] NULL,
	[course_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Exam_MCQ]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Exam_MCQ](
	[Exam_ID] [int] NOT NULL,
	[Que_ID] [int] NOT NULL,
	[stu_answer] [varchar](50) NULL,
 CONSTRAINT [c4] PRIMARY KEY CLUSTERED 
(
	[Que_ID] ASC,
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Exam_TF]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Exam_TF](
	[Exam_ID] [int] NOT NULL,
	[Que_ID] [int] NOT NULL,
	[stu_answer] [varchar](50) NULL,
 CONSTRAINT [c7] PRIMARY KEY CLUSTERED 
(
	[Que_ID] ASC,
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Instructor](
	[Instructor_ID] [int] NOT NULL,
	[Ins_Fname] [varchar](50) NULL,
	[Ins_Lname] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Instructor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MCQ_Question]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MCQ_Question](
	[MCQ_QuestID] [int] IDENTITY(1,1) NOT NULL,
	[MCQ_Description] [nvarchar](max) NOT NULL,
	[MCQ_Choice_A] [nvarchar](200) NOT NULL,
	[MCQ_Choice_B] [nvarchar](200) NOT NULL,
	[MCQ_Choice_C] [nvarchar](200) NOT NULL,
	[MCQ_Choice_D] [nvarchar](200) NULL,
	[MCQAnswer] [nvarchar](2) NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [PK_MCQQuestion] PRIMARY KEY CLUSTERED 
(
	[MCQ_QuestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[stu_courses]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stu_courses](
	[cousre_id] [int] NOT NULL,
	[stu_id] [int] NOT NULL,
	[grade] [int] NULL,
 CONSTRAINT [c33] PRIMARY KEY CLUSTERED 
(
	[cousre_id] ASC,
	[stu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[stu_tracks]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stu_tracks](
	[track_id] [int] NOT NULL,
	[stu_id] [int] NOT NULL,
 CONSTRAINT [c30] PRIMARY KEY CLUSTERED 
(
	[track_id] ASC,
	[stu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[STUDENT]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STUDENT](
	[stud_id] [int] NOT NULL,
	[stud_Fname] [varchar](50) NULL,
	[stud_Lname] [varchar](50) NULL,
	[stud_UserName] [varchar](50) NULL,
	[stud_password] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[stud_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TF_Question]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TF_Question](
	[TF_Quest_ID] [int] IDENTITY(1,1) NOT NULL,
	[TF_Description] [nvarchar](max) NOT NULL,
	[TF_Answer] [nvarchar](10) NOT NULL,
	[Course_ID] [int] NULL,
 CONSTRAINT [PK_TF_Question] PRIMARY KEY CLUSTERED 
(
	[TF_Quest_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topics]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Topics](
	[Topic_ID] [int] NOT NULL,
	[Topic_name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Topic_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tracks]    Script Date: 3/1/2020 6:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tracks](
	[Track_code] [int] NOT NULL,
	[Track_Name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Track_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [c1] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Instructor_ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [c1]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [c40] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Instructor_ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [c40]
GO
ALTER TABLE [dbo].[Course_Track]  WITH CHECK ADD  CONSTRAINT [c12] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[Course_Track] CHECK CONSTRAINT [c12]
GO
ALTER TABLE [dbo].[Courses_Topics]  WITH CHECK ADD  CONSTRAINT [c38] FOREIGN KEY([Course_id])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[Courses_Topics] CHECK CONSTRAINT [c38]
GO
ALTER TABLE [dbo].[Courses_Topics]  WITH CHECK ADD  CONSTRAINT [c39] FOREIGN KEY([Topic_id])
REFERENCES [dbo].[Topics] ([Topic_ID])
GO
ALTER TABLE [dbo].[Courses_Topics] CHECK CONSTRAINT [c39]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [c3] FOREIGN KEY([Stu_ID])
REFERENCES [dbo].[STUDENT] ([stud_id])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [c3]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [c36] FOREIGN KEY([course_id])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [c36]
GO
ALTER TABLE [dbo].[Exam_MCQ]  WITH CHECK ADD  CONSTRAINT [c15] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_id])
GO
ALTER TABLE [dbo].[Exam_MCQ] CHECK CONSTRAINT [c15]
GO
ALTER TABLE [dbo].[Exam_MCQ]  WITH CHECK ADD  CONSTRAINT [c17] FOREIGN KEY([Que_ID])
REFERENCES [dbo].[MCQ_Question] ([MCQ_QuestID])
GO
ALTER TABLE [dbo].[Exam_MCQ] CHECK CONSTRAINT [c17]
GO
ALTER TABLE [dbo].[Exam_MCQ]  WITH CHECK ADD  CONSTRAINT [c5] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_id])
GO
ALTER TABLE [dbo].[Exam_MCQ] CHECK CONSTRAINT [c5]
GO
ALTER TABLE [dbo].[Exam_MCQ]  WITH CHECK ADD  CONSTRAINT [c6] FOREIGN KEY([Que_ID])
REFERENCES [dbo].[MCQ_Question] ([MCQ_QuestID])
GO
ALTER TABLE [dbo].[Exam_MCQ] CHECK CONSTRAINT [c6]
GO
ALTER TABLE [dbo].[Exam_TF]  WITH CHECK ADD  CONSTRAINT [c16] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_id])
GO
ALTER TABLE [dbo].[Exam_TF] CHECK CONSTRAINT [c16]
GO
ALTER TABLE [dbo].[Exam_TF]  WITH CHECK ADD  CONSTRAINT [c18] FOREIGN KEY([Que_ID])
REFERENCES [dbo].[TF_Question] ([TF_Quest_ID])
GO
ALTER TABLE [dbo].[Exam_TF] CHECK CONSTRAINT [c18]
GO
ALTER TABLE [dbo].[Exam_TF]  WITH CHECK ADD  CONSTRAINT [c8] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_id])
GO
ALTER TABLE [dbo].[Exam_TF] CHECK CONSTRAINT [c8]
GO
ALTER TABLE [dbo].[Exam_TF]  WITH CHECK ADD  CONSTRAINT [c9] FOREIGN KEY([Que_ID])
REFERENCES [dbo].[TF_Question] ([TF_Quest_ID])
GO
ALTER TABLE [dbo].[Exam_TF] CHECK CONSTRAINT [c9]
GO
ALTER TABLE [dbo].[MCQ_Question]  WITH CHECK ADD  CONSTRAINT [c13] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[MCQ_Question] CHECK CONSTRAINT [c13]
GO
ALTER TABLE [dbo].[MCQ_Question]  WITH CHECK ADD  CONSTRAINT [c41] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[MCQ_Question] CHECK CONSTRAINT [c41]
GO
ALTER TABLE [dbo].[stu_courses]  WITH CHECK ADD  CONSTRAINT [c34] FOREIGN KEY([cousre_id])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[stu_courses] CHECK CONSTRAINT [c34]
GO
ALTER TABLE [dbo].[stu_courses]  WITH CHECK ADD  CONSTRAINT [c35] FOREIGN KEY([stu_id])
REFERENCES [dbo].[STUDENT] ([stud_id])
GO
ALTER TABLE [dbo].[stu_courses] CHECK CONSTRAINT [c35]
GO
ALTER TABLE [dbo].[stu_tracks]  WITH CHECK ADD  CONSTRAINT [c31] FOREIGN KEY([track_id])
REFERENCES [dbo].[Tracks] ([Track_code])
GO
ALTER TABLE [dbo].[stu_tracks] CHECK CONSTRAINT [c31]
GO
ALTER TABLE [dbo].[stu_tracks]  WITH CHECK ADD  CONSTRAINT [c32] FOREIGN KEY([stu_id])
REFERENCES [dbo].[STUDENT] ([stud_id])
GO
ALTER TABLE [dbo].[stu_tracks] CHECK CONSTRAINT [c32]
GO
ALTER TABLE [dbo].[TF_Question]  WITH CHECK ADD  CONSTRAINT [c14] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[TF_Question] CHECK CONSTRAINT [c14]
GO
ALTER TABLE [dbo].[TF_Question]  WITH CHECK ADD  CONSTRAINT [c42] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_code])
GO
ALTER TABLE [dbo].[TF_Question] CHECK CONSTRAINT [c42]
GO
