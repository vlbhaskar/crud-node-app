Create Database Customer
GO
USE Customer
CREATE TABLE customers(
	id INT IDENTITY(1,1)  PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	age INT,
	createdAt DATETIME DEFAULT GETDATE(),
	updatedAt DATETIME DEFAULT GETDATE()
)
GO
USE Customer
insert into customers(firstname,lastname,age) VALUES('Bhaskar','B',51)
insert into customers(firstname,lastname,age) VALUES('Srikanth','B',52)
