USE [ITIDB]
GO
/****** Object:  StoredProcedure [dbo].[answersreport]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[answersreport] @exam_no int ,@student_id int
as
begin
select MCQ_Description,stu_answer 
from MCQ_Question,Exam_MCQ,Exam 
where @exam_no=Exam_MCQ.Exam_ID and @student_id=Exam.Stu_ID and Que_ID=MCQ_QuestID
union 
select TF_Description,stu_answer 
from TF_Question,Exam_TF,Exam
where @exam_no=Exam_TF.Exam_ID and @student_id=Exam.Stu_ID and Que_ID=TF_Quest_ID
end
GO
/****** Object:  StoredProcedure [dbo].[correct_proc]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[correct_proc]   @examid int
as
begin
declare @studid int ,@course_id int 
select  @studid=Stu_ID ,@course_id=course_id--know student who has exam and course
from [dbo].[Exam]
WHERE Exam_ID=@examid;

declare @count int
set @count=0
----------------------MCQ-----------------
DECLARE stu_mcqanswer  CURSOR FOR  
SELECT  stu_answer,Que_ID
FROM Exam_MCQ
declare @student_answer nvarchar(50),@que_num int ,@model_answer nvarchar(50)
open stu_mcqanswer 
fetch  stu_mcqanswer into @student_answer,@que_num
While @@fetch_status=0 
begin
select @model_answer=[MCQAnswer]  
from [dbo].[MCQ_Question]
where MCQ_QuestID=@que_num
if(@model_answer=@student_answer)
set @count=@count+1
fetch  stu_mcqanswer into @student_answer,@que_num
end
close stu_mcqanswer
deallocate stu_mcqanswer
--------------------Tf-----------------
DECLARE stu_TFanswer  CURSOR FOR  
SELECT  [stu_answer],[Que_ID]
FROM Exam_TF
WHERE Exam_ID=@examid;
open stu_TFanswer 
fetch  stu_TFanswer into @student_answer,@que_num
While @@fetch_status=0 
begin
select @model_answer= [TF_Answer]
from [dbo].[TF_Question]
where [TF_Quest_ID]=@que_num
if(@model_answer=@student_answer)
set @count=@count+1
fetch  stu_TFanswer into @student_answer,@que_num
end
close stu_TFanswer
deallocate stu_TFanswer
-------------putting grade into student--------
update stu_courses
set grade=@count
where stu_id=@studid and cousre_id=@course_id
end

GO
/****** Object:  StoredProcedure [dbo].[course_sel]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[course_sel] (@p_CourseID int)

As
Begin 
	select Course_code,Course_Name,Instructor_ID from Course
	where Course_code= @p_CourseID
	
End 
GO
/****** Object:  StoredProcedure [dbo].[course_track_sel]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[course_track_sel] (@p_CourseID int)

As
Begin 
	select  CourseID ,TrackID from Course_Track
	
where   CourseID =@p_CourseID
End 

GO
/****** Object:  StoredProcedure [dbo].[crsInfo_stuGrade]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[crsInfo_stuGrade] @Instructor_ID int
AS
BEGIN
select Course_Name,count(st.stu_id) as student_number 
from Instructor i  inner join [dbo].[Course] c
on c.Instructor_ID=i.Instructor_ID inner join stu_courses st
on c.Course_code =st.cousre_id
where i.Instructor_ID=@Instructor_ID
group by(Course_Name)
end
GO
/****** Object:  StoredProcedure [dbo].[deleteCourse]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteCourse] @p_CourseID int
 As
 Begin
 delete from Course where Course_code=@p_CourseID
 End
GO
/****** Object:  StoredProcedure [dbo].[deleteCourse_Track]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteCourse_Track] @p_CourseID int,@p_TrackID int
 As
 Begin
 delete from Course_Track where CourseID=@p_CourseID and TrackID=@p_TrackID
 End
GO
/****** Object:  StoredProcedure [dbo].[deleteExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteExam] @p_ExamID int
 As
 Begin
 delete from Exam where Exam_id=@p_ExamID
 End
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromMCQ_Question]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteFromMCQ_Question] @MCQQuestID int
 As
 Begin
 delete from MCQ_Question where MCQ_QuestID =@MCQQuestID
 End
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromTF_Question]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[DeleteFromTF_Question]
 @TFQuestID int
 As
 Begin
 delete from TF_Question where TF_Quest_ID = @TFQuestID
 End
GO
/****** Object:  StoredProcedure [dbo].[deleteInstructor]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteInstructor] @p_InstructorID int
 As
 Begin
 delete from Instructor where Instructor_ID=@p_InstructorID
 End
GO
/****** Object:  StoredProcedure [dbo].[deleteMCQExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[deleteMCQExam] @p_ExamID int,@p_Que_ID int,@p_stu_answer varchar(50)
 As
 Begin
 delete from Exam_MCQ where Exam_ID=@p_ExamID and Que_ID=@p_Que_ID
 End
GO
/****** Object:  StoredProcedure [dbo].[deleteSTUDENT]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteSTUDENT] @p_STUDENTID int
 As
 Begin
 delete from STUDENT where stud_id=@p_STUDENTID
 End
GO
/****** Object:  StoredProcedure [dbo].[deleteTFExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteTFExam] @p_ExamID int,@p_Que_ID int,@p_stu_answer varchar(50)
 As
 Begin
 delete from Exam_TF where Exam_ID=@p_ExamID and Que_ID=@p_Que_ID
 End

GO
/****** Object:  StoredProcedure [dbo].[deleteTrack]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[deleteTrack] @p_TrackID int
 As
 Begin
 delete from Tracks where Track_code=@p_TrackID
 End
GO
/****** Object:  StoredProcedure [dbo].[exam_questions]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[exam_questions] @exam int
as
begin
select  m.MCQ_Description
from [dbo].[MCQ_Question] m inner join [dbo].[Exam_MCQ] e
on m.MCQ_QuestID=e.Que_ID and e.Exam_ID=@exam
 end
GO
/****** Object:  StoredProcedure [dbo].[Exam_Questions2]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Exam_Questions2] @exam int
as
begin
select t.TF_Description
from  [dbo].[TF_Question]  t inner join [dbo].[Exam_TF] e
on t.TF_Quest_ID=e.Que_ID and e.Exam_ID=@exam
end
GO
/****** Object:  StoredProcedure [dbo].[generateEaxm]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[generateEaxm]  (@p_mcq int,@p_tf int,@p_course int)
as
begin
declare @examidf int,@examidi int
select  @examidf= Exam_id
from [dbo].[Exam]
set @examidi=isnull(@examidf,0)+1
SET IDENTITY_INSERT Exam ON
insert into Exam (Exam_id) values (@examidi)
update Exam
set course_id=@p_course
where Exam_id=@examidi

insert into Exam_MCQ(Exam_ID,Que_ID)
select   TOP (@p_mcq)   @examidi,MCQ_QuestID
from [dbo].[MCQ_Question]
where Course_ID=@p_course
ORDER BY NEWID()
insert into Exam_TF(Exam_ID,Que_ID)
select   TOP (@p_tf)   @examidi,TF_Quest_ID
from [dbo].[TF_Question]
where Course_ID=@p_course
ORDER BY NEWID()

end








GO
/****** Object:  StoredProcedure [dbo].[getExamquestion]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getExamquestion]  @examid int  , @stu_id int
as
begin
update  [dbo].[Exam]
set  Stu_ID= @stu_id
where Exam_id=@examid
select MCQ_QuestID, MCQ_Description,MCQ_Choice_A,MCQ_Choice_B,MCQ_Choice_C,MCQ_Choice_D
from MCQ_Question inner join Exam_MCQ
on MCQ_QuestID=Que_ID and Exam_ID=@examid
select TF_Quest_ID,TF_Description
from TF_Question inner join Exam_TF
on TF_Quest_ID=Que_ID and Exam_ID=@examid
end
GO
/****** Object:  StoredProcedure [dbo].[insertCourse]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertCourse] (@p_CourseID int,@p_Course_Name varchar(20),@p_InstructorID int)
 As 
 insert into Course(Course_code,Course_Name,Instructor_ID)values (@p_CourseID,@p_Course_Name,@p_InstructorID);
 
GO
/****** Object:  StoredProcedure [dbo].[insertCourse_Track]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertCourse_Track] (@p_TrackID int,@p_CourseID int)
 As 
 insert into Course_Track(CourseID,TrackID)values (@p_CourseID,@p_TrackID);
GO
/****** Object:  StoredProcedure [dbo].[insertExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertExam] (@p_subject varchar(500),@p_studentID int)
 As 
 insert into Exam(Exam_subject,Stu_ID)values (@p_subject ,@p_studentID);

 
GO
/****** Object:  StoredProcedure [dbo].[insertInstructor]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertInstructor] (@p_InstructorID int,@p_Ins_Fname varchar(50),@p_Ins_Lname varchar(50))
 As 
 Begin
 insert into Instructor(Instructor_ID,Ins_Fname,Ins_Lname)values (@p_InstructorID,@p_Ins_Fname,@p_Ins_Lname);
 End
GO
/****** Object:  StoredProcedure [dbo].[insertMCQExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertMCQExam] (@p_ExamID int,@p_Que_ID int,@p_stu_answer varchar(50))
 As 
 insert into Exam_MCQ(Exam_ID,Que_ID,stu_answer)values (@p_ExamID,@p_Que_ID,@p_stu_answer);

GO
/****** Object:  StoredProcedure [dbo].[insertSTUDENT]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertSTUDENT] (@p_STUDENTID int,@p_Stu_Fname varchar(50),@p_Stu_Lname varchar(50),@p_stud_UserName varchar(50),@p_stud_password varchar(50)) 
 As 
 Begin
 insert into STUDENT(stud_id,stud_Fname,stud_Lname,stud_UserName,stud_password)values (@p_STUDENTID,@p_Stu_Fname,@p_Stu_Lname,@p_stud_UserName ,@p_stud_password )
 End
GO
/****** Object:  StoredProcedure [dbo].[insertTFExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertTFExam] (@p_ExamID int,@p_Que_ID int,@p_stu_answer varchar(50))
 As 
 insert into Exam_TF(Exam_ID,Que_ID,stu_answer)values (@p_ExamID,@p_Que_ID,@p_stu_answer);

GO
/****** Object:  StoredProcedure [dbo].[insertToMCQ_Question]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[insertToMCQ_Question] 
(@text nvarchar(max),@Choice_a nvarchar(2),@Choice_b nvarchar(2),@Choice_c nvarchar(2),@Choice_d nvarchar(2),
@mcq_answer nvarchar(2),@courseID int) 
 As 
 Begin
 insert into MCQ_Question(MCQ_Description,
 MCQ_Choice_A,
 MCQ_Choice_B,
 MCQ_Choice_C,
 MCQ_Choice_D,
 MCQAnswer,
Course_ID)values (@text,@Choice_a,@Choice_b,@Choice_c ,@Choice_d,@mcq_answer,@courseID )
 End
GO
/****** Object:  StoredProcedure [dbo].[insertToTF_Question]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertToTF_Question]
(@text nvarchar(max),@answer nvarchar(5),@courseID int) 
 As 
 Begin
 insert into TF_Question(TF_Description,
 TF_Answer,
 Course_ID)
 values (@text,@answer ,@courseID)
 End
GO
/****** Object:  StoredProcedure [dbo].[insertTrack]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[insertTrack] (@p_TrackID int,@p_Track_Name varchar(20))
 As 
 insert into Tracks(Track_code,Track_Name)values (@p_TrackID,@p_Track_Name);
 
GO
/****** Object:  StoredProcedure [dbo].[put_TF_answer]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[put_TF_answer] @examid int,  @p_quesid int ,@p_answer varchar(20)
as
begin
 update Exam_TF
 set stu_answer=@p_answer
 where Que_ID=@p_quesid and Exam_ID=@examid
 end
GO
/****** Object:  StoredProcedure [dbo].[putmcqanswer]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[putmcqanswer]  @examid int, @p_quesid int ,@p_answer varchar(20)
as
begin
 update Exam_MCQ
 set stu_answer=@p_answer
 where Que_ID=@p_quesid and Exam_ID=@examid
 end
GO
/****** Object:  StoredProcedure [dbo].[select_MCQ_Exam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[select_MCQ_Exam] (@p_ExamID int,@p_Que_ID int)
 As
 select  stu_answer
 from Exam_MCQ
 where Exam_ID=@p_ExamID and Que_ID=@p_Que_ID
GO
/****** Object:  StoredProcedure [dbo].[select_TF_Exam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[select_TF_Exam] (@p_ExamID int,@p_Que_ID int)
 As
 select  stu_answer
 from Exam_TF
 where Exam_ID=@p_ExamID and Que_ID=@p_Que_ID
GO
/****** Object:  StoredProcedure [dbo].[SELECTExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SELECTExam] (@p_studentID int)
As
Begin 
SELECT Exam_subject,Stu_ID FROM Exam 
where Stu_ID=@p_studentID
End
GO
/****** Object:  StoredProcedure [dbo].[SelectFromMCQ_Question]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectFromMCQ_Question] 
@MCQQuestID int
as
begin
select * from  MCQ_Question where MCQ_QuestID = @MCQQuestID
 End
GO
/****** Object:  StoredProcedure [dbo].[SELECTinstructor]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SELECTinstructor] (@Instructor_ID int)
As
Begin 
SELECT  Instructor_ID ,Ins_Fname,Ins_Lname FROM  instructor
 where  Instructor_ID =@Instructor_ID 
 End
GO
/****** Object:  StoredProcedure [dbo].[SELECTstudent]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SELECTstudent] (@student_ID int)
As
Begin 
select stud_id ,stud_Fname ,stud_Lname ,stud_UserName ,stud_password ,stud_Grade from STUDENT
where  stud_id=@student_ID 
End
GO
/****** Object:  StoredProcedure [dbo].[SelectTF_Question]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SelectTF_Question] @TFQuestID int
as
begin
select * from  TF_Question where TF_Quest_ID = @TFQuestID
 End
GO
/****** Object:  StoredProcedure [dbo].[SELECTtrack]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SELECTtrack] (@Track_code int)
As
Begin 
select Track_code,Track_Name from Tracks
where  Track_code=@Track_code
End
GO
/****** Object:  StoredProcedure [dbo].[student_information]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[student_information] @track_number int
as
begin
select * 
from [dbo].[STUDENT] as s inner join stu_tracks as st 
on s.stud_id=st.stu_id
where st.track_id=@track_number
end
GO
/****** Object:  StoredProcedure [dbo].[stuGrade]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[stuGrade] @stu_id int
AS
BEGIN
select st.grade,c.Course_Name
from  [dbo].[stu_courses] st inner join Course c
on st.cousre_id=c.Course_code
where stu_id=@stu_id
end
GO
/****** Object:  StoredProcedure [dbo].[topicsincourse]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[topicsincourse] @course_ID int
as
begin
select Topic_name,Topics.Topic_id
from Topics,Courses_Topics
where Course_id=@course_ID and Topics.Topic_id=Courses_Topics.Topic_ID
end
GO
/****** Object:  StoredProcedure [dbo].[update_Track]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[update_Track] @p_TrackID int,@p_TrackName varchar(20)
as
update Tracks 
set Track_Name=@p_TrackName
where Track_code= @p_TrackID
GO
/****** Object:  StoredProcedure [dbo].[updateCourse]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateCourse] @p_CourseID int,@p_Course_Name varchar(20),@p_Instructor_ID int
as
update Course
set Course_Name=@p_Course_Name,Instructor_ID=@p_Instructor_ID
where Course_code=@p_CourseID
GO
/****** Object:  StoredProcedure [dbo].[updateCourse_Track]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[updateCourse_Track] @p_TrackID int,@p_CourseID int
as
update Course_Track
set CourseID=@p_CourseID
where TrackID=@p_TrackID

GO
/****** Object:  StoredProcedure [dbo].[updateExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateExam] (@p_ExamID int,@p_subject varchar(500),@p_studentID int)
as
update Exam
set Stu_ID=Stu_ID,Exam_subject=Exam_subject
where Exam_id=@p_ExamID
GO
/****** Object:  StoredProcedure [dbo].[updateInstructor]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateInstructor] @p_InstructorID int,@p_Ins_Fname varchar(20),@p_Ins_Lname varchar(50)
as
begin
update Instructor
set Ins_Fname=@p_Ins_Fname,Ins_Lname=@p_Ins_Lname
where Instructor_ID=@p_InstructorID
end
GO
/****** Object:  StoredProcedure [dbo].[updateMCQExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[updateMCQExam] @p_ExamID int,@p_Que_ID int,@p_stu_answer varchar(50)
as
update Exam_MCQ
set stu_answer=@p_stu_answer
where Exam_ID=@p_ExamID and Que_ID=@p_Que_ID

GO
/****** Object:  StoredProcedure [dbo].[UpdateMCQQuestion]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateMCQQuestion](@MCQQuestID int , @text nvarchar(max),@Choice_a nvarchar(2),
@Choice_b nvarchar(2),@Choice_c nvarchar(2),@Choice_d nvarchar(2),
@mcq_answer nvarchar(2),@courseID int) 
as
begin
update MCQ_Question

set MCQ_Description=@text,
MCQ_Choice_A  = @Choice_a,
MCQ_Choice_B  = @Choice_b,
MCQ_Choice_C  = @Choice_c,
MCQ_Choice_D  = @Choice_d,
MCQAnswer	  = @mcq_answer,
Course_ID	  = @courseID

where MCQ_QuestID =@MCQQuestID
end
GO
/****** Object:  StoredProcedure [dbo].[updateStudent]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateStudent](@p_STUDENTID int,@p_Stu_Fname varchar(50),@p_Stu_Lname varchar(50),@p_stud_UserName varchar(50),@p_stud_password varchar(50)) 
as
begin
update STUDENT
set stud_Lname=@p_Stu_Fname,stud_Fname=@p_Stu_Lname,stud_UserName=@p_stud_UserName,stud_password=@p_stud_password
where stud_id=@p_STUDENTID
end
GO
/****** Object:  StoredProcedure [dbo].[updateTFExam]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[updateTFExam] @p_ExamID int,@p_Que_ID int,@p_stu_answer varchar(50)
as
update Exam_TF
set stu_answer=@p_stu_answer
where Exam_ID=@p_ExamID and Que_ID=@p_Que_ID

GO
/****** Object:  StoredProcedure [dbo].[UpdateTFQuest]    Script Date: 3/1/2020 6:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[UpdateTFQuest] ( @TFQuestID int,@text nvarchar(max),@answer nvarchar(5),@courseID int) 
as
begin

update TF_Question
set TF_Description =@text,
TF_Answer  = @answer,
Course_ID  = @courseID
where TF_Quest_ID = @TFQuestID
end
GO
