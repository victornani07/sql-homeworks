CREATE TABLE pay (
    card_nr        NUMBER(6) PRIMARY KEY,
    salary         NUMBER(8, 2) NOT NULL,
    commission_pct NUMBER(2, 2),
    employee_id NUMBER(6) UNIQUE NOT NULL,
    CONSTRAINT pay_salary_minn CHECK ( salary > 0 )
);

CREATE SEQUENCE pay_seq NOCACHE;

ALTER TABLE pay MODIFY
    card_nr DEFAULT pay_seq.NEXTVAL;
    
ALTER TABLE pay
ADD CONSTRAINT fk_pay_employee FOREIGN KEY(employee_id) 
    REFERENCES employees(employee_id);

COMMENT ON TABLE pay IS
    'pay table. In a one-to-one relationship with employees table';

COMMENT ON COLUMN pay.card_nr IS
    'Primary key of pay table.';

COMMENT ON COLUMN pay.salary IS
    'Monthly salary of the employee. Transfered from the employees.';

COMMENT ON COLUMN pay.commission_pct IS
    'Commission percentage of the employee. Transfered from the employees.';