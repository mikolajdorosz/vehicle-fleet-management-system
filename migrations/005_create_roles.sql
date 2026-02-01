CREATE ROLE admin WITH LOGIN PASSWORD 'admin';

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

REVOKE ALL ON TABLE employees, departments, reservations, rentals FROM admin;
GRANT SELECT ON TABLE employees, departments, reservations, rentals TO admin;


CREATE ROLE employee WITH LOGIN PASSWORD 'employee';

GRANT SELECT ON reservations, rentals TO employee;
GRANT INSERT, UPDATE, DELETE ON reservations, rentals TO employee;
GRANT USAGE, SELECT ON SEQUENCE reservations_rnid_seq, rentals_rlid_seq TO employee;
GRANT SELECT ON available_vehicles_view TO employee;