-- Rezerwacja pojazdu przez pracownika

SELECT * FROM available_vehicles_view;
SELECT * FROM reservations;

-- Poprawna rezerwacja
INSERT INTO reservations (start_date, end_date, vid, eid)
VALUES ('2026-02-15', '2026-02-18', 1, 1);

-- Błędna rezerwacja - konfilt oddziału
INSERT INTO reservations (start_date, end_date, vid, eid)
VALUES ('2026-02-15', '2026-02-18', 3, 1);

-- Błędna rezerwacja - konflikt terminów
INSERT INTO reservations (start_date, end_date, vid, eid)
VALUES ('2026-02-16', '2026-02-20', 1, 2);