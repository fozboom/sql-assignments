select ctr."Name"                          as ctr_name,
       c."Name"                            as city_name,
       (c."Population"::numeric / ctr."Population") * 100 as population_pct
from country ctr
         inner join city c on ctr."Capital" = c."ID"
order by population_pct
limit 10;
