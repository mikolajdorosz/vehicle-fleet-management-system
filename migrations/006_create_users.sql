CREATE OR REPLACE FUNCTION create_accounts_for_employees() RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT email FROM employees LOOP
        BEGIN
            EXECUTE format('CREATE USER %I WITH PASSWORD %L', split_part(rec.email, '@', 1), split_part(rec.email, '@', 1));
        EXCEPTION
            WHEN duplicate_object THEN RAISE NOTICE 'Użytkownik % już istnieje, pomijam', split_part(rec.email, '@', 1);
        END;
        EXECUTE format('GRANT employee TO %I', split_part(rec.email, '@', 1));
    END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
SELECT create_accounts_for_employees();