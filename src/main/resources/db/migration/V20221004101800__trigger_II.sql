CREATE TABLE employment_logs (
    employment_log_id              NUMBER(4) PRIMARY KEY,
    first_name                     VARCHAR2(30) NOT NULL,
    last_name                      VARCHAR2(30) NOT NULL,
    employment_action              VARCHAR2(5) NOT NULL,
    employment_status_updtd_tmstmp TIMESTAMP NOT NULL,
    CONSTRAINT empl_action CHECK ( employment_action IN ( 'HIRED', 'FIRED' ) )
);

CREATE SEQUENCE logs_seq NOCACHE;

ALTER TABLE employment_logs MODIFY
    employment_log_id DEFAULT logs_seq.NEXTVAL;

CREATE OR REPLACE PROCEDURE insert_logs (
    n_first_name                     IN VARCHAR2,
    n_last_name                      IN VARCHAR2,
    n_employment_action              IN VARCHAR2,
    n_tmstmp IN TIMESTAMP
) IS
BEGIN
    INSERT INTO employment_logs (
        first_name,
        last_name,
        employment_action,
        employment_status_updtd_tmstmp
    ) VALUES (
        n_first_name,
        n_last_name,
        n_employment_action,
        n_tmstmp
    );
END;

CREATE OR REPLACE TRIGGER insert_log 
    AFTER INSERT OR DELETE ON employees
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        insert_logs(:new.first_name, :new.last_name, 'HIRED', CURRENT_TIMESTAMP);
    END IF;
    IF DELETING THEN
        insert_logs(:old.first_name, :old.last_name, 'FIRED', CURRENT_TIMESTAMP);
    END IF;
END;