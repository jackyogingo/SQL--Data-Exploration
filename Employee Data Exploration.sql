SELECT 
    *
FROM
    employee;

SELECT 
    *
FROM
    department;

/*To select employee record with highest salary*/
SELECT 
    *
FROM
    employee
ORDER BY Salary DESC
LIMIT 1;

/*TO select highest salary in employee table*/
SELECT 
    MAX(Salary)
FROM
    employee;

/*To select 2nd highest salary in employee table*/ 
SELECT 
    MAX(Salary)
FROM
    employee
WHERE
    Salary NOT IN (SELECT 
            MAX(Salary)
        FROM
            employee);

/*To select record with 6th highest salary in employee table*/ 
SELECT 
    *
FROM
    employee
ORDER BY Salary DESC
LIMIT 5 , 1;

/*To select range of employee based on id*/ 
SELECT 
    *
FROM
    employee
WHERE
    Employee_id BETWEEN 2003 AND 2006;

/*To return employee name, highest salary and department*/
SELECT 
    employee.first_name,
    employee.last_name,
    employee.Salary,
    department.department_name
FROM
    employee
        INNER JOIN
    department ON employee.department_id = department.department_id
WHERE
    Salary IN (SELECT 
            MAX(Salary)
        FROM
            employee);

/*To return employee name, highest salary and department name for each department*/
SELECT 
    employee.first_name,
    employee.last_name,
    employee.Salary,
    department.department_name
FROM
    employee
        INNER JOIN
    department ON employee.department_id = department.department_id
WHERE
    Salary IN (SELECT 
            MAX(Salary)
        FROM
            employee
        GROUP BY department_id);
 