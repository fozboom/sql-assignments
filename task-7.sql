-- Task 7: Subordination chains using recursive CTE
WITH RECURSIVE subordination_chains AS (
    -- Base case: top managers (without a manager)
    SELECT
        "EmployeeID",
        "EmployeeID"::text AS subordination_chain,
        0 AS chain_level
    FROM employee
    WHERE "ManagerID" IS NULL

    UNION ALL

    -- Recursive case: add subordinates
    SELECT
        e."EmployeeID",
        sc.subordination_chain || ' -> ' || e."EmployeeID"::text AS subordination_chain,
        sc.chain_level + 1 AS chain_level
    FROM employee e
             INNER JOIN subordination_chains sc ON e."ManagerID" = sc."EmployeeID"
    WHERE sc.chain_level < 10  -- Limit to prevent infinite recursion
)
SELECT
    subordination_chain,
    chain_level,
    LENGTH(subordination_chain) - LENGTH(REPLACE(subordination_chain, ' -> ', '')) + 1 AS chain_length
FROM subordination_chains
ORDER BY chain_level, subordination_chain;