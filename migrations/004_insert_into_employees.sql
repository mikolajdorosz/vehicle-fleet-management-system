INSERT INTO employees (first_name, last_name, email, did) VALUES
('Jan', 'Kowalski', 'jan.kowalski@company.com', 1),
('Magdalena', 'Kubiak', 'magdalena.kubiak@company.com', 1),
('Anna', 'Nowak', 'anna.nowak@company.com', 2),
('Robert', 'Nowicki', 'robert.nowicki@company.com', 2),
('Piotr', 'Wisniewski', 'piotr.wisniewski@company.com', 3),
('Joanna', 'Wojciechowska', 'joanna.wojciechowska@company.com', 3),
('Katarzyna', 'Lewandowska', 'katarzyna.lewandowska@company.com', 4),
('Krzysztof', 'Kaminski', 'krzysztof.kaminski@company.com', 4),
('Tomasz', 'Zielinski', 'tomasz.zielinski@company.com', 5),
('Agnieszka', 'Sadowska', 'agnieszka.sadowska@company.com', 5);

INSERT INTO rentals (rental_date, return_date, vid, eid) VALUES
('2026-01-20', '2026-01-25', 1, 1),
('2026-01-18', '2026-01-22', 2, 2),
('2026-01-10', '2026-01-15', 5, 5),
('2026-01-12', '2026-01-18', 3, 3),
('2026-01-25', '2026-01-30', 4, 4);

INSERT INTO reservations (start_date, end_date, vid, eid) VALUES
('2026-02-01', '2026-02-05', 1, 2),
('2026-02-06', '2026-02-10', 1, 3),
('2026-02-03', '2026-02-07', 2, 4),
('2026-02-02', '2026-02-05', 3, 6),
('2026-02-10', '2026-02-14', 4, 8),
('2026-02-01', '2026-02-05', 5, 9);