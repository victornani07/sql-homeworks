-- Write a query to display: 

-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name,
       last_name,
       salary,
       job_title
FROM employees
LEFT JOIN jobs USING ( job_id );
         
-- 2. the first and last name, department, city, and state province for each employee.
SELECT  first_name,
        last_name,
        department_name,
        city,
        state_province
FROM employees
LEFT JOIN departments USING ( department_id )
LEFT JOIN locations USING ( location_id );

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT  first_name,
        last_name,
        department_id,
        department_name
FROM employees
LEFT JOIN departments USING ( department_id )
WHERE department_id IN (40, 80);

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT  first_name,
        last_name,
        department_name,
        city,
        state_province
FROM employees
LEFT JOIN departments USING ( department_id )
LEFT JOIN locations USING ( location_id )
WHERE first_name LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT  first_name,
        last_name,
        salary
FROM employees
WHERE salary < (
        SELECT salary
        FROM employees
        WHERE employee_id = 182
);

-- 6. the first name of all employees including the first name of their manager.
SELECT  e1.first_name,
        e2.first_name AS manager_first_name
FROM employees e1
INNER JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT  e1.first_name,
        e2.first_name AS manager_first_name
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- 8. the details of employees who manage a department.
SELECT *
FROM employees e1
WHERE e1.employee_id IN (
        SELECT e2.manager_id
        FROM employees e2
    ) AND e1.department_id IS NOT NULL;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT  first_name,
        last_name,
        department_id
FROM employees 
WHERE department_id IN (
        SELECT department_id
        FROM employees 
        WHERE last_name = 'Taylor'
);

--10. the department name and number of employees in each of the department.
SELECT  d.department_name,
        COUNT(e.department_id) AS employees_count
FROM  employees   e,
      departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT  d.department_name,
        COUNT(e.department_id) AS employees_count,
        AVG(e.salary)          AS average_salary
FROM  employees   e,
      departments d
WHERE e.commission_pct IS NOT NULL
GROUP BY d.department_name;

--12. job title and average salary of employees.
SELECT  j.job_title,
        AVG(e.salary) AS average_salary
FROM jobs      j,
     employees e
WHERE e.job_id = j.job_id
GROUP BY j.job_title;

--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT department_id,
       country_name,
       city
FROM departments 
LEFT JOIN locations USING (location_id)
LEFT JOIN countries USING (country_id)
WHERE department_id IN (
    SELECT e.department_id
    FROM employees e1
    WHERE (
        SELECT COUNT(employee_id)
        FROM employees e2
        WHERE e2.department_id = e1.department_id
    ) > 2
);

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT  employee_id,
        job_title,
        end_date - start_date
FROM job_history
LEFT JOIN jobs USING ( job_id )
WHERE department_id = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT  CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name
FROM employees
WHERE salary > (
        SELECT salary
        FROM employees
        WHERE employee_id = 163
);
    
--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name
FROM employees
WHERE salary > (
        SELECT AVG(salary)
        FROM employees
);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
       salary
FROM employees
WHERE manager_id = (
        SELECT manager_id
        FROM employees
        WHERE first_name = 'Payam'
);

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT  CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
        department_id,
        job_title,
        department_name
FROM employees
LEFT JOIN departments USING ( department_id )
LEFT JOIN jobs USING ( job_id )
WHERE department_name = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM employees
WHERE employee_id IN ( 134, 159, 183 );

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM employees
WHERE salary > (
        SELECT MIN(salary)
        FROM employees
) AND salary < 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT
    *
FROM
    employees e1
WHERE
    e1.department_id NOT IN (
        SELECT
            e2.department_id
        FROM
            employees e2
        WHERE
            e1.employee_id BETWEEN 100 AND 200
    );

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM employees
WHERE salary = (
        SELECT salary
        FROM
            (SELECT DISTINCT s.salary,
                    ROWNUM rm
             FROM (
                SELECT salary
                FROM employees
                ORDER BY salary DESC
             ) s
            WHERE ROWNUM <= 2
        )
        WHERE rm >= 2
);

--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
SELECT CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
       hire_date
