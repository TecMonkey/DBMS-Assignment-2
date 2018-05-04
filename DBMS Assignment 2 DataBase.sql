CREATE TABLE Person 
(
    PersonId INTEGER PRIMARY KEY,
    FirstName VARCHAR2(255) NOT NULL, 
    LastName VARCHAR2(255) NOT NULL
)

CREATE TABLE Manager
(
    PersonId INTEGER,
    CONSTRAINT Manager_FK1 FOREIGN KEY (PersonId) REFERENCES Person,
    CONSTRAINT Manager_PK PRIMARY KEY (PersonId)
)

CREATE TABLE Employee
(
    PersonId INTEGER,
    CONSTRAINT Employee_FK1 FOREIGN KEY (PersonId) REFERENCES Person,
    CONSTRAINT Employee_PK PRIMARY KEY (PersonID)
)

CREATE TABLE Payslip
(
    PersonId INTEGER, PayslipId INTEGER, StartDateTime TIMESTAMP NOT NULL,
    EndDateTime TIMESTAMP NOT NULL, Wage FLOAT NOT NULL, Tax FLOAT NOT NULL, Super CHAR(5), NetPay FLOAT NOT NULL,
    CONSTRAINT Payslip_FK1 FOREIGN KEY (PersonId) REFERENCES Person,
    CONSTRAINT Payslip_PK PRIMARY KEY (PersonId, PayslipId),
    CONSTRAINT Payslip_Date CHECK (StartDateTime < EndDateTime)
)

CREATE TABLE EnlistedWith
(
    OrgId INTEGER, PersonId INTEGER,
    CONSTRAINT EW_FK1 FOREIGN KEY (PersonId) REFERENCES Person,
    CONSTRAINT EW_FK2 FOREIGN KEY (OrgId) REFERENCES Organisation,
    CONSTRAINT EW_PK  PRIMARY KEY (PersonId, OrgId)
)

CREATE TABLE LeaveRequest
(
    PersonId INTEGER, LeaveReqId INTEGER, EndDateTime TIMESTAMP NOT NULL, StartDateTime TIMESTAMP NOT NULL,
    CONSTRAINT LR_FK1 FOREIGN KEY (PersonId) REFERENCES Person,
    CONSTRAINT LR_PK PRIMARY KEY (PersonId, LeaveReqId),
    CONSTRAINT LR_DATE CHECK (EndDateTime > StartDateTime)
)

CREATE TABLE ApprovedBy
(
    ManagerId INTEGER, EmployeeId INTEGER, LeaveReqId INTEGER, ApprovalDate TIMESTAMP NOT NULL,
    CONSTRAINT AB_FK1 FOREIGN KEY (ManagerId) REFERENCES Person (PersonId),
    CONSTRAINT AB_FK3 FOREIGN KEY (EmployeeId, LeaveReqId) REFERENCES LeaveRequest (PersonId, LeaveReqId),
    CONSTRAINT AB_PK  PRIMARY KEY (ManagerId, EmployeeId, LeaveReqId)
)

CREATE TABLE SupervisedBy
(
    EmployeeId INTEGER, ManagerId INTEGER,
    CONSTRAINT SB_FK1 FOREIGN KEY (EmployeeId) REFERENCES Employee (PersonId),
    CONSTRAINT SB_FK2 FOREIGN KEY (ManagerId) REFERENCES Manager (PersonId),
    CONSTRAINT SB_PK  PRIMARY KEY (ManagerId, EmployeeId)
)

