# Solution for the DB homework 

## Task 1 

Database: world

Task description:
1) determine which Latin letter does NOT appear in the first place of the three-letter
country code in the Country table; 
2) same for letter not appearing in the second place; 
3) same for the third place.

[Solution](../sql/task-1.sql)

#### Answer:
1) X
2) Q
3) J


## Task 2

Database: world


Task description:
1) determine the ratio of population per square mile for each country;
2) using CTE (common table expression) and the result of the previous step, determine
the maximum, minimum and median of the ratio mentioned in the previous step;
3) challenge yourself: using UNION or otherwise write a query such that the result set
for this query has two columns "Metric" and "Value" and contains exactly three lines
with maximum, minimum and median values in the "Value" column, and the metic
names (i.e. literally 'Minimum', 'Maximum' and 'Median') in the "Metric" column.

[Solution](../sql/task-2.sql)

#### Answer:
1) | Name | population\_per\_square\_mile |
   | :--- | :--- |
   | Aruba                                                | 533.6787564766839378 |
   | Afghanistan                                          | 34.8418163136990293 |
   | Angola                                               | 10.3296703296703297 |
   | Anguilla                                             | 83.3333333333333333 |
   | Albania                                              | 118.3108390148879922 |

2) | max | min | median |
   | :--- | :--- | :--- |
   | 26277.777777777778 | 0 | 67.45552799325566 |

3) | metric | value |
   | :--- | :--- |
   | Maximum | 26277.777777777777 |
   | Median | 67.45552799325566 |
   | Minimum | 0 |

### Task 3

Database: world


Task description:

1) For each country determine the percentage of its population living in its capital.
Which 10 countries have this percentage being the smallest?

[Solution](../sql/task-3.sql)

#### Answer:
| ctr\_name | city\_name | population\_pct |
| :--- | :--- | :--- |
| India                                                | New Delhi                           | 0.029723615958771267 |
| United States                                        | Washington                          | 0.205512704907726409 |
| Nigeria                                              | Abuja                               | 0.31397413592093699 |
| Pakistan                                             | Islamabad                           | 0.335180179316603081 |
| Tanzania                                             | Dodoma                              | 0.56389294984634663 |
| China                                                | Peking                              | 0.584865814311365903 |
| Guam                                                 | Agaña                               | 0.677976190476190476 |
| Côte d'Ivoire                                        | Yamoussoukro                        | 0.879210063573650751 |
| Bhutan                                               | Thimphu                             | 1.035781544256120527 |
| Canada                                               | Ottawa                              | 1.076434327543583652 |

### Task 4 

Database: world


Task description: 

1) Determine the average life epectancy for each language in a simple (and not really a 
correct) way: for each language just average out the life expectancy of all countries 
where this language is spoken. 
2) What would be a more correct way to compute average life expectancies per 
language? Challenge yourself by coming up with the solution that is as accurate as 
possible given the data available in the database. 

[Solution](../sql/task-4.sql)

#### Answer:

The better approach uses weighted averaging because:
- Population matters - A country with 100 million English speakers should count more than a country with 1 million speakers
- Language percentage matters - If only 10% of a country speaks English vs 90%, this affects the calculation

Better formula: Weight each country's life expectancy by how many people actually speak that language there.

### Task 5

Database: AdventureWorks

Task description:

1) How many people were employed in each department on May 01, 1999?
Use employeedepartmenthistory table StartDate and EndDate.

[Solution](../sql/task-5.sql)

#### Answer:

| Name | emp\_count |
| :--- | :--- |
| Executive | 1 |
| Facilities and Maintenance | 1 |
| Tool Design | 1 |
| Purchasing | 3 |
| Research and Development | 3 |
| Marketing | 5 |
| Production Control | 5 |
| Document Control | 5 |
| Engineering | 5 |
| Quality Assurance | 5 |
| Human Resources | 6 |
| Shipping and Receiving | 6 |
| Information Services | 10 |
| Finance | 11 |
| Production | 149 |


### Task 6
Database: AdventureWorks

Task description:

1) At what date have the USD<->CAD exchanged rate has changed the most
(compared to the previous day)? Use currencyrate table only. You can use the lag window function, CTE and
subquerying, or anything else if needed.


[Solution](../sql/task-6.sql)

#### Answer:
2004-03-08

| CurrencyRateDate | rate\_change |
| :--- | :--- |
| 2001-07-01 00:00:00.000000 | null |
| 2004-03-08 00:00:00.000000 | 0.02180000000000004 |

### Task 7

Database: AdventureWorks

Task description:

1) Use an LLM to craft a recursive query (or recursive CTE) over the employee table to
obtain a table storing subordination chains. A subordination chain is a string like "A
-> B -> C -> …" where A,B,C etc are IDs of employees, A is a manager of B, B is a
manager of C and so on. It is fine if for every chain its subchains are also in the
result set, but you can also think on how to deduplicate that. Note that we have not
covered recursive queries in out practice sessions, so feel free to look this up in the
DBMS documentation and/or ask an LLM about it.

[Solution](../sql/task-7.sql)

### Task 8

Database: AdventureWorks

Task description:

1) Investigate if and how vendor's CreditRating correlates with the total monetary
amount of transactions (see PurchaseOrders) with that vendor.
Deliverables:
2) One-two paragraph analysis with related SQL queries included

- Analysis of data reveals no significant correlation between vendor credit ratings and transaction volumes. The Pearson correlation coefficient is only 0.0269, indicating virtually no relationship between these metrics. This contradicts the hypothesis that the company prefers to conduct larger volumes of business with higher-rated vendors.
- Counterintuitively, vendors with the lowest credit rating (1) represent 80% of all vendors (84 out of 104) and generate the highest aggregate transaction volume ($54.5M out of $67.1M total). While vendors with better ratings (4-5) show higher average transaction volumes per vendor ($1.3M and $1.0M respectively), they are critically underrepresented (only 2 vendors each). Top-performing vendors exist across all rating groups with comparable transaction volumes ($2-5M), confirming that business decisions are driven by factors other than creditworthiness, such as product quality, delivery reliability, or specialization rather than financial stability.

[Queries](../sql/task-8.sql)


### Task 9

Database: AdventureWorks

Task description:

1) Investigate if and how employee's pay rate correlates with age, gender and marital
status.


- Analysis of employee data reveals significant gender-based pay disparities and weak age correlation with compensation. Female employees earn on average 8.3% more than their male counterparts ($19.23 vs $17.76), with the most pronounced differences among single employees. Age shows only minimal correlation with pay rates, suggesting that compensation is driven more by role-specific factors than tenure or experience.
- Gender emerges as the strongest predictor of compensation, with single women earning the highest average rates ($21.43) compared to all other demographic groups. Marital status creates interesting dynamics - single employees of both genders out-earn their married counterparts, but the gap is more pronounced among women (21% difference) than men (4% difference). Age demonstrates weak positive correlation with salary for both genders (0.20 for women, 0.13 for men), with employees over 50 earning substantially more than the 41-50 age group, indicating possible senior role premiums rather than pure age-based progression.

[Queries](../sql/task-9.sql)