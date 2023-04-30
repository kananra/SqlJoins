CREATE DATABASE SqlJoins
USE SqlJoins


CREATE TABLE Groups
(
	Id INT PRIMARY KEY IDENTITY,
	No NVARCHAR(5)
)


CREATE TABLE Students
(
	Id INT PRIMARY KEY,
	FullName NVARCHAR(20),
	Point TINYINT CHECK(Point<=100),
	GroupId INT FOREIGN KEY REFERENCES Groups(Id)
)

CREATE TABLE Exams
(
	Id INT PRIMARY KEY,
	SubjectName NVARCHAR(20),
	StartDate DATETIME2,
	EndDate DATETIME2
)


CREATE TABLE StudentExams
(
	StudentId INT FOREIGN KEY REFERENCES Students(Id),
	ExamId INT FOREIGN KEY REFERENCES Exams(Id),
	ResultPoint INT,
	
)

INSERT INTO Groups
VALUES
('P328'),
('D327'),
('P323'),
('P324'),
('D323')

INSERT INTO Students
VALUES
(1,'Kenan Rehimov',100,1),
(2,'Yusif Memmedov',90,2),
(3,'Samir Memmedov',95,3),
(4,'Ekber Memmedov',85,4),
(5,'Natiq Nebiyev',40,5),
(6,'Nurlan Eliyev',50,2),
(7,'Tural Behbudov',78,1),
(8,'Eli Ferecov',87,3),
(9,'Natiq Bayramov',60,4),
(10,'Adil Veliyev',48,2),
(11,'Ramin Sultanov',35,1),
(12,'Vusal Ismayilov',25,5)



INSERT INTO Exams
VALUES
(1,'Kompüter arxitektur','2023-04-30 14:00','2023-04-30 15:30'),
(2,'Rəqəmsal sistemlər','2023-05-01 14:00','2023-05-01 15:30'),
(3,'Proqramlaşdırma','2023-05-01 14:00','2023-05-01 15:30'),
(4,'Kompüter şəbəkələri','2023-05-02 14:00','2023-05-01 15:30')

INSERT INTO StudentExams
VALUES
(1,1,100),
(1,2,100),
(1,3,100),
(1,4,100),
(2,1,90),
(3,3,80),
(2,4,70),
(11,1,60),
(10,3,50),
(2,3,70),
(5,2,60),
(3,4,98),
(7,1,60),
(4,1,60),
(8,3,50)


SELECT S.Id,FullName,Point,No AS GroupNo FROM Students AS S
JOIN Groups AS G
ON S.GroupId=G.Id



SELECT S.Id, FullName, Point, No AS GroupNo, 
       COUNT(SE.StudentId) AS ExamCount
FROM Students AS S
JOIN Groups AS G ON S.GroupId=G.Id
LEFT JOIN StudentExams AS SE ON S.Id = SE.StudentId
GROUP BY S.Id, FullName, Point, No



INSERT INTO Exams
VALUES (5, 'OOP', '2023-05-03 10:00', '2023-05-03 12:00')

SELECT DISTINCT Exams.Id, Exams.SubjectName
FROM Exams
LEFT JOIN StudentExams ON Exams.Id = StudentExams.ExamId
WHERE StudentExams.StudentId IS NULL;

UPDATE Exams
SET StartDate = '2023-04-29 15:00'
WHERE Id = 2

SELECT Exams.SubjectName, COUNT(DISTINCT StudentExams.StudentId) AS StudentCount
FROM Exams
JOIN StudentExams ON Exams.Id = StudentExams.ExamId
WHERE CONVERT(DATE, StartDate) = CONVERT(DATE, GETDATE() - 1)
GROUP BY Exams.Id, Exams.SubjectName;

SELECT SE.*, S.FullName, G.No AS GroupNo
FROM StudentExams AS SE
JOIN Students AS S ON SE.StudentId = S.Id
JOIN Groups AS G ON S.GroupId = G.Id


SELECT S.FullName, AVG(SE.ResultPoint) AS AvgResult
FROM Students AS S
LEFT JOIN StudentExams AS SE ON S.Id = SE.StudentId
GROUP BY S.Id, S.FullName
