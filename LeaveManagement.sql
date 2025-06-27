CREATE DATABASE LeaveManagement;
GO

-- Sử dụng cơ sở dữ liệu vừa tạo
USE LeaveManagement;
GO

-- Tạo bảng Users (Thông tin người dùng)
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL, 
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Role NVARCHAR(50) NOT NULL,
    Division NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NULL, -- Ngày sinh
    Gender NVARCHAR(10) NULL, -- Giới tính (Nam, Nữ, Khác)
    PhoneNumber NVARCHAR(20) NULL, -- Số điện thoại
    Address NVARCHAR(255) NULL, -- Địa chỉ
    HireDate DATE NULL, -- Ngày vào làm
    JobTitle NVARCHAR(100) NULL, -- Chức danh công việc
    ManagerID INT NULL, -- ID của người quản lý trực tiếp
    FOREIGN KEY (ManagerID) REFERENCES Users(UserID)
);

-- Tạo bảng LeaveTypes (Loại nghỉ phép)
CREATE TABLE LeaveTypes (
    LeaveTypeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL, -- Tên loại nghỉ phép (VD: Nghỉ bệnh, Nghỉ phép năm)
    Description NVARCHAR(255) NULL -- Mô tả loại nghỉ phép
);

-- Tạo bảng LeaveRequests (Đơn xin nghỉ phép)
CREATE TABLE LeaveRequests (
    RequestID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    LeaveTypeID INT FOREIGN KEY REFERENCES LeaveTypes(LeaveTypeID),
    FromDate DATE NOT NULL,
    ToDate DATE NOT NULL,
    Reason NVARCHAR(255) NULL,
    Status NVARCHAR(50) NOT NULL, -- Trạng thái (Draft, Approved, Rejected)
    ManagerNote NVARCHAR(255) NULL, -- Ghi chú của Manager
    ProofFile NVARCHAR(255) NULL, -- File chứng minh nghỉ phép (đường dẫn hoặc tên file)
    CreatedAt DATETIME DEFAULT GETDATE() -- Thời gian tạo đơn
);

-- Tạo bảng Attendance (Chấm công)
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    Date DATE NOT NULL,
    CheckInTime TIME NULL, -- Thời gian vào làm
    CheckOutTime TIME NULL, -- Thời gian ra về
    Status NVARCHAR(50) NOT NULL -- Trạng thái (Present, Absent, Leave)
);

-- Tạo bảng Agenda (Lịch làm việc)
CREATE TABLE Agenda (
    AgendaID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    Date DATE NOT NULL,
    Task NVARCHAR(255) NOT NULL, -- Nhiệm vụ hoặc công việc trong ngày
    CreatedAt DATETIME DEFAULT GETDATE() -- Thời gian tạo lịch làm việc
);

-- Thêm dữ liệu mẫu vào bảng Users
INSERT INTO Users (UserName, Password, Email, Role, Division, DateOfBirth, Gender, PhoneNumber, Address, HireDate, JobTitle, ManagerID)
VALUES 
('Mr A', 'adminpass', 'mra@example.com', 'Admin', 'IT', '1980-05-15', 'Male', '0901234567', N'123 Đường ABC, Hà Nội', '2010-01-01', 'IT Director', NULL),
('Mr B', 'managerpass', 'mrb@example.com', 'Manager', 'IT', '1985-11-20', 'Male', '0912345678', N'456 Đường XYZ, TP.HCM', '2015-03-10', 'IT Manager', 1),
('Mr C', 'staffpass1', 'mrc@example.com', 'Staff', 'IT', '1990-03-01', 'Female', '0923456789', N'789 Phố DEF, Đà Nẵng', '2018-07-15', 'Software Engineer', 2),
('Mr D', 'staffpass2', 'mrd@example.com', 'Staff', 'QA', '1992-07-25', 'Male', '0934567890', N'101 Ngõ GHI, Hải Phòng', '2019-09-01', 'QA Tester', 2),
('Mr E', 'staffpass3', 'mre@example.com', 'Staff', 'Sale', '1995-01-10', 'Female', '0945678901', N'202 Hẻm JKL, Cần Thơ', '2020-02-20', 'Sales Representative', 2);

-- Thêm dữ liệu mẫu vào bảng LeaveTypes
INSERT INTO LeaveTypes (Name, Description)
VALUES 
('Annual Leave', N'Nghỉ phép năm'),
('Sick Leave', N'Nghỉ bệnh'),
('Unpaid Leave', N'Nghỉ không lương');

-- Thêm dữ liệu mẫu vào bảng LeaveRequests
INSERT INTO LeaveRequests (UserID, LeaveTypeID, FromDate, ToDate, Reason, Status, ManagerNote, ProofFile)
VALUES 
(3, 1, '2025-01-01', '2025-01-03', N'Đi du lịch', 'Inprogress', NULL, NULL),
(4, 2, '2025-01-01', '2025-01-05', N'Thăm gia đình', 'Rejected', N'Không hợp lý', 'proof1.jpg');

-- Thêm dữ liệu mẫu vào bảng Attendance
INSERT INTO Attendance (UserID, Date, CheckInTime, CheckOutTime, Status)
VALUES 
(3, '2025-01-01', '08:00:00', '17:00:00', 'Present'),
(3, '2025-01-02', NULL, NULL, 'Leave'),
(3, '2025-01-03', NULL, NULL, 'Absent'),
(4, '2025-01-01', '08:30:00', '17:30:00', 'Present'),
(4, '2025-01-02', NULL, NULL, 'Leave');

-- Thêm dữ liệu mẫu vào bảng Agenda
INSERT INTO Agenda (UserID, Date, Task)
VALUES 
(3, '2025-01-01', N'Hoàn thành báo cáo dự án'),
(3, '2025-01-02', N'Tham gia họp nhóm'),
(4, '2025-01-01', N'Kiểm tra chất lượng sản phẩm'),
(4, '2025-01-02', N'Chuẩn bị tài liệu thuyết trình');
GO

-- Kiểm tra kết quả
SELECT * FROM Users;
SELECT * FROM LeaveTypes;
SELECT * FROM LeaveRequests;
SELECT * FROM Attendance;
SELECT * FROM Agenda;