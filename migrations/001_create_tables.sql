CREATE TABLE IF NOT EXISTS departments (
    did SERIAL PRIMARY KEY,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    UNIQUE (address, city)
);

CREATE TABLE IF NOT EXISTS employees (
    eid SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email LIKE '%@%'),
    did INT REFERENCES departments(did)
);

CREATE TABLE IF NOT EXISTS vehicle_types (
    vtid SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS vehicles (
    vid SERIAL PRIMARY KEY,
    reg_number VARCHAR(20) NOT NULL UNIQUE,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    prod_year INT NOT NULL CHECK (prod_year >= 1990 AND prod_year <= 2026),
    status VARCHAR(20) NOT NULL DEFAULT 'available' CHECK (status IN ('available','rented','in_service')),
    vtid INT REFERENCES vehicle_types(vtid) ON DELETE SET NULL ON UPDATE CASCADE,
    did INT REFERENCES departments(did)
);

CREATE TABLE IF NOT EXISTS reservations (
    rnid SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    vid INT REFERENCES vehicles(vid) ON DELETE CASCADE,
    eid INT REFERENCES employees(eid),
    CHECK (end_date >= start_date),
    CONSTRAINT unique_vehicle_reservation UNIQUE (vid, start_date, end_date)
);

CREATE TABLE IF NOT EXISTS rentals (
    rlid SERIAL PRIMARY KEY,
    rental_date DATE NOT NULL,
    return_date DATE NOT NULL,
    vid INT REFERENCES vehicles(vid) ON DELETE CASCADE,
    eid INT REFERENCES employees(eid),
    CHECK (return_date >= rental_date)
);

CREATE TABLE IF NOT EXISTS service_types (
    stid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS service_records (
    srid SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    cost DECIMAL(10,2) CHECK (cost >= 0),
    stid INT REFERENCES service_types(stid) ON DELETE RESTRICT,
    vid INT REFERENCES vehicles(vid) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS status_history (
    shid SERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL CHECK (status IN ('available','rented','in_service')),
    change_date DATE NOT NULL,
    vid INT REFERENCES vehicles(vid) ON DELETE CASCADE
);