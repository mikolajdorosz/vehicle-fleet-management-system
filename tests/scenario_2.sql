-- Serwis pojazdu i automatyczna zmiana statusu

SELECT status FROM vehicles WHERE vid = 6;

-- Dodanie rekordu serwisowego
INSERT INTO service_records (date, cost, stid, vid)
VALUES ('2026-03-01', 500.00, 2, 6);

-- Sprawdzenie aktualnego statusu pojazdu po dodaniu rekordu serwisowego
SELECT * FROM status_history
WHERE vid = 6
ORDER BY change_date DESC;

-- Widok podsumowujący koszty serwisu dla pojazdu GD13013
SELECT * FROM service_cost_summary_view
WHERE reg_number = 'GD13013';