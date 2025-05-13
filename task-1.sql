-- Task 1
with first_place_letters as (
    select distinct substr("Code",1,1) as letter
    from country
),
second_place_letters as (
     select distinct substr("Code",2,1) as letter
     from country
),
third_place_letters as (
 select distinct substr("Code",3,1) as letter
 from country
),
all_letters as (
    select chr(ascii('A') + i) as letter
    from generate_series(0, 25) as i
)

SELECT
    'First position' AS position,
    letter
FROM all_letters
WHERE letter NOT IN (SELECT letter FROM first_place_letters)

UNION ALL

SELECT
    'Second position' AS position,
    letter
FROM all_letters
WHERE letter NOT IN (SELECT letter FROM second_place_letters)

UNION ALL

SELECT
    'Third position' AS position,
    letter
FROM all_letters
WHERE letter NOT IN (SELECT letter FROM third_place_letters)

ORDER BY position, letter;



