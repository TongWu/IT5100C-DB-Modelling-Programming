CREATE TABLE Customers (
    email VARCHAR(255),
    fsname VARCHAR(50) NOT NULL,
    lsname VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    -- Optional records (Based on application description in assignment 1)
    phone2 VARCHAR(20),
    phone3 VARCHAR(20),
    dob DATE,
    address TEXT,

    PRIMARY KEY (email)
);

CREATE TABLE Locations (
    zip VARCHAR(10),
    lname VARCHAR(255) NOT NULL UNIQUE, --Candidate Key
    laddr TEXT NOT NULL,

    PRIMARY KEY (zip)
);

CREATE TABLE Employees (
    eid VARCHAR(20),
    ename VARCHAR(255) NOT NULL,
    ephone VARCHAR(20) NOT NULL,
    --Works Relationship
    zip VARCHAR(10),

    PRIMARY KEY (eid),
    FOREIGN KEY (zip) REFERENCES Locations(zip)
);

CREATE TABLE Drivers (
    eid VARCHAR(20),
    pdvl VARCHAR(50) NOT NULL UNIQUE, --Candidate Key

    PRIMARY KEY (eid),
    FOREIGN KEY (eid) REFERENCES Employees(eid) ON DELETE CASCADE  --Covering is false, overlap is true
);

CREATE TABLE CarModels (
    brand VARCHAR(50),
    model VARCHAR(50),
    cap INT NOT NULL,
    deposit DECIMAL(10,2) NOT NULL,
    daily DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (brand, model)
);

CREATE TABLE CarDetails (
    carNum VARCHAR(50),
    color VARCHAR(50) NOT NULL,
    pyear INT NOT NULL,
    condition VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    --Parks Relationship
    zip VARCHAR(10),

    PRIMARY KEY (carNum),
    FOREIGN KEY (brand, model) REFERENCES CarModels(brand, model) ON DELETE CASCADE,
    FOREIGN KEY (zip) REFERENCES Locations(zip)
);

CREATE TABLE Bookings (
    bid INT,
    bdate DATE NOT NULL,
    sdate DATE NOT NULL CHECK ( sdate >= bdate ),
    days INT NOT NULL,
    zip VARCHAR(10) NOT NULL,
    --Initiates Relationship
    status VARCHAR(20) DEFAULT 'active',
    --Handovers Relationship
    handover_eid VARCHAR(20),
    --Rents Relationship
    select_brand VARCHAR(50),
    select_model VARCHAR(50),
    rent_brand VARCHAR(50) NOT NULL CHECK ( rent_brand = select_brand ),
    rent_model VARCHAR(50) NOT NULL CHECK ( rent_model = select_model ),
    --Allocates Relationship
    carNum VARCHAR(50),

    PRIMARY KEY (bid),
    FOREIGN KEY (handover_eid) REFERENCES Employees(eid),
    FOREIGN KEY (rent_brand, rent_model) REFERENCES CarModels(brand, model),
    FOREIGN KEY (carNum) REFERENCES CarDetails(carNum)
);

CREATE TABLE Initiates (
    bid INT, --A customer may initiate 0 or mote bookings
    email VARCHAR(255) NOT NULL, -- A booking must be initiated by at least and most 1 customer
    ccnum INT,

    PRIMARY KEY (bid),
    FOREIGN KEY (email) REFERENCES Customers(email),
    FOREIGN KEY (bid) REFERENCES Bookings(bid)
);

CREATE TABLE Hires (
    bid INT,
    pdvl VARCHAR(50),
    ccnum INT,
    -- car_allocated BOOLEAN DEFAULT FALSE
    -- car_allocated cannot achieved a strong constraint

    PRIMARY KEY (bid),
    FOREIGN KEY (bid) REFERENCES Bookings(bid),
    FOREIGN KEY (pdvl) REFERENCES Drivers(pdvl)
);

CREATE TABLE RECEIVES (
    bid INT,
    eid VARCHAR(20),
    zip VARCHAR(10),
    ccnum INT,
    report TEXT,
    cost INT,

    FOREIGN KEY (bid) REFERENCES Bookings(bid),
    FOREIGN KEY (eid) REFERENCES Employees(eid),
    FOREIGN KEY (zip) REFERENCES Locations(zip),
    PRIMARY KEY (bid, eid, zip)
);
