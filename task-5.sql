select d."Name" as department_name, count(edh."EmployeeID") as emp_count
from employeedepartmenthistory as edh
         inner join department d on edh."DepartmentID" = d."DepartmentID"
where edh."StartDate" <= '1999-05-01'
  and (edh."EndDate" IS NULL OR edh."EndDate" >= '1999-05-01')
group by d."Name"
order by emp_count