FROM employees e1
WHERE e1.department_id IN (
        SELECT e2.department_id
        FROM employees e2
        WHERE e2.first_name = 'Clara'
) AND e1.first_name != 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT  e1.employee_id,
        CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name
FROM employees e1
WHERE e1.department_id IN (
        SELECT e2.department_id
        FROM employees e2
        WHERE e2.first_name LIKE '%T%'
           OR e2.last_name LIKE '%T%'
);

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT  CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
        start_date,
        end_date,
        job_title
FROM employees
LEFT JOIN jobs USING ( job_id )
LEFT JOIN job_history USING ( employee_id )
WHERE commission_pct IS NULL;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT  employee_id,
        CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
        salary
FROM employees 
WHERE salary > (
        SELECT AVG(salary)
        FROM employees
)
   AND department_id IN (
        SELECT department_id
        FROM employees 
        WHERE first_name LIKE '%J%' 
           OR last_name LIKE '%J%'
);


--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT  e1.employee_id,
        CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
        job_title
FROM employees e1
LEFT JOIN jobs USING ( job_id )
WHERE e1.salary < (
        SELECT salary
        FROM (
            SELECT *
            FROM employees e2
            WHERE e2.job_id = 'MK_MAN'
            ORDER BY e2.salary ASC
        )
        WHERE ROWNUM = 1
);

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT  employee_id,
        CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
        job_title
FROM employees 
LEFT JOIN jobs USING ( job_id )
WHERE salary < (
        SELECT salary
        FROM (
            SELECT *
            FROM employees 
            WHERE job_id = 'MK_MAN'
            ORDER BY salary ASC
        )
        WHERE ROWNUM = 1
)
AND job_id != 'MK_MAN';

--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM employees e
WHERE e.employee_id NOT IN (
        SELECT j.employee_id
        FROM job_history j
);

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
       job_title
FROM employees 
LEFT JOIN jobs USING ( job_id )
WHERE salary >  ALL (
            SELECT AVG(salary) AS avg_salary
            FROM employees 
            GROUP BY department_id
);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT e1.employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
       CASE 
          WHEN job_id = 'ST_MAN' THEN 'SALESMAN'
          ELSE 'DEVELOPER'
       END AS job_title
FROM employees e1
LEFT JOIN jobs USING ( job_id )
WHERE job_id = 'ST_MAN'
   OR job_id = 'IT_PROG';

--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT e1.employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
       e1.salary,
       CASE
         WHEN e1.salary > (
            SELECT AVG(e2.salary)
            FROM employees e2
        ) THEN 'HIGH'
          ELSE 'LOW'
        END AS salarystatus
FROM employees e1;
    
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
    -- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
    -- the average salary of all employees.
SELECT e1.employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
       e1.salary,
       CASE
          WHEN e1.salary > (
             SELECT AVG(e2.salary)
             FROM employees e2
        ) THEN 'HIGH'
          ELSE 'LOW'
        END AS salarystatus,
        CASE
          WHEN e1.commission_pct IS NOT NULL THEN e1.commission_pct * e1.salary
          ELSE 0
    END AS salarydrawn,
    CASE WHEN e1.commission_pct IS NOT NULL THEN
        CASE
            WHEN e1.salary - ( e1.commission_pct * e1.salary ) > (
                SELECT AVG(e3.salary)
                FROM employees e3
            ) THEN 'ABOVE'
              ELSE 'BELOW'
              END
        ELSE 'ABSENT'
    END AS avgcompare
FROM employees e1;  

--34. all the employees who earn more than the average and who work in any of the IT departments.
SELECT *
FROM employees e1
WHERE e1.salary > (
        SELECT AVG(e2.salary)
        FROM employees e2
) AND e1.department_id IN (
        SELECT d.department_id
        FROM departments d
        WHERE d.department_name LIKE 'IT'
);

--35. who earns more than Mr. Ozer.
SELECT *
FROM employees e
WHERE salary > (
        SELECT salary
        FROM employees 
        WHERE last_name = 'Ozer'
);

