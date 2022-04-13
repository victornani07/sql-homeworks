CREATE TABLE projects (
    project_id          NUMBER(6) PRIMARY KEY,
    project_description VARCHAR2(50),
    project_investments NUMBER(6, -3),
    project_revenue NUMBER(6, 2),
    CONSTRAINT proj_inv_check CHECK (project_investments > 0),
    CONSTRAINT proj_desc_length CHECK (LENGTH(project_description) > 10)
);
