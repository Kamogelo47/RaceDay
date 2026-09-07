/*
    RaceDay - PROG6212 Portfolio of Evidence - Part 1
    Section C - SQL Database Script

    Database: RaceDayDB
    Platform: Microsoft SQL Server / SSMS

    This script creates the RaceDay database tables and inserts
    realistic sample data for Part 1.
*/

IF DB_ID('RaceDayDB') IS NULL
BEGIN
    CREATE DATABASE RaceDayDB;
END
GO

USE RaceDayDB;
GO

/* =========================
   1. USERS
   ========================= */
IF OBJECT_ID('dbo.Users', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Users
    (
        UserID INT IDENTITY(1,1) NOT NULL,
        FirstName VARCHAR(50) NOT NULL,
        LastName VARCHAR(50) NOT NULL,
        Email VARCHAR(100) NOT NULL,
        PasswordHash VARCHAR(255) NOT NULL,
        Phone VARCHAR(20) NULL,
        Role VARCHAR(20) NOT NULL,
        DateCreated DATETIME NOT NULL DEFAULT GETDATE(),

        CONSTRAINT PK_Users PRIMARY KEY (UserID),
        CONSTRAINT UQ_Users_Email UNIQUE (Email),
        CONSTRAINT CK_Users_Role CHECK (Role IN ('Organiser', 'Participant'))
    );
END
GO

/* =========================
   2. ORGANISERS
   ========================= */
IF OBJECT_ID('dbo.Organisers', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Organisers
    (
        OrganiserID INT IDENTITY(1,1) NOT NULL,
        UserID INT NOT NULL,
        OrganisationName VARCHAR(100) NOT NULL,
        ContactPerson VARCHAR(100) NOT NULL,
        Phone VARCHAR(20) NOT NULL,
        Email VARCHAR(100) NOT NULL,

        CONSTRAINT PK_Organisers PRIMARY KEY (OrganiserID),
        CONSTRAINT FK_Organisers_Users FOREIGN KEY (UserID)
            REFERENCES dbo.Users(UserID),
        CONSTRAINT UQ_Organisers_UserID UNIQUE (UserID)
    );
END
GO

/* =========================
   3. EVENTS
   ========================= */
IF OBJECT_ID('dbo.Events', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Events
    (
        EventID INT IDENTITY(1,1) NOT NULL,
        Name VARCHAR(100) NOT NULL,
        Description VARCHAR(MAX) NULL,
        EventDate DATE NOT NULL,
        Location VARCHAR(100) NOT NULL,
        City VARCHAR(50) NOT NULL,
        DistanceKm DECIMAL(5,2) NOT NULL,
        CreatedBy INT NOT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

        CONSTRAINT PK_Events PRIMARY KEY (EventID),
        CONSTRAINT FK_Events_Users FOREIGN KEY (CreatedBy)
            REFERENCES dbo.Users(UserID),
        CONSTRAINT CK_Events_Distance CHECK (DistanceKm > 0)
    );
END
GO

/* =========================
   4. EVENT CATEGORIES
   ========================= */
IF OBJECT_ID('dbo.EventCategories', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EventCategories
    (
        CategoryID INT IDENTITY(1,1) NOT NULL,
        EventID INT NOT NULL,
        Name VARCHAR(50) NOT NULL,
        AgeGroup VARCHAR(20) NOT NULL,
        Gender VARCHAR(10) NOT NULL,
        MaxParticipants INT NOT NULL,
        EntryFee DECIMAL(10,2) NOT NULL,

        CONSTRAINT PK_EventCategories PRIMARY KEY (CategoryID),
        CONSTRAINT FK_EventCategories_Events FOREIGN KEY (EventID)
            REFERENCES dbo.Events(EventID),
        CONSTRAINT CK_EventCategories_MaxParticipants CHECK (MaxParticipants > 0),
        CONSTRAINT CK_EventCategories_EntryFee CHECK (EntryFee >= 0)
    );
END
GO

/* =========================
   5. ENROLMENTS
   ========================= */
IF OBJECT_ID('dbo.Enrolments', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Enrolments
    (
        EnrolmentID INT IDENTITY(1,1) NOT NULL,
        UserID INT NOT NULL,
        EventID INT NOT NULL,
        CategoryID INT NOT NULL,
        EnrolmentDate DATETIME NOT NULL DEFAULT GETDATE(),
        Status VARCHAR(20) NOT NULL,
        PaymentStatus VARCHAR(20) NOT NULL,

        CONSTRAINT PK_Enrolments PRIMARY KEY (EnrolmentID),
        CONSTRAINT FK_Enrolments_Users FOREIGN KEY (UserID)
            REFERENCES dbo.Users(UserID),
        CONSTRAINT FK_Enrolments_Events FOREIGN KEY (EventID)
            REFERENCES dbo.Events(EventID),
        CONSTRAINT FK_Enrolments_EventCategories FOREIGN KEY (CategoryID)
            REFERENCES dbo.EventCategories(CategoryID),
        CONSTRAINT CK_Enrolments_Status
            CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
        CONSTRAINT CK_Enrolments_PaymentStatus
            CHECK (PaymentStatus IN ('Pending', 'Paid', 'Refunded'))
    );
END
GO

/* =========================
   6. RESULTS
   ========================= */
IF OBJECT_ID('dbo.Results', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Results
    (
        ResultID INT IDENTITY(1,1) NOT NULL,
        EnrolmentID INT NOT NULL,
        FinishTime TIME NULL,
        NetTime TIME NULL,
        Position INT NOT NULL,
        Rank INT NOT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

        CONSTRAINT PK_Results PRIMARY KEY (ResultID),
        CONSTRAINT FK_Results_Enrolments FOREIGN KEY (EnrolmentID)
            REFERENCES dbo.Enrolments(EnrolmentID),
        CONSTRAINT CK_Results_Position CHECK (Position > 0),
        CONSTRAINT CK_Results_Rank CHECK (Rank > 0)
    );
END
GO

/* =========================
   7. EVENT COURSE DETAILS
   ========================= */
IF OBJECT_ID('dbo.EventCourseDetails', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EventCourseDetails
    (
        CourseID INT IDENTITY(1,1) NOT NULL,
        EventID INT NOT NULL,
        RouteName VARCHAR(100) NOT NULL,
        DistanceKm DECIMAL(5,2) NOT NULL,
        ElevationGain INT NOT NULL,
        WeatherInfo VARCHAR(100) NULL,

        CONSTRAINT PK_EventCourseDetails PRIMARY KEY (CourseID),
        CONSTRAINT FK_EventCourseDetails_Events FOREIGN KEY (EventID)
            REFERENCES dbo.Events(EventID),
        CONSTRAINT CK_EventCourseDetails_Distance CHECK (DistanceKm > 0),
        CONSTRAINT CK_EventCourseDetails_Elevation CHECK (ElevationGain >= 0)
    );
END
GO

/* =========================
   SAMPLE DATA
   ========================= */

IF NOT EXISTS (SELECT 1 FROM dbo.Users)
BEGIN
    INSERT INTO dbo.Users
    (
        FirstName, LastName, Email, PasswordHash, Phone, Role
    )
    VALUES
    ('Thabo', 'Mokoena', 'thabo@raceday.co.za',
     'HASH_ORGANISER_001', '0825551001', 'Organiser'),
    ('Lerato', 'Naidoo', 'lerato@raceday.co.za',
     'HASH_ORGANISER_002', '0835551002', 'Organiser'),
    ('Sipho', 'Dlamini', 'sipho@example.co.za',
     'HASH_PARTICIPANT_001', '0845551003', 'Participant'),
    ('Aisha', 'Pillay', 'aisha@example.co.za',
     'HASH_PARTICIPANT_002', '0855551004', 'Participant');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Organisers)
BEGIN
    INSERT INTO dbo.Organisers
    (
        UserID, OrganisationName, ContactPerson, Phone, Email
    )
    VALUES
    (1, 'Mzansi Road Events', 'Thabo Mokoena',
     '0825551001', 'thabo@raceday.co.za'),
    (2, 'Cape Active Sports', 'Lerato Naidoo',
     '0835551002', 'lerato@raceday.co.za');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Events)
BEGIN
    INSERT INTO dbo.Events
    (
        Name, Description, EventDate, Location, City, DistanceKm, CreatedBy
    )
    VALUES
    ('Johannesburg City Run',
     'A road running event through Johannesburg.',
     '2027-03-14', 'Johannesburg Stadium', 'Johannesburg', 10.00, 1),
    ('Soweto Community Walk',
     'A community walking event through Soweto.',
     '2027-04-18', 'Soweto', 'Johannesburg', 5.00, 1),
    ('Cape Peninsula Cycle Challenge',
     'A road cycling event around the Cape Peninsula.',
     '2027-05-09', 'Cape Town', 'Cape Town', 60.00, 2);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.EventCategories)
BEGIN
    INSERT INTO dbo.EventCategories
    (
        EventID, Name, AgeGroup, Gender, MaxParticipants, EntryFee
    )
    VALUES
    (1, '10km Open', '18+', 'All', 1000, 150.00),
    (1, '10km Junior', '16-17', 'All', 300, 100.00),
    (1, '5km Fun Run', 'All Ages', 'All', 800, 80.00),
    (2, '5km Community Walk', '18+', 'All', 500, 60.00),
    (2, '5km Family Walk', 'All Ages', 'All', 500, 50.00),
    (3, '60km Open', '18+', 'All', 1000, 300.00),
    (3, '60km Veteran', '40+', 'All', 400, 250.00),
    (3, '30km Development', '16+', 'All', 300, 150.00);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Enrolments)
BEGIN
    INSERT INTO dbo.Enrolments
    (
        UserID, EventID, CategoryID, Status, PaymentStatus
    )
    VALUES
    (3, 1, 1, 'Confirmed', 'Paid'),
    (4, 1, 3, 'Confirmed', 'Paid'),
    (3, 2, 4, 'Confirmed', 'Paid'),
    (4, 2, 5, 'Confirmed', 'Pending'),
    (3, 3, 6, 'Confirmed', 'Paid'),
    (4, 3, 8, 'Pending', 'Pending');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Results)
BEGIN
    INSERT INTO dbo.Results
    (
        EnrolmentID, FinishTime, NetTime, Position, Rank
    )
    VALUES
    (1, '00:52:34', '00:51:48', 12, 8),
    (2, '00:31:18', '00:30:45', 27, 14);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.EventCourseDetails)
BEGIN
    INSERT INTO dbo.EventCourseDetails
    (
        EventID, RouteName, DistanceKm, ElevationGain, WeatherInfo
    )
    VALUES
    (1, 'Johannesburg City Loop', 10.00, 120,
     'Sunny, 22 degrees Celsius'),
    (2, 'Soweto Heritage Route', 5.00, 60,
     'Partly cloudy, 20 degrees Celsius'),
    (3, 'Cape Peninsula Coastal Route', 60.00, 850,
     'Cool and windy, 18 degrees Celsius');
END
GO

/* =========================
   VERIFICATION
   ========================= */

SELECT 'Users' AS TableName, COUNT(*) AS RecordCount FROM dbo.Users
UNION ALL
SELECT 'Organisers', COUNT(*) FROM dbo.Organisers
UNION ALL
SELECT 'Events', COUNT(*) FROM dbo.Events
UNION ALL
SELECT 'EventCategories', COUNT(*) FROM dbo.EventCategories
UNION ALL
SELECT 'Enrolments', COUNT(*) FROM dbo.Enrolments
UNION ALL
SELECT 'Results', COUNT(*) FROM dbo.Results
UNION ALL
SELECT 'EventCourseDetails', COUNT(*) FROM dbo.EventCourseDetails;
GO
