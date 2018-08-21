 CREATE TABLE Person (PersonID int NOT NULL PRIMARY KEY, Lname VARCHAR(45), 
Fname VARCHAR(45), Age int, 
 Gender CHAR(1), State Varchar(45), City VARCHAR(45), Zipcode VARCHAR(5), 
 Address1 VARCHAR(45),Address2 VARCHAR(45));
-- FOREIGN KEY (PersonID) REFERENCES Employee(EmpID), -- EmpID is the id of an employee, which is a person
-- FOREIGN KEY (PersonID) REFERENCES Customer(CustID), -- CustID is the id of a Customer, which is a person
-- FOREIGN KEY (PersonID) REFERENCES Potential_Employee(PempID), -- pempID is the id of a Potential Employee, which is a person
-- FOREIGN KEY (PersonID) REFERENCES Phone_Number(PersonID)); -- For the mult-valued attribute

CREATE TABLE Employee(EmpID int NOT NULL PRIMARY KEY,
Rank VARCHAR(45), Title VARCHAR(45), SuperVisorID int,
FOREIGN KEY (EmpID) REFERENCES Person(PersonID),
FOREIGN KEY (SupervisorID) REFERENCES Employee(EmpID)); -- SuperVisor is an employee that has a number of supervisees, which are employees. Employees have at least one supervisor

CREATE TABLE Customer(CustID int NOT NULL PRIMARY KEY, SalesManID int,
FOREIGN KEY (CustID) REFERENCES Person(PersonID),
FOREIGN KEY (SalesManID) REFERENCES Employee(EmpID)); -- Customer has their prefeered salesman

CREATE TABLE Potential_Employee(PempID int NOT NULL PRIMARY KEY,
FOREIGN KEY (PempID) REFERENCES Person(PersonID)); -- May need a foreighn key 

CREATE TABLE Phone_Number(PID int NOT NULL PRIMARY KEY, PhoneNumber int,
FOREIGN KEY (PID) REFERENCES Person(PersonID));

CREATE TABLE EmpInfo(EmpID int NOT NULL, TransactNum int NOT NULL, amount int, pay_date date,
PRIMARY KEY(EmpID, TransactNum), 
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID));

CREATE TABLE Work(EmpID int NOT NULL, DepID int NOT NULL, startTime 
dateTime, EndTime dateTime, PRIMARY KEY(EmpID, DepID), 
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
FOREIGN KEY (DepID) REFERENCES Department(DepID));

CREATE TABLE Department(DepID int NOT NULL PRIMARY KEY, Dname VARCHAR(45));
                                                                      
CREATE TABLE JobPosition(JobID int NOT NULL, DepID int NOT NULL, PostDate
date,  PRIMARY KEY(JobID, DepID), 
FOREIGN KEY (DepID) REFERENCES Department(DepID));

CREATE TABLE JobDesc(JobID int NOT NULL PRIMARY KEY, JobDescription VARCHAR(3000));
-- FOREIGN KEY (DepID) REFERENCES Department(DepID));

-- may cause errors. primary keys used for multiple tables

CREATE TABLE Interview(JobID int NOT NULL, DepID int NOT NULL, 
Interviewer VARCHAR(45) NOT NULL, InterviewTime datetime NOT NULL, Grade int,
PRIMARY KEY(DepID, JobID,Interviewer, InterviewTime), 
FOREIGN KEY (DepID) REFERENCES JobPosition(DepID),
FOREIGN KEY (JobID) REFERENCES JobPosition(JobID));

-- M-N relation between potential employee and interview. 80 lines long
CREATE TABLE Interv(JobID int NOT NULL, DepID int NOT NULL, 
Interviewer VARCHAR(45) NOT NULL, InterviewTime datetime NOT NULL, pempID int NOT NULL,

PRIMARY KEY(JobID, DepID,Interviewer, InterviewTime, pempID), -- Grade int 
FOREIGN KEY (DepID) REFERENCES Interview(DepID),
FOREIGN KEY (JobID) REFERENCES Interview(JobID),
FOREIGN KEY (Interviewer) REFERENCES Interview(Interviewer),
FOREIGN KEY (InterviewTime) REFERENCES Interview(InterviewTime),
FOREIGN KEY (PempID) REFERENCES Potential_Employee(pempID));

-- 80 lines long
CREATE TABLE Apply(JobID int NOT NULL, DepID int NOT NULL, EmpID int NOT NULL, PempID int NOT NULL, 
PRIMARY KEY(JobID, DepID, PempID, EmpID),
FOREIGN KEY (JobID) REFERENCES JobPosition(JobID),
FOREIGN KEY (DepID) REFERENCES JobPosition(DepID),
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
FOREIGN KEY (PempID) REFERENCES Potential_Employee(PempID));

CREATE TABLE Product (ProdID int NOT NULL PRIMARY KEY, Price int, Type1 VARCHAR(45), 
Style VARCHAR(45), Weight int, Size int); -- 5 products
-- Product has 1 to N parts

CREATE TABLE Part (PartID int NOT NULL PRIMARY KEY, PartName VARCHAR(45), weight int); -- 20 parts

CREATE TABLE Vendor (VID int NOT NULL PRIMARY KEY, ActNum int, Vname VARCHAR(45), 
Vaddress VARCHAR(45), creditRating int, WebServiceURL int); -- 2 vendors

CREATE TABLE HavePart (ProdID int NOT NULL, PartID int NOT NULL,
PRIMARY KEY(ProdID, PartID),
FOREIGN KEY (PartID) REFERENCES Part(PartID),
FOREIGN KEY (ProdID) REFERENCES Product(ProdID)); -- m to n of profuct and part

CREATE TABLE SellParts (PartID int NOT NULL, VID int NOT NULL, PartPrice int,
PRIMARY KEY(PartID, VID),
FOREIGN KEY (PartID) REFERENCES Part(PartID),
FOREIGN KEY (VID) REFERENCES Vendor(VID));

CREATE TABLE Site (SID1 int NOT NULL PRIMARY KEY, Sname VARCHAR(45), 
SLocation VARCHAR(45)); -- 2 sites


CREATE TABLE SWORK (SID int NOT NULL, EmpID int NOT NULL,
PRIMARY KEY(SID, EmpID),
FOREIGN KEY (SID) REFERENCES Site(PartID),
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID));

CREATE TABLE Sales (SalesID int NOT NULL Primary KEY, SID int, ProdID1 int,
CustID int, EmpID int, salesTime dateTime,
FOREIGN KEY (SID) REFERENCES Site(SID1), -- Should it be to SWORK. Should sale have multiple prime attributes
FOREIGN KEY (ProdID1) REFERENCES Product(ProdID),
FOREIGN KEY (CustID) REFERENCES Customer(CustID));



