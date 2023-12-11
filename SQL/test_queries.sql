--  1. Add New Trainers
INSERT INTO Trainers (Name, Specialization) VALUES ('LeBron James', 'Cardio Specialist');
INSERT INTO Trainers (Name, Specialization) VALUES ('Stephen Curry', 'Weight Training');

-- 2. Add New Administrative Staff
INSERT INTO Administrative_Staff (Name, Role) VALUES ('Kevin Durant', 'Club Manager');
INSERT INTO Administrative_Staff (Name, Role) VALUES ('Giannis Antetokounmpo', 'Maintenance Supervisor');

-- 3. Add New Members
INSERT INTO Members (Name, Email, FitnessGoals, HealthMetrics) VALUES ('Kawhi Leonard', 'kawhi.leonard@example.com', 'Lose Weight', '{"height": 201, "weight": 102}');
INSERT INTO Members (Name, Email, FitnessGoals, HealthMetrics) VALUES ('James Harden', 'james.harden@example.com', 'Build Muscle', '{"height": 196, "weight": 99}');

-- 4. Add New Fitness Classes
INSERT INTO Fitness_Classes (ClassName, StartDate, EndDate, StartTime, EndTime, TrainerID, AdminStaffID) VALUES ('Cardio 101', '2023-07-01', '2023-12-31', '08:00', '09:00', 1, 1);
INSERT INTO Fitness_Classes (ClassName, StartDate, EndDate, StartTime, EndTime, TrainerID, AdminStaffID) VALUES ('Strength Training', '2023-07-01', '2023-12-31', '10:00', '11:00', 2, 1);

-- 5. Enroll Members in Fitness Classes
INSERT INTO Enrollment (MemberID, ClassID) VALUES (1, 1);
INSERT INTO Enrollment (MemberID, ClassID) VALUES (2, 2);

-- 6. Add Personal Training Sessions
INSERT INTO Personal_Training_Sessions (Date, Time, MemberID, TrainerID) VALUES ('2023-07-10', '15:00', 1, 2);
INSERT INTO Personal_Training_Sessions (Date, Time, MemberID, TrainerID) VALUES ('2023-07-11', '16:00', 2, 1);

-- 7. Add Equipment
INSERT INTO Equipment (Type, MaintenanceSchedule, AdminStaffID) VALUES ('Treadmill', 'Bi-weekly', 2);
INSERT INTO Equipment (Type, MaintenanceSchedule, AdminStaffID) VALUES ('Dumbbells', 'Monthly', 2);

-- 8. Add Loyalty Points for Members
INSERT INTO Loyalty_Points (MemberID, Points) VALUES (1, 100);
INSERT INTO Loyalty_Points (MemberID, Points) VALUES (2, 150);

-- 9. Process Payments from Members
INSERT INTO Payments (MemberID, Amount, PaymentDate, PaymentMethod, AdminStaffID) VALUES (1, 50.00, '2023-07-01', 'Credit Card', 1);
INSERT INTO Payments (MemberID, Amount, PaymentDate, PaymentMethod, AdminStaffID) VALUES (2, 75.00, '2023-07-02', 'Debit Card', 1);

-- 10. Update Member's Fitness Goals
UPDATE Members SET FitnessGoals = 'Run a Marathon' WHERE MemberID = 1;

-- 11. List All Classes with Enrolled Members
SELECT fc.ClassName, m.Name AS MemberName
FROM Fitness_Classes fc
JOIN Enrollment e ON fc.ClassID = e.ClassID
JOIN Members m ON e.MemberID = m.MemberID;

-- 12. Schedule Maintenance for Equipment
UPDATE Equipment SET MaintenanceSchedule = 'Weekly' WHERE Type = 'Treadmill';

-- 13. Add New Fitness Class
INSERT INTO Fitness_Classes (ClassName, StartDate, EndDate, StartTime, EndTime, TrainerID, AdminStaffID) VALUES ('Yoga for Beginners', '2023-08-01', '2023-12-31', '14:00', '15:00', 1, 2);

