CREATE OR REPLACE FUNCTION validate_reservation() RETURNS TRIGGER AS $$
DECLARE
    employee_did INT;
    vehicle_did INT;
    vehicle_status TEXT;
    conflict_count INT;
BEGIN
    employee_did := (SELECT did FROM employees WHERE eid = NEW.eid);
    vehicle_did := (SELECT did FROM vehicles WHERE vid = NEW.vid);
    vehicle_status := (SELECT status FROM vehicles WHERE vid = NEW.vid);

    IF employee_did <> vehicle_did THEN RAISE EXCEPTION 'Employee cannot reserve vehicle from another department'; END IF;
    IF vehicle_status <> 'available' THEN RAISE EXCEPTION 'Vehicle is not available for reservation'; END IF;

    -- Kolizja z inną rezerwacją
    conflict_count := (SELECT COUNT(*) FROM reservations
                       WHERE vid = NEW.vid
                         AND daterange(start_date, end_date, '[]') &&
                             daterange(NEW.start_date, NEW.end_date, '[]'));

    IF conflict_count > 0 THEN RAISE EXCEPTION 'Vehicle already reserved in selected period'; END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER validate_reservation_trigger
BEFORE INSERT OR UPDATE ON reservations
FOR EACH ROW
EXECUTE FUNCTION validate_reservation();

CREATE OR REPLACE FUNCTION validate_rental() RETURNS TRIGGER AS $$
DECLARE
    employee_did INT;
    vehicle_did INT;
    vehicle_status TEXT;
    conflict_count INT;
BEGIN
    employee_did := (SELECT did FROM employees WHERE eid = NEW.eid);
    vehicle_did := (SELECT did FROM vehicles WHERE vid = NEW.vid);
    vehicle_status := (SELECT status FROM vehicles WHERE vid = NEW.vid);

    IF employee_did <> vehicle_did THEN RAISE EXCEPTION 'Employee cannot reserve vehicle from another department'; END IF;
    IF vehicle_status <> 'available' THEN RAISE EXCEPTION 'Vehicle is not available for rental'; END IF;

    -- Kolizja z inną rezerwacją
    conflict_count := (SELECT COUNT(*) FROM rentals
                       WHERE vid = NEW.vid
                         AND daterange(rental_date, return_date, '[]') &&
                             daterange(NEW.rental_date, NEW.return_date, '[]'));

    IF conflict_count > 0 THEN RAISE EXCEPTION 'Vehicle already rented in selected period'; END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER validate_rental_trigger
BEFORE INSERT OR UPDATE ON rentals
FOR EACH ROW
EXECUTE FUNCTION validate_rental();

CREATE OR REPLACE FUNCTION log_status_change() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status <> OLD.status THEN
        INSERT INTO status_history(status, change_date, vid)
        VALUES (NEW.status, CURRENT_DATE, NEW.vid);
        RAISE NOTICE 'Vehicle status has been changed. Updated history.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_status_change
AFTER UPDATE OF status ON vehicles
FOR EACH ROW
EXECUTE FUNCTION log_status_change();

CREATE OR REPLACE FUNCTION update_vehicle_status() RETURNS TRIGGER AS $$
BEGIN
    UPDATE vehicles
    SET status = 'in_service'
    WHERE vid = NEW.vid;
    RAISE NOTICE 'Added new record. Changed vehicle status to "in_service".';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_vehicle_status_trigger
AFTER INSERT ON service_records
FOR EACH ROW
EXECUTE FUNCTION update_vehicle_status();
