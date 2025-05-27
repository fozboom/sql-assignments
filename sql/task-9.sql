-- Исследуем структуру employee
SELECT * FROM employee LIMIT 5;

-- Смотрим на employeepayhistory
SELECT * FROM employeepayhistory LIMIT 5;

-- Основной анализ корреляции зарплаты с демографическими факторами
WITH current_pay AS (
    SELECT
        eph."EmployeeID",
        eph."Rate" as current_rate,
        ROW_NUMBER() OVER (PARTITION BY eph."EmployeeID" ORDER BY eph."RateChangeDate" DESC) as rn
    FROM employeepayhistory eph
),
     employee_demographics AS (
         SELECT
             e."EmployeeID",
             e."Gender",
             e."MaritalStatus",
             e."Title",
             EXTRACT(YEAR FROM AGE(CURRENT_DATE, e."BirthDate")) as age,
             cp.current_rate
         FROM employee e
                  INNER JOIN current_pay cp ON e."EmployeeID" = cp."EmployeeID" AND cp.rn = 1
         WHERE cp.current_rate IS NOT NULL
           AND e."CurrentFlag" = B'1'
     )
SELECT
    "Gender",
    "MaritalStatus",
    COUNT(*) as employee_count,
    ROUND(AVG(current_rate)::numeric, 2) as avg_rate,
    ROUND(AVG(age)::numeric, 1) as avg_age,
    ROUND(MIN(current_rate)::numeric, 2) as min_rate,
    ROUND(MAX(current_rate)::numeric, 2) as max_rate,
    ROUND(STDDEV(current_rate)::numeric, 2) as stddev_rate
FROM employee_demographics
GROUP BY "Gender", "MaritalStatus"
ORDER BY "Gender", "MaritalStatus";

-- Корреляция зарплаты с возрастом по полу
WITH employee_data AS (
    SELECT
        e."EmployeeID",
        e."Gender",
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, e."BirthDate")) as age,
        eph."Rate" as current_rate
    FROM employee e
             INNER JOIN (
        SELECT "EmployeeID", "Rate",
               ROW_NUMBER() OVER (PARTITION BY "EmployeeID" ORDER BY "RateChangeDate" DESC) as rn
        FROM employeepayhistory
    ) eph ON e."EmployeeID" = eph."EmployeeID" AND eph.rn = 1
    WHERE e."CurrentFlag" = B'1'
)
SELECT
    "Gender",
    COUNT(*) as employee_count,
    ROUND(CORR(age, current_rate)::numeric, 4) as age_salary_correlation,
    ROUND(AVG(age)::numeric, 1) as avg_age,
    ROUND(AVG(current_rate)::numeric, 2) as avg_salary
FROM employee_data
GROUP BY "Gender";

-- Анализ по возрастным группам
WITH employee_data AS (
    SELECT
        e."EmployeeID",
        e."Gender",
        e."MaritalStatus",
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, e."BirthDate")) as age,
        eph."Rate" as current_rate,
        CASE
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, e."BirthDate")) < 30 THEN '< 30'
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, e."BirthDate")) BETWEEN 30 AND 40 THEN '30-40'
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, e."BirthDate")) BETWEEN 41 AND 50 THEN '41-50'
            ELSE '> 50'
            END as age_group
    FROM employee e
             INNER JOIN (
        SELECT "EmployeeID", "Rate",
               ROW_NUMBER() OVER (PARTITION BY "EmployeeID" ORDER BY "RateChangeDate" DESC) as rn
        FROM employeepayhistory
    ) eph ON e."EmployeeID" = eph."EmployeeID" AND eph.rn = 1
    WHERE e."CurrentFlag" = B'1'
)
SELECT
    age_group,
    "Gender",
    COUNT(*) as employee_count,
    ROUND(AVG(current_rate)::numeric, 2) as avg_rate
FROM employee_data
GROUP BY age_group, "Gender"
ORDER BY age_group, "Gender";