-- 14. Enroll a Member in the New Fitness Class
INSERT INTO Enrollment (MemberID, ClassID) VALUES (1, (SELECT ClassID FROM Fitness_Classes WHERE ClassName = 'Yoga for Beginners'));

-- 15. List All Equipment and Their Maintenance Schedules
SELECT Type, MaintenanceSchedule FROM Equipment;

-- 16. Update Member's Email Address
UPDATE Members SET Email = 'kawhi.newemail@example.com' WHERE MemberID = 1;

-- 17. List Members and Their Loyalty Points
SELECT m.Name, lp.Points FROM Members m JOIN Loyalty_Points lp ON m.MemberID = lp.MemberID;

-- 18. Record a New Payment for a Membership Fee
INSERT INTO Payments (MemberID, Amount, PaymentDate, PaymentMethod, AdminStaffID) VALUES (1, 120.00, '2023-08-01', 'Online Transfer', 1);

-- 19. List Personal Training Sessions for a Specific Member
SELECT Date, Time, t.Name AS TrainerName FROM Personal_Training_Sessions pts JOIN Trainers t ON pts.TrainerID = t.TrainerID WHERE pts.MemberID = 1;

-- 20. Remove a Member from a Fitness Class
DELETE FROM Enrollment WHERE MemberID = 1 AND ClassID = (SELECT ClassID FROM Fitness_Classes WHERE ClassName = 'Strength Training');

-- 21. List All Trainers and Their Specializations
SELECT Name, Specialization FROM Trainers;

-- 22. Update Trainer's Specialization
UPDATE Trainers SET Specialization = 'Aerobics' WHERE Name = 'LeBron James';

-- 23. Retrieve all Trainers and Their Conducted Classes
SELECT t.Name AS TrainerName, fc.ClassName
FROM Trainers t
JOIN Fitness_Classes fc ON t.TrainerID = fc.TrainerID;

-- 24. Retrieve Total Number of Members Enrolled in Each Class
SELECT fc.ClassName, COUNT(e.MemberID) AS TotalMembers
FROM Fitness_Classes fc
JOIN Enrollment e ON fc.ClassID = e.ClassID
GROUP BY fc.ClassName;

-- 25. Retrieve Members with Specific Fitness Goals
SELECT Name, FitnessGoals
FROM Members
WHERE FitnessGoals LIKE '%weight%';

-- 26. Retrieve Upcoming Personal Training Sessions for Next Week
SELECT pts.Date, pts.Time, m.Name AS MemberName, t.Name AS TrainerName
FROM Personal_Training_Sessions pts
JOIN Members m ON pts.MemberID = m.MemberID
JOIN Trainers t ON pts.TrainerID = t.TrainerID
WHERE pts.Date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days';

-- 27. Retrieve Equipment Due for Maintenance This Month
SELECT Type, MaintenanceSchedule
FROM Equipment
WHERE MaintenanceSchedule = 'Monthly';

-- 28. Retrieve Member Details and Their Total Loyalty Points
SELECT m.Name, m.Email, lp.Points
FROM Members m
JOIN Loyalty_Points lp ON m.MemberID = lp.MemberID;

-- 29. Retrieve Payment History for a Specific Member
SELECT PaymentDate, Amount, PaymentMethod
FROM Payments
WHERE MemberID = 1
ORDER BY PaymentDate DESC;

-- 30. Retrieve Email Addresses of All Members Who Joined Personal Training Sessions
SELECT DISTINCT m.Email
FROM Members m
JOIN Personal_Training_Sessions pts ON m.MemberID = pts.MemberID;

-- 31. Retrieve Staff Members Responsible for Equipment Maintenance
SELECT a.Name AS StaffName, e.Type AS EquipmentType
FROM Administrative_Staff a
JOIN Equipment e ON a.StaffID = e.AdminStaffID;

-- 32. Retrieve Fitness Classes Managed by a Specific Staff Member
SELECT fc.ClassName, a.Name AS StaffName
FROM Fitness_Classes fc
JOIN Administrative_Staff a ON fc.AdminStaffID = a.StaffID
WHERE a.Name = 'Kevin Durant';