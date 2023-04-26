---Luis Abelardo Jara Hillpa

use master
go
DROP DATABASE IF EXISTS Registro_Notas_DB
GO
create database Registro_Notas_DB
go
use Registro_Notas_DB
go

------- student table
create table Student(
	IdStudent	varchar(10),
	NameStudent		varchar(30),
	LastName    varchar(30),
	primary key(IdStudent)
)

------- Professional school table
create table ProfessionalSchool(
	IdPS	varchar(10),
	NamePS	varchar(30),
	primary	key(IdPS)
)

------ Career table
create table Career(
	IdCareer		varchar(10),
	NameCareer		varchar(30),
	IdPS			varchar(10),
	primary key(IdCareer),
	foreign key(IdPS) references ProfessionalSchool
)

------ Semester table
create table Semester(
	IdSemester		varchar(10),
	IdCareer		varchar(10),
	IdPS			varchar(10),
	primary key(IdSemester),
	foreign key(IdCareer) references Career
)

------ Course table
create table Course(
	IdCourse	varchar(10),
	IdSemester	varchar(10),
	NameCourse	varchar(30),
	primary key(IdCourse),
	foreign key (IdSemester) references Semester
)

------ Teacher table
create table Teacher(
	IdTeacher		varchar(10),
	NameTeacher		varchar(30),
	LastName		varchar(30),
	primary key(IdTeacher)
)

------ StudentCourse table
create table StudentCourse(
	IdStudentCourse		varchar(10),
	IdStudent			varchar(10),
	IdCourse			varchar(10),
	primary key(IdStudentCourse),
	foreign key(IdStudent) references Student,
	foreign key(IdCourse) references Course
)

------ teacher course table
create table TeacherCourse(
	IdTeacher		varchar(10),
	IdCourse	varchar(10),
	primary key(IdTeacher, IdCourse),
	foreign key(IdCourse) references Course,
	foreign key(IdTeacher) references Teacher
)

------ subject table
create table Subjects(
	IdSubject		varchar(10),
	NameSubject		varchar(30),
	IdCourse		varchar(10),
	primary key(IdSubject),
	foreign key(IdCourse) references Course
)


create table Examn(
	IdExam				varchar(10),
	IdStudentCourse		varchar(10),
	Note		int,
	primary key(IdExam),
	foreign key(IdStudentCourse) references StudentCourse
)

create table QuestionsBank(
	IdQuestion			varchar(10),
	IdSubject			varchar(10),
	Question			varchar(100),
	primary key(IdQuestion),
	foreign key(IdSubject)references Subjects


)

create table AlternativeQuestion(
	IdAlternativeQuestion	varchar(10),
	IdQuestion				varchar(10),
	Alternative				varchar(150),
	IsCorrect				BIT,
	primary key(IdAlternativeQuestion),
	foreign key(IdQuestion) references QuestionsBank
)
create table ExamnQuestionsAnswer(
	IdExamnQuestion		varchar(10),
	IdExam				varchar(10),
	IdQuestion			varchar(10),
	IdAlternativeQuestion		varchar(10),
	IsCorrect			BIT,
	primary key(IdExamnQuestion),
	foreign key(IdExam) references Examn,
	foreign key(IdQuestion) references QuestionsBank,
	foreign key(IdAlternativeQuestion) references AlternativeQuestion
)

create table Review(
	IdReview	varchar(10),
	IdExamnQuestion	varchar(10),
	ReviewDescripcion	varchar(100),
	Interval		varchar(10),
	primary Key(IdReview),
	foreign key(IdExamnQuestion) references ExamnQuestionsAnswer
)

create table Task(
	IdTask				varchar(10),
	IdReview			varchar(10),
	Descripcion			varchar(50),
	DateTask				date,
	NumberQuestions		int,
	TimeTask			time,
	primary key(IdTask),
	foreign key(IdReview) references Review
)

create table ScheduleforReview(
	IdScheduleforReview		varchar(10),
	IdReview				varchar(10),
	TimeForReview			varchar(3),
	primary key(IdScheduleforReview),
	foreign key(IdReview) references Review
)
