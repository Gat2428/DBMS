CREATE DATABASE students;
USE students;

CREATE TABLE Teacher(
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(50)
);

CREATE TABLE Subject(
    SubjectCode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(100),
    CreditValue INT,
    ModuleLeader VARCHAR(50),
    Department VARCHAR(10),
    PrerequisiteCourse VARCHAR(100),
    TeacherID INT,
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID)
);

CREATE TABLE Teaches(
    TeacherID INT,
    SubjectCode VARCHAR(10),
    PRIMARY KEY (TeacherID, SubjectCode),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode)
);

CREATE TABLE Student(
    SerialNumber INT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100)
);

CREATE TABLE StudentProgress(
    SerialNumber INT,
    SubjectCode VARCHAR(10),
    FinalIA INT,
    PRIMARY KEY (SerialNumber, SubjectCode),
    FOREIGN KEY (SerialNumber) REFERENCES Student(SerialNumber),
    FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode)
);

INSERT INTO Teacher VALUES
(1,'Prof. Saranya'),
(2,'Prof. Chandramma'),
(3,'Prof Hemalatha'),
(4,'Prof. Veena'),
(5,'Prof. Manjunath');

INSERT INTO Subject VALUES
('CML42','Database Management System',4,'Prof. Saranya','CSE',NULL,1),
('CSE34','Operating Systems',3,'Prof. Chandramma','ISE','Introduction to Computing',2),
('CSE33','Algorithm Design',4,'Prof Hemalatha','CSE','Data Structures',3),
('ISE55','Network Security',3,'Prof. Veena','ISE','Networking Fundamentals',4),
('ISE54','Advanced Python',3,'Prof. Chandramma','ISE','Python Fundamentals',2),
('CSE12','C Programming',4,'Prof. Saranya','CSE',NULL,1);

INSERT INTO Teaches VALUES
(1,'CML42'),
(1,'CSE12'),
(2,'CSE34'),
(3,'CSE33'),
(4,'ISE55'),
(5,'ISE54');

INSERT INTO Student VALUES
(1001,'John','RR NAGAR, BANGALORE'),
(1002,'Jane','JAYANAGAR, BANGALORE'),
(1003,'Adithya','Car street, MANGALORE'),
(1004,'Neha','udayavara, UDUPI');

INSERT INTO StudentProgress VALUES
(1001,'CML42',85),
(1002,'CSE34',60),
(1003,'CSE33',35),
(1004,'ISE55',72);

SELECT TeacherName
FROM Teacher
WHERE TeacherName NOT IN (
    SELECT ModuleLeader
    FROM Subject
);

SELECT Department
FROM Subject
WHERE Title = 'Database Management System';

SELECT T.TeacherName,
COUNT(Tc.SubjectCode) AS NumberOfSubjects
FROM Teacher T
JOIN Teaches Tc
ON T.TeacherID = Tc.TeacherID
GROUP BY T.TeacherName;

SELECT S.SerialNumber,
S.Name,
SP.SubjectCode,
SP.FinalIA,
CASE
    WHEN SP.FinalIA BETWEEN 70 AND 100 THEN 'Outstanding'
    WHEN SP.FinalIA BETWEEN 40 AND 69 THEN 'Average'
    ELSE 'Weak'
END AS Category
FROM Student S
JOIN StudentProgress SP
ON S.SerialNumber = SP.SerialNumber;
