INSERT INTO customer (name, credit) VALUES 
    ('Alice', 750),
    ('Bob', 680),
    ('Charlie', 800),
    ('Diana', 620),
    ('Eve', 580),  -- Credit < 600 for Problem 10
    ('Frank', 550),  -- Credit < 600 for Problem 10
    ('George', 770),
    ('Hannah', 760),
    ('Smith', 700); -- Added for problem 9

INSERT INTO loan (no, type, minCredit) VALUES 
    ('L1001', 'jumbo mortgage', 750),
    ('L1002', 'student', 600),
    ('L1003', 'personal', 680),
    ('L1004', 'jumbo mortgage', 760),
    ('L1005', 'car', 650),
    ('L1006', 'student', 610),
    ('L1007', 'business', 700);

INSERT INTO borrower (cname, lno, due) VALUES 
    -- Jumbo mortgage loans for problem 1, 2, 3, 5, 6
    ('Alice', 'L1001', '2025-12-31'),  -- Alice took a jumbo mortgage loan (Problem 1)
    ('Bob', 'L1002', '2024-05-15'),    -- Bob took a student loan (Problem 3)
    ('Charlie', 'L1001', '2027-06-30'), -- Charlie took a jumbo mortgage loan and will be shared (Problem 7)
    ('Charlie', 'L1002', '2027-06-30'), -- Charlie took a student loan (Problem 3)
    ('Diana', 'L1003', '2025-10-01'),   -- Diana took a personal loan
    ('Eve', 'L1006', '2023-12-31'),     -- Eve took a student loan, credit < 600 (Problem 10)
    ('Frank', 'L1006', '2023-12-31'),   -- Frank took a student loan, credit < 600 (Problem 10)
    ('George', 'L1004', '2025-11-30'),  -- George took another jumbo mortgage loan (Problem 6)
    ('Hannah', 'L1004', '2026-04-15'),  -- Hannah took a jumbo mortgage loan
    ('Smith', 'L1007', '2025-12-01'),   -- Smith took a business loan (Problem 9)
    ('Smith', 'L1003', '2025-11-20');   -- Smith took a personal loan (Problem 9)
