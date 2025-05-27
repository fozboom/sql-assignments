-- Part 1: Simple averaging
select cl."Language", avg(c."LifeExpectancy") as avg_life_expectancy
from countrylanguage as cl
         inner join public.country c on c."Code" = cl."CountryCode"
where c."LifeExpectancy" is not null
group by cl."Language";


-- Part 2: Weighted averaging (more accurate)
SELECT
    cl."Language",
    SUM(c."LifeExpectancy" * c."Population" * cl."Percentage" / 100.0) /
    SUM(c."Population" * cl."Percentage" / 100.0) AS avg_life_expectancy_weighted
FROM countrylanguage cl
         JOIN country c ON cl."CountryCode" = c."Code"
WHERE c."LifeExpectancy" IS NOT NULL
  AND c."Population" > 0
  AND cl."Percentage" > 0
GROUP BY cl."Language"
ORDER BY avg_life_expectancy_weighted DESC;