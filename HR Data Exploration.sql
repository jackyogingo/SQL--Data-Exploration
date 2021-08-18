/*query data from the database*/
SELECT 
    *
FROM
    employeedetails;

SELECT 
    *
FROM
    employeedata;

/*departments in the company*/
SELECT DISTINCT
    Department
FROM
    employeedetails;

/*Employees by gender*/
SELECT 
    Gender, COUNT(*)
FROM
    employeedetails
GROUP BY Gender;

/*Oldest and youngest employees*/
SELECT 
    MAX(AGE), MIN(Age)
FROM
    employeedetails;

/*How many of the oldest employees are male and how many are female?*/
SELECT 
    Gender, COUNT(*)
FROM
    employeedetails
WHERE
    Age = 60
GROUP BY Gender;

/*How many of the youngest employees are male and how many are female?*/
SELECT 
    Gender, COUNT(*)
FROM
    employeedetails
WHERE
    Age = 18
GROUP BY Gender;

/*range of employees based on age*/
SELECT 
    Gender, Age, MaritalStatus, COUNT(*)
FROM
    employeedetails
WHERE
    Age BETWEEN 18 AND 60
GROUP BY 1 , 2
ORDER BY 2;

/*return the record with the highest monthly income*/
SELECT 
    *
FROM
    employeedetails
ORDER BY MonthlyIncome DESC
LIMIT 1;

/* select highest monthly income*/
SELECT 
    MAX(MonthlyIncome)
FROM
    employeedetails;

/*return the record with the least monthly income*/
SELECT 
    *
FROM
    employeedetails
ORDER BY MonthlyIncome ASC
LIMIT 1;

/* select highest monthly rate*/
SELECT 
    MAX(MonthlyRate)
FROM
    employeedetails;

/* select  2nd highest monthly rate*/
SELECT 
    MAX(MonthlyRate)
FROM
    employeedetails
WHERE
    MonthlyRate NOT IN (SELECT 
            MAX(MonthlyRate)
        FROM
            employeedetails);

/* select 5th highest monthly income*/
SELECT 
    *
FROM
    employeedetails
ORDER BY MonthlyIncome DESC
LIMIT 4 , 1;

/* select 10th lowest monthly income*/
SELECT 
    *
FROM
    employeedetails
ORDER BY MonthlyIncome ASC
LIMIT 9 , 1;

/* return age,gender, department of longest serving employee*/
SELECT 
    emp.Age, emp.Gender, emp.Department, dat.YearsAtCompany
FROM
    employeedetails emp
        JOIN
    employeedata dat ON emp.EmployeeNumber = dat.EmployeeNumber
WHERE
    YearsAtCompany IN (SELECT 
            MAX(YearsAtCompany)
        FROM
            employeedata);

/* return age,gender, department of longest serving employee in each department*/
SELECT 
    emp.Age, emp.Gender, emp.Department, MAX(dat.YearsAtCompany)
FROM
    employeedetails emp
JOIN
    employeedata dat 
	ON emp.EmployeeNumber = dat.EmployeeNumber
GROUP BY Department
ORDER BY YearsAtCompany DESC;

/* How many employees have been with the company for a year or more?*/
SELECT 
    COUNT(YearsAtCompany)
FROM
    employeedata
WHERE
    YearsAtCompany >= 1;

/* Performance Score Headcount */
SELECT 
    PerformanceRating, COUNT(EmployeeNumber) AS Headcount
FROM
    employeedetails
GROUP BY PerformanceRating;

/* Environment Satisfaction Headcount */
SELECT 
    EnvironmentSatisfaction,
    COUNT(EmployeeNumber) AS ESHeadcount
FROM
    employeedetails
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;

/* Job Satisfaction Headcount */
SELECT 
    JobSatisfaction, COUNT(EmployeeNumber) AS JSHeadcount
FROM
    employeedetails
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

/* Relationship Satisfaction Headcount */
SELECT 
    RelationshipSatisfaction,
    COUNT(EmployeeNumber) AS RSHeadcount
FROM
    employeedetails
GROUP BY RelationshipSatisfaction
ORDER BY RelationshipSatisfaction;

/*average training time in the last year*/
SELECT 
    ROUND(AVG(TrainingTimesLastYear), 2)
FROM
    employeedata;

/*partitioned by*/
SELECT Age, Attrition, Gender,
COUNT(Attrition) OVER (PARTITION BY Attrition) AS TotalAttrition 
FROM employeedetails emp
JOIN employeedata dat
	ON emp.EmployeeNumber = dat.EmployeeNumber
ORDER BY Age;

 /* grouped by*/ 
  SELECT 
    Attrition, COUNT(Attrition) AS TotalAttrition
FROM
    employeedetails emp
JOIN
    employeedata dat 
    ON emp.EmployeeNumber = dat.EmployeeNumber
GROUP BY Attrition;

/*case when */
SELECT 
    Attrition,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    CASE
        WHEN YearsSinceLastPromotion = 0 THEN 'Not sure'
        WHEN YearsSinceLastPromotion BETWEEN 1 AND 5 THEN 'Least likely'
        WHEN YearsSinceLastPromotion BETWEEN 5 AND 10 THEN 'Likely'
        WHEN YearsSinceLastPromotion >= 10 THEN 'Highly likely'
    END AS Attritionprocess
FROM
    employeedetails emp
JOIN
    employeedata dat 
    ON emp.EmployeeNumber = dat.EmployeeNumber;
