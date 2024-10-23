-- Create the 'customer' table
CREATE TABLE customer (
    name VARCHAR(100) PRIMARY KEY,
    credit INT
);

-- Create the 'loan' table
CREATE TABLE loan (
    no VARCHAR(50) PRIMARY KEY,
    type VARCHAR(50),
    minCredit INT
);

-- Create the 'borrower' table
CREATE TABLE borrower (
    cname VARCHAR(100),
    lno VARCHAR(50),
    due DATE,
    PRIMARY KEY (cname, lno),
    FOREIGN KEY (cname) REFERENCES customer(name),
    FOREIGN KEY (lno) REFERENCES loan(no)
);
