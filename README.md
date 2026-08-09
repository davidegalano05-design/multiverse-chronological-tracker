🗄️ Enterprise Relational Database System



📌 Project Overview

This project is a comprehensive Relational Database Management System (RDBMS) designed as a case study during my Computer Engineering studies at Politecnico di Bari. It simulates a robust backend for an E-commerce and Inventory Management platform, focusing on data integrity, normalization, and advanced database programming.



Core Technologies: SQL, Oracle PL/SQL, Relational Algebra.



🏗️ Architecture \& Database Design



The database was designed following strict normalization rules (up to 3NF) to avoid data redundancy and anomalies.



The Entity-Relationship (ER) model includes the following core entities:



Customers: Stores user demographics and authentication data.



Products: Manages inventory, pricing, and stock levels.



Orders \& Order\_Details: Handles transactional data and links products to customers.



Audit\_Logs: A system table to track critical changes and monitor database security.



⚙️ Key Features \& PL/SQL Implementation



Rather than just executing basic CRUD operations, the system leverages PL/SQL to push the business logic directly into the database layer, ensuring maximum performance and consistency.



1\. Automated Stock Management (Triggers)

I implemented database triggers to automate inventory updates and prevent overselling.



Example Logic: Before an order is confirmed, a BEFORE INSERT trigger checks if the requested quantity is available in the Products table. If successful, it automatically deducts the stock; if not, it raises a custom application error.



2\. Transactional Integrity (Stored Procedures)

Complex operations involving multiple tables are encapsulated within Stored Procedures to guarantee ACID compliance (Atomicity, Consistency, Isolation, Durability).



Example Logic: The Process\_Order procedure takes a customer ID and a cart list. It initiates a transaction, inserts the master order record, iterates through the items to insert them into Order\_Details, and finally commits the transaction only if no errors occur.



3\. Data Auditing

A trigger is attached to the Products and Orders tables to track price changes and cancellations. Every time a record is updated or deleted, the old values, the user ID, and a timestamp are automatically written into the Audit\_Logs table.



💡 What I Learned



Building this architecture solidified my understanding of how databases operate under the hood in enterprise environments. It bridged the gap between theoretical relational algebra and practical database administration, highlighting why robust constraints and server-side logic (PL/SQL) are crucial for software engineering.

