CREATE DATABASE bankDB;

USE bankDB;

CREATE TABLE Customers(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
gender ENUM('Male', 'Female') NOT NULL,
dob DATE NOT NULL,
city VARCHAR(50),
customer_segment ENUM('Retail', 'SME', 'Corporate', 'Premium') NOT NULL,
kyc_status ENUM('verified','Pending','Rejected') DEFAULT 'Verified',
created_at DATE NOT NULL
);

CREATE TABLE Accounts(
account_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
account_type ENUM('Savings', 'Current', 'Business') NOT NULL,
opening_balance DECIMAL(15,2) NOT NULL,
current_balance DECIMAL(15,2) NOT NULL,
account_status ENUM('Active', 'Dormant', 'Closed') DEFAULT 'Active',
opened_date DATE NOT NULL,

	CONSTRAINT fk_accounts_customers
		FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions(
transaction_id INT AUTO_INCREMENT PRIMARY KEY,
account_id INT NOT NULL,
transaction_datetime DATETIME NOT NULL,
transaction_type ENUM('ATM','UPI_TRANSFER','CARD','MERCHANT','BANK_TRANSFER') NOT NULL,
transaction_direction ENUM('Credit','Debit') NOT NULL,
amount DECIMAL(15,2) NOT NULL,
merchant_name VARCHAR(100),
channel ENUM('Mobile','ATM', 'POS', 'Internet Banking', 'Branch') NOT NULL,
transaction_status ENUM('Successful','Failed','Reversed') DEFAULT 'Successful',
fraud_flag BOOLEAN DEFAULT FALSE,

		CONSTRAINT fk_transactions_accounts
			FOREIGN KEY (account_id)
            REFERENCES Accounts(account_id)
);

CREATE TABLE Audit_Log(
audit_id INT AUTO_INCREMENT PRIMARY KEY,
transaction_id INT,
account_id INT,
alert_type VARCHAR(100),
alert_description TEXT,
transaction_amount DECIMAL(15,2),
transaction_datetime DATETIME,
logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

		CONSTRAINT fk_audit_transactions
			FOREIGN KEY (transaction_id)
            REFERENCES Transactions(transaction_id),
            
		CONSTRAINT fk_audit_accounts
			FOREIGN KEY (account_id)
            REFERENCES Accounts(account_id)
);