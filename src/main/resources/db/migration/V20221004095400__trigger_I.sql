ALTER TABLE locations ADD department_amount NUMBER(4) NOT NULL;

CREATE OR REPLACE TRIGGER update_locations 
	AFTER INSERT OR DELETE ON departments
    FOR EACH ROW
BEGIN
    UPDATE locations l
    SET l.department_amount = (
            SELECT d2.dpt_amount
            FROM (
                SELECT d1.location_id,
                       COUNT(d1.department_id) AS dpt_amount
                FROM departments d1
                GROUP BY d1.location_id
            ) d2
            WHERE l.location_id = d2.location_id
        );
END;

COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in a certain location.';