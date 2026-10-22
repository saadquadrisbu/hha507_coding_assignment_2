-- HHA 507 - Coding Assignment 2

-- Step 1: Create a table for healthcare providers (used in the joins).
CREATE TABLE hha507_providers (
    provider_id INTEGER PRIMARY KEY,
    provider_name VARCHAR2(60) NOT NULL,
    specialty VARCHAR2(40),
    clinic_location VARCHAR2(40)
);

-- Step 1: Create a patient visits table with 10 columns and different data types.
CREATE TABLE hha507_patient_visits (
    visit_id INTEGER PRIMARY KEY,
    patient_name VARCHAR2(60) NOT NULL,
    age INTEGER,
    department VARCHAR2(40),
    visit_date DATE,
    check_in_time TIMESTAMP,
    wait_minutes INTEGER,
    visit_cost NUMBER(8,2),
    satisfaction_score BINARY_DOUBLE,
    provider_id INTEGER,
    CONSTRAINT fk_visit_provider
        FOREIGN KEY (provider_id)
        REFERENCES hha507_providers (provider_id)
);

-- Step 2: Insert 5 providers for the join queries.
INSERT INTO hha507_providers VALUES (1, 'Dr. Elena Morris', 'Cardiology', 'East Clinic');
INSERT INTO hha507_providers VALUES (2, 'Dr. Kevin Shah', 'Primary Care', 'Main Clinic');
INSERT INTO hha507_providers VALUES (3, 'Dr. Olivia Brooks', 'Orthopedics', 'West Clinic');
INSERT INTO hha507_providers VALUES (4, 'Dr. Daniel Kim', 'Urgent Care', 'Main Clinic');
INSERT INTO hha507_providers VALUES (5, 'Dr. Fatima Hassan', 'Pediatrics', 'East Clinic');

-- Step 2: Insert 12 patient visit records.
INSERT INTO hha507_patient_visits VALUES (1001, 'Alex Rivera', 44, 'Primary Care', DATE '2026-10-01', TIMESTAMP '2026-10-01 09:05:00', 12, 150.00, 4.7, 2);
INSERT INTO hha507_patient_visits VALUES (1002, 'Maya Chen', 29, 'Cardiology', DATE '2026-10-02', TIMESTAMP '2026-10-02 10:15:00', 18, 275.00, 4.9, 1);
INSERT INTO hha507_patient_visits VALUES (1003, 'Jordan Lee', 37, 'Orthopedics', DATE '2026-10-03', TIMESTAMP '2026-10-03 08:30:00', 25, 320.00, 4.5, 3);
INSERT INTO hha507_patient_visits VALUES (1004, 'Taylor Morgan', 51, 'Urgent Care', DATE '2026-10-04', TIMESTAMP '2026-10-04 13:00:00', 40, 190.00, 4.0, NULL);
INSERT INTO hha507_patient_visits VALUES (1005, 'Casey Patel', 63, 'Cardiology', DATE '2026-10-05', TIMESTAMP '2026-10-05 11:20:00', 35, 260.00, 4.2, 1);
INSERT INTO hha507_patient_visits VALUES (1006, 'Sam Brooks', 23, 'Primary Care', DATE '2026-10-06', TIMESTAMP '2026-10-06 09:40:00', 15, 130.00, 4.6, 2);
INSERT INTO hha507_patient_visits VALUES (1007, 'Riley Bennett', 42, 'Urgent Care', DATE '2026-10-07', TIMESTAMP '2026-10-07 14:10:00', 32, 210.00, 3.9, 4);
INSERT INTO hha507_patient_visits VALUES (1008, 'Quinn Adams', 11, 'Pediatrics', DATE '2026-10-08', TIMESTAMP '2026-10-08 10:05:00', 10, 145.00, 4.8, 5);
INSERT INTO hha507_patient_visits VALUES (1009, 'Morgan Lewis', 56, 'Orthopedics', DATE '2026-10-09', TIMESTAMP '2026-10-09 16:00:00', 28, 340.00, 4.4, 3);
INSERT INTO hha507_patient_visits VALUES (1010, 'Jamie Park', 34, 'Primary Care', DATE '2026-10-10', TIMESTAMP '2026-10-10 08:50:00', 22, 160.00, 4.1, NULL);
INSERT INTO hha507_patient_visits VALUES (1011, 'Drew Wilson', 48, 'Urgent Care', DATE '2026-10-11', TIMESTAMP '2026-10-11 12:45:00', 14, 185.00, 4.7, 4);
INSERT INTO hha507_patient_visits VALUES (1012, 'Training Record', 30, 'Primary Care', DATE '2026-10-12', TIMESTAMP '2026-10-12 15:20:00', 0, 0.00, NULL, 2);

-- Step 3: Update one patient's waiting time.
UPDATE hha507_patient_visits
SET wait_minutes = 30
WHERE visit_id = 1004;

-- Step 4: Add a new column.
ALTER TABLE hha507_patient_visits
ADD follow_up_needed VARCHAR2(10);

-- Step 5: Delete a row using a condition.
DELETE FROM hha507_patient_visits
WHERE patient_name = 'Training Record';

-- Step 6.1: Select specific fields and limit the results to 100 rows.
SELECT visit_id, patient_name, department,
       visit_date, wait_minutes, visit_cost
FROM hha507_patient_visits
ORDER BY visit_id
FETCH FIRST 100 ROWS ONLY;

-- Step 6.2: INNER JOIN two tables, limited to 100 rows.
SELECT p.visit_id, p.patient_name, p.department,
       d.provider_name, d.specialty
FROM hha507_patient_visits p
INNER JOIN hha507_providers d
ON p.provider_id = d.provider_id
ORDER BY p.visit_id
FETCH FIRST 100 ROWS ONLY;

-- Step 6.2: LEFT OUTER JOIN two tables, limited to 100 rows.
-- This includes visits without a matching provider.
SELECT p.visit_id, p.patient_name, p.department,
       d.provider_name, d.specialty
FROM hha507_patient_visits p
LEFT OUTER JOIN hha507_providers d
ON p.provider_id = d.provider_id
ORDER BY p.visit_id
FETCH FIRST 100 ROWS ONLY;
