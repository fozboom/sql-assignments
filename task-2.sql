-- Subtask 1
select "Name",
       "Population" / "SurfaceArea" as population_per_square_mile
from country;

-- Subtask 2
with density_table as (select "Population" / "SurfaceArea" as population_per_square_mile
                       from country)
select max(population_per_square_mile),
       min(population_per_square_mile),
       percentile_cont(0.5) within group ( order by population_per_square_mile) as median
from density_table;

-- Subtask 3
with density_table as (select "Population" / "SurfaceArea" as population_per_square_mile
                       from country)
select 'Maximum' as Metric, max(population_per_square_mile) as Value
from density_table
UNION

select 'Minimum' as Metric, min(population_per_square_mile) as Value
from density_table
UNION

select 'Median' as Metric, percentile_cont(0.5) within group ( order by population_per_square_mile ) as Value
from density_table;



