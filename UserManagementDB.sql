CREATE DATABASE UserManagementDB;
GO
USE UserManagementDB;
GO

-- Tạo bảng Users
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE, -- Tên đăng nhập (Không trùng)
    -- Quan trọng: Mật khẩu mã hóa BCrypt luôn dài 60 ký tự, 
    -- nhưng ta để 255 để dự phòng nâng cấp thuật toán sau này.
    Password VARCHAR(255) NOT NULL, 
    Fullname NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Role VARCHAR(20) DEFAULT 'USER', -- Phân quyền: 'ADMIN' hoặc 'USER'
    IsActive BIT DEFAULT 1, -- 1: Đang hoạt động, 0: Bị khóa
    LastLogin DATETIME DEFAULT NULL -- Thời điểm đăng nhập cuối
);
GO

-- Seeding
-- Password ở đây là chuỗi đã BĂM (Hash) của mật khẩu "123"
-- Chúng ta KHÔNG THỂ insert trực tiếp '123' vào đây được nữa.
INSERT INTO Users (Username, Password, Fullname, Email, Role, IsActive)
VALUES 
('user', '$2a$12$BsdwB04vyXZZyTkdAegvjOGaPu8pbRgRCsDScyzEEwuTZD5nL8pmi', N'Ngô Phương Anh', 'user@gmail.com', 'USER', 1),
('marcus', '$2a$12$2E.d6YQO94hhPaAiHu16d.0febXgE0zZBI22J9UVI.oKXHGXtGoRO', N'Marcus Tran', 'marcus@gmail.com', 'ADMIN', 1);
-- (Mật khẩu của cả user là: 123, marcus là 456)
GO

SELECT * FROM Users
TRUNCATE table Users