-- Task 1
with first_place_letters as (select distinct substr("Code", 1, 1) as letter
                             from country),
     second_place_letters as (select distinct substr("Code", 2, 1) as letter
                              from country),
     third_place_letters as (select distinct substr("Code", 3, 1) as letter
                             from country),
     all_letters as (select chr(ascii('A') + i) as letter
                     from generate_series(0, 25) as i)

select 'First position' AS position,
       letter
from all_letters
where letter not in (select letter from first_place_letters)

union all

select 'Second position' AS position,
       letter
from all_letters
where letter not in (select letter from second_place_letters)

union all

select 'Third position' AS position,
       letter
from all_letters
where letter not in (select letter from third_place_letters)

order by position, letter;