--36. which employees have a manager who works for a department based in the US.
SELECT *
FROM employees e1
WHERE e1.manager_id IS NOT NULL
AND e1.manager_id IN (
        SELECT e2.employee_id
        FROM employees e2
        INNER JOIN departments d ON e2.department_id = d.department_id
        INNER JOIN locations   l ON l.location_id = d.location_id
                                 AND l.country_id = 'US'
);

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name
FROM employees e1
WHERE e1.salary > 0.5 * (
        SELECT avg_salary
        FROM (
            SELECT SUM(e3.salary) AS avg_salary,
                   e3.department_id
            FROM employees e3
            GROUP BY e3.department_id
        ) e2
        WHERE e1.department_id = e2.department_id
);

--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
SELECT e1.employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
       e1.salary
FROM employees e1
WHERE e1.salary = (
    SELECT e3.salary
    FROM (
        SELECT e2.salary,
               e2.hire_date,
               end_date
        FROM employees e2
        LEFT JOIN job_history USING ( employee_id )
        WHERE e2.hire_date >= TO_DATE('1 Jan 2002', 'DD MON YYYY')
        AND ( end_date IS NULL
           OR end_date <= TO_DATE('31 DEC 2003', 'DD MON YYYY') )
              ORDER BY e2.salary DESC
             ) e3
        WHERE  ROWNUM = 1
);
    
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
SELECT
    first_name,
    last_name,
    salary,
    department_id
FROM employees 
WHERE salary > (
    SELECT AVG(salary)
    FROM employees 
)
ORDER BY salary DESC;

--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees 
WHERE salary > (
    SELECT MAX(salary)
    FROM employees 
    WHERE department_id = 40
);

--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
SELECT department_id,
       department_name
FROM departments 
WHERE location_id = (
    SELECT location_id
    FROM departments 
    WHERE department_id = 30
);

--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
SELECT  first_name,
        last_name,
        salary,
        department_id
FROM employees 
WHERE department_id = (
    SELECT department_id
    FROM employees 
    WHERE employee_id = 201
);

--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
SELECT  first_name,
        last_name,
        salary,
        department_id
FROM employees 
WHERE salary = (
    SELECT salary
    FROM employees 
    WHERE department_id = 40
);

--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT  first_name,
        last_name,
        salary,
        department_id
FROM employees 
WHERE salary > (
    SELECT MIN(salary)
    FROM employees 
    WHERE department_id = 40
);

--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT  first_name,
        last_name,
        salary,
        department_id
FROM employees 
WHERE salary < (
    SELECT MIN(salary)
    FROM employees 
    WHERE department_id = 70
);

--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
SELECT  first_name,
        last_name,
        salary,
        department_id
FROM employees
WHERE salary < (
    SELECT AVG(salary)
    FROM employees 
)
AND   department_id = (
      SELECT department_id
      FROM employees 
      WHERE first_name = 'Laura'
);

--47. the full name (first and last name) of manager who is supervising 4 or more employees.
SELECT CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name
FROM employees e1
WHERE e1.employee_id IN (
    SELECT e2.manager_id
    FROM (
        SELECT COUNT(employee_id) AS cnt, manager_id
        FROM employees e3
        GROUP BY manager_id
    ) e2
    WHERE e2.cnt >= 4
);

--48. the details of the current job for those employees who worked as a Sales Representative in the past.
SELECT  *
FROM jobs j1
WHERE j1.job_id IN (
    SELECT e.job_id
    FROM (
        SELECT emp.job_id
        FROM employees emp
        WHERE emp.employee_id IN (
                SELECT jh.employee_id
                FROM job_history jh
                LEFT JOIN jobs        j2 USING ( job_id )
                WHERE j2.job_title = 'Sales Representative'
        )
    ) e
); 

--49. all the infromation about those employees who earn second lowest salary of all the employees.
SELECT *
FROM employees
WHERE salary = (
    SELECT salary
    FROM (
        SELECT s.salary,
               ROWNUM rm
        FROM (
            SELECT DISTINCT salary
            FROM employees
            ORDER BY salary ASC
        ) s
        WHERE ROWNUM <= 2
    )
WHERE rm >= 2
);

--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
SELECT  e1.department_id,
        CONCAT(CONCAT(first_name, ' '), last_name) AS employee_name,
        e1.salary
FROM employees e1
WHERE e1.salary * e1.commission_pct = (
SELECT MAX(e2.salary * e2.commission_pct)
FROM employees e2
);