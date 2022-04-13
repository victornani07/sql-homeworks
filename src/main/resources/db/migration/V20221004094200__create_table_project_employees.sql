CREATE TABLE project_employees (
    project_id NUMBER(6),
    employee_id NUMBER(6),
    hours NUMBER(4) NOT NULL,
    CONSTRAINT hours_worked CHECK (hours > 0),
    CONSTRAINT primary_keys PRIMARY KEY (project_id, employee_id)
);
    
COMMENT ON TABLE project_employees IS
    'project_employees table. An auxialiary table to implement the many-to-many relationship between projects and employees table';

COMMENT ON COLUMN project_employees.project_id IS
    'Primary key of project_employees table.';
	
COMMENT ON COLUMN project_employees.employee_id IS
    'Primary key of project_employees table.';

COMMENT ON COLUMN project_employees.hours IS
    'The amount of hours an employee has been working on a certain project.';