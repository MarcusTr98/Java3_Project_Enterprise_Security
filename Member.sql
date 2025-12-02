USE master
GO
DROP DATABASE IF EXISTS Members
GO
CREATE DATABASE Members
GO
USE Members
GO
GO
CREATE TABLE Members(
	id int NOT NULL PRIMARY KEY IDENTITY(1,1),
	fullname nvarchar(50) not null,
	email nvarchar(50) not null UNIQUE,
	age int,
	gender bit
)

INSERT INTO Members (fullname, email, age, gender) VALUES
(N'Trần Ngọc Anh', 'anh123@gmail.com',25, 0),
(N'Marcus Ngô','ngoyada123@example.com',27, 1);

SELECT * FROM Members
Truncate table Members


CREATE TABLE Users (
    Username VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(50) NOT NULL, -- Trong thực tế phải lưu Hash (BCrypt), demo dùng plain text
    Fullname NVARCHAR(100),
    Email VARCHAR(100),
    Role BIT DEFAULT 0 -- 1: Admin, 0: User
);

INSERT INTO Users VALUES ('admin', '123', N'Marcus Tran', 'marcus@example.com', 1);
INSERT INTO Users VALUES ('user', '123', N'Nguyễn Văn An', 'a@example.com', 0);

SELECT * FROM Users