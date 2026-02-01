CREATE OR REPLACE VIEW available_vehicles_view AS
SELECT DISTINCT
    v.vid,
    v.reg_number,
    v.brand,
    v.model,
    v.prod_year,
    vt.name AS vehicle_type,
    e.did AS employee_did,
    v.did AS department_id
FROM vehicles v
JOIN vehicle_types vt ON v.vtid = vt.vtid
JOIN employees e ON v.did = e.did
WHERE v.status = 'available' 
    AND v.did = (SELECT did
                 FROM employees
                 WHERE split_part(email, '@', 1) = current_user);

CREATE OR REPLACE VIEW service_cost_summary_view AS
SELECT v.reg_number, v.brand, v.model, SUM(sr.cost) AS total_service_cost
FROM vehicles v
JOIN service_records sr ON v.vid = sr.vid
GROUP BY v.vid;