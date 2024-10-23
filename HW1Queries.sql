-- Problem 1
SELECT DISTINCT b.cname AS name
FROM borrower b
-- Grab all the loan information and join with borrower lno
JOIN loan l ON b.lno = l.no
WHERE l.type = 'jumbo mortgage';

-- Problem 2
SELECT DISTINCT c.name
FROM customer c
-- Grab all the borrower information and join with customer name
JOIN borrower b ON c.name = b.cname
-- Grab all the loan information and join it with the borrower loan number
JOIN loan l ON b.lno = l.no
-- After attaching the borrower information to the customer add the loan information
-- Select the names that match these conditions
WHERE l.type = 'jumbo mortgage'
   OR c.credit >= 750;
|
-- Problem 3
SELECT DISTINCT c.name
FROM customer c
-- Grab all the borrower information and join with the customer name
JOIN borrower b1 ON c.name = b1.cname
-- Grab all the loan information and join it with the borrower loan number
JOIN loan l1 ON b1.lno = l1.no
-- Grab all the borrower information and join with the customer name
JOIN borrower b2 ON c.name = b2.cname
-- Grab all the loan information and join it with the borrower loan number
JOIN loan l2 ON b2.lno = l2.no
-- Using the first group of rows find the names with jumbo mortage
WHERE l1.type = 'jumbo mortgage'
    -- Using the second group also check if that name has a student loan 
  AND l2.type = 'student';

-- Problem 4
SELECT DISTINCT c.name
FROM customer c
-- Keep checking for the abensence of a loan once it found don't include that 
-- The outer NOT EXISTS checks if there is any loan for which the customer is not a borrower
WHERE NOT EXISTS (
    SELECT l.no
    FROM loan l
    -- This inner NOT EXISTS checks if there is a loan in the loan table that the customer has not borrow
    WHERE NOT EXISTS (
        SELECT 1
        FROM borrower b
        WHERE b.cname = c.name  
          AND b.lno = l.no
    )
);

-- Problem 5
SELECT DISTINCT c.name
FROM customer c
-- This checks if there exists any "jumbo mortgage" or "student" loan in the loan table that the customer has not taken out
-- If we find that person ignore them
WHERE NOT EXISTS (
    SELECT l.no
    FROM loan l
    WHERE l.type IN ('jumbo mortgage', 'student')
    -- Find the loans that we are looking for & if there is a person who didn't have one ignore them
   
    -- The inner subquery checks whether the customer (c.name) has taken the current loan (l.no).
    -- If the customer has not taken that loan, the subquery will return no rows, and the NOT EXISTS condition will be true.
    -- Once we found the people with the loans types check if that exist
   AND NOT EXISTS (
        SELECT 1
        FROM borrower b
        WHERE b.cname = c.name
        AND b.lno = l.no
        -- Combine the loans with the borrowers
    )
);

-- Problem 6
-- We are looking for the names 
SELECT DISTINCT customer.name
-- From the customer table
FROM customer
WHERE NOT EXISTS (
    SELECT loan.no
    FROM loan
    WHERE loan.type = 'jumbo mortgage'
    -- Ignore the person who doesn't have a jumbo mortgage
    AND NOT EXISTS (
        SELECT 1
        FROM borrower
        WHERE borrower.cname = customer.name
        AND borrower.lno = loan.no
        -- Pair the borrowers with their loans
    )
)
OR NOT EXISTS (
    SELECT loan.no
    FROM loan
    WHERE loan.type = 'student'
    -- Ignore the person who doesn't have a student loan
    AND NOT EXISTS (
        SELECT 1
        FROM borrower
        WHERE borrower.cname = customer.name
        AND borrower.lno = loan.no
        -- Pair the borrowers with their loans
    )
);

-- Problem 7
-- Select two distinct names 
SELECT DISTINCT b1.cname AS name1, b2.cname AS name2
-- From the borrower table
FROM borrower b1
-- Add the borrower information to the first borrower
JOIN borrower b2 ON b1.lno = b2.lno
-- Only if the their name is next alphabetically
WHERE b1.cname < b2.cname;

-- Problem 8
-- Select the distinct loans
SELECT DISTINCT b1.lno AS loanNo
-- From the borrower table
FROM borrower b1
-- Join the borrower information from the 2nd borrower row with the same row that has the same loan
JOIN borrower b2 ON b1.lno = b2.lno
-- only if the names are different
WHERE b1.cname <> b2.cname;

-- Problem 9
-- Select the loans
SELECT l.no AS loanNo
-- From the loan table
FROM loan l
-- Join the borrower information from  the borrower table with
-- the information from the loan table
JOIN borrower b ON l.no = b.lno
-- Check for the rows that have smith in the cname column
WHERE b.cname = 'Smith'
-- And check if the row has the minCredit 
AND l.minCredit = (
    -- Get the max min credit 
    SELECT MAX(l2.minCredit)
    -- From the loans table
    FROM loan l2
    -- Match the rows from borrower table with the rows on the loan table where the loans number matches the loan number taken by the borrowers
    JOIN borrower b2 ON l2.no = b2.lno
    -- Only count the values if the borrower's name is Smith
    WHERE b2.cname = 'Smith'
);

-- Problem 10
-- Select the distinct loan numbers
SELECT DISTINCT l.no AS loanNo
-- From the loan table
FROM loan l
-- For all loans exclude the what doesn't exist using this query
-- For all loans check if the innery queury returns no rows
WHERE NOT EXISTS (
    -- Find one 1 row
    SELECT 1
    -- From the customer table
    FROM customer c
    -- Where the credit is less than 600
    WHERE c.credit < 600
    -- For all loans with above 600 credit exclude what doesn't exist using this query which is any loan that is missing a borrower from the borrower table
    -- For all loans above 600 check if the innery queury returns no rows
    AND NOT EXISTS (
        -- Find one 1 row
        SELECT 1
        -- From the borrow table
        FROM borrower b
        -- Where the borrowers name matches the customers name
        WHERE b.cname = c.name
        -- And the borrowers loan number matches the loan number
        AND b.lno = l.no
    )
);


