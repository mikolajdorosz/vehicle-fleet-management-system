INSERT INTO departments (address, city) VALUES
('15 Marszałkowska St.', 'Warsaw'),
('22 Długa St.', 'Krakow'),
('101 Grunwaldzka St.', 'Gdansk'),
('8 Półwiejska St.', 'Poznan'),
('12 Świdnicka St.', 'Wroclaw');

INSERT INTO vehicle_types (name, description) VALUES
('Station Wagon', 'Passenger car with a spacious trunk.'),
('Sedan', 'Passenger car with a classic body.'),
('Pick-up', 'Large car with an open cargo area at the back.'),
('SUV', 'Passenger car with raised chassis.');

INSERT INTO vehicles (reg_number, brand, model, prod_year, status, vtid, did) VALUES
('WA10001', 'Toyota', 'Avensis', 2019, 'available', 1, 1),
('WA11011', 'Mitsubishi', 'L200', 2021, 'available', 3, 1),
('KR20002', 'Ford', 'Focus', 2018, 'available', 2, 2),
('KR12012', 'Audi', 'Q5', 2020, 'available', 4, 2),
('GD30003', 'Volkswagen', 'Amarok', 2020, 'in_service', 3, 3),
('GD13013', 'Ford', 'Mondeo', 2019, 'available', 1, 3),
('PO40004', 'Honda', 'CR-V', 2021, 'available', 4, 4),
('PO14014', 'Mercedes', 'C-Class', 2021, 'available', 2, 4),
('WR50005', 'Opel', 'Insignia', 2019, 'rented', 1, 5),
('WR15015', 'Toyota', 'RAV4', 2020, 'in_service', 4, 5);

INSERT INTO service_types (name) VALUES
('Periodic Inspection'),
('Brake Pads Replacement'),
('Tire Replacement'),
('Brake System Check'),
('Battery Replacement'),
('AC Service'),
('Fuel Filter Replacement'),
('Engine Diagnostics');

INSERT INTO service_records (date, cost, stid, vid) VALUES
('2025-11-10', 350.00, 1, 1),
('2026-01-15', 420.00, 2, 1),
('2025-12-05', 300.00, 1, 2),
('2026-01-20', 150.00, 3, 2),
('2025-11-20', 800.00, 4, 3),
('2026-01-25', 250.00, 1, 3),
('2025-10-30', 600.00, 5, 4),
('2026-02-10', 350.00, 1, 4),
('2025-12-15', 450.00, 7, 5),
('2026-01-20', 200.00, 6, 5),
('2025-11-05', 180.00, 8, 6),
('2026-01-18', 120.00, 8, 6),
('2025-12-10', 360.00, 1, 7),
('2026-01-22', 400.00, 2, 7),
('2025-11-25', 420.00, 3, 8),
('2026-01-28', 380.00, 4, 8),
('2025-12-01', 500.00, 5, 9),
('2026-01-15', 250.00, 6, 9),
('2025-11-30', 900.00, 7, 10),
('2026-01-22', 250.00, 1, 10);

INSERT INTO status_history (status, change_date, vid) VALUES
('available', '2026-01-15', 1),
('rented', '2026-01-20', 1),
('available', '2026-01-18', 2),
('rented', '2026-01-22', 2),
('in_service', '2026-01-10', 3),
('rented', '2026-01-12', 3),
('available', '2026-01-12', 4),
('rented', '2026-01-25', 4),
('in_service', '2026-01-14', 5),
('rented', '2026-01-10', 5);
