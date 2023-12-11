# Functional Dependencies and Normalization Analysis

## Purpose

This document provides a detailed analysis of the database structure for the
Health and Fitness Club Management System. It is intended to validate that each
table within the database adheres to the principles of Second Normal Form (2NF)
and Third Normal Form (3NF). By examining the functional dependencies and the
relationships among the attributes within each table, this analysis ensures the
database design minimizes redundancy and supports data integrity.

Each table should meet the criteria for 2NF and 3NF:

- **2NF:** There are no partial dependencies of any column on a composite key.
- **3NF:** There are no transitive dependencies; non-prime attributes are only dependent on the primary keys.

1. **Members Table:**

   - Functional Dependencies: MemberID → Name, Email, FitnessGoals, HealthMetrics
   - This table is in 2NF because there are no partial dependencies of non-prime attributes on a part of a composite primary key (since the primary key is not composite).
   - It is also in 3NF because all non-prime attributes are only dependent on the primary key, not on any other non-prime attribute.

2. **Trainers Table:**

   - Functional Dependencies: TrainerID → Name, Specialization
   - This table is in 2NF and 3NF for the same reasons as the Members table.

3. **Administrative Staff Table:**

   - Functional Dependencies: StaffID → Name, Role
   - This table is in 2NF and 3NF as all non-prime attributes are fully functionally dependent on the primary key.

4. **Fitness Classes Table:**

   - Functional Dependencies: ClassID → ClassName, StartDate, EndDate, StartTime, EndTime, TrainerID
   - This table is in 2NF and 3NF. Each non-prime attribute is fully functionally dependent on the primary key.

5. **Personal Training Sessions Table:**

   - Functional Dependencies: SessionID → Date, Time, MemberID, TrainerID
   - This table is in 2NF and 3NF. No non-prime attribute is dependent on another non-prime attribute, and all are dependent on the primary key.

6. **Equipment Table:**

   - Functional Dependencies: EquipmentID → Type, MaintenanceSchedule
   - This table is in 2NF and 3NF because each non-prime attribute is only dependent on the primary key.

7. **Enrollment Table:**

   - Functional Dependencies: MemberID, ClassID → None
   - This table is a junction table that resolves the many-to-many relationship between Members and Fitness Classes. It is in 2NF and 3NF as it only contains the composite primary key and no other attributes.

8. **Loyalty Points Table:**

   - Functional Dependencies: MemberID → Points
   - This table is in 2NF and 3NF. The points are fully functionally dependent on the primary key, which is the MemberID.

9. **Payments Table:**

   - Functional Dependencies: PaymentID → MemberID, Amount, PaymentDate, PaymentMethod
   - This table is in 2NF and 3NF, with the primary key being PaymentID and all other attributes depending on it.

10. **User Authentication Table:**

    - Functional Dependencies: UserID → Email, PasswordHash
    - This table is in 2NF and 3NF, as all attributes depend only on the primary key.
