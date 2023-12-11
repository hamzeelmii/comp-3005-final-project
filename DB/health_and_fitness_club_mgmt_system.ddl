/*
  Hamze Elmi
  Final Project
  COMP 3005
*/


-- Trainers Table
CREATE TABLE Trainers (
  TrainerID SERIAL PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Specialization TEXT
);

-- Administrative Staff Table
CREATE TABLE Administrative_Staff (
  StaffID SERIAL PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Role VARCHAR(255) NOT NULL
);

-- Members Table
CREATE TABLE Members (
  MemberID SERIAL PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL UNIQUE,
  FitnessGoals TEXT,
  HealthMetrics JSONB
);

-- Fitness Classes Table
CREATE TABLE Fitness_Classes (
  ClassID SERIAL PRIMARY KEY,
  ClassName VARCHAR(255) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  StartTime TIME NOT NULL,
  EndTime TIME NOT NULL,
  TrainerID INT,
  AdminStaffID INT,
  FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID),
  FOREIGN KEY (AdminStaffID) REFERENCES Administrative_Staff(StaffID)
);

-- Personal Training Sessions Table
CREATE TABLE Personal_Training_Sessions (
  SessionID SERIAL PRIMARY KEY,
  Date DATE NOT NULL,
  Time TIME NOT NULL,
  MemberID INT,
  TrainerID INT,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID)
);

-- Equipment Table
CREATE TABLE Equipment (
  EquipmentID SERIAL PRIMARY KEY,
  Type VARCHAR(255) NOT NULL,
  MaintenanceSchedule TEXT,
  AdminStaffID INT,
  FOREIGN KEY (AdminStaffID) REFERENCES Administrative_Staff(StaffID)
);

-- Enrollment Table
CREATE TABLE Enrollment (
  MemberID INT,
  ClassID INT,
  PRIMARY KEY (MemberID, ClassID),
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (ClassID) REFERENCES Fitness_Classes(ClassID)
);

-- Loyalty Points Table
CREATE TABLE Loyalty_Points (
  MemberID INT PRIMARY KEY,
  Points INT NOT NULL,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Payments Table
CREATE TABLE Payments (
  PaymentID SERIAL PRIMARY KEY,
  MemberID INT,
  Amount DECIMAL(10, 2) NOT NULL,
  PaymentDate DATE NOT NULL,
  PaymentMethod VARCHAR(255) NOT NULL,
  AdminStaffID INT,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (AdminStaffID) REFERENCES Administrative_Staff(StaffID)
);

-- Unified User Authentication Table
CREATE TABLE User_Authentication (
  UserID SERIAL PRIMARY KEY,
  Email VARCHAR(255) NOT NULL UNIQUE,
  PasswordHash VARCHAR(255) NOT NULL,
  MemberID INT UNIQUE,
  TrainerID INT UNIQUE,
  StaffID INT UNIQUE,
  FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
  FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID),
  FOREIGN KEY (StaffID) REFERENCES Administrative_Staff(StaffID)
);