# Solution for the DB homework 

## Task 1 
Task description:
1) determine which Latin letter does NOT appear in the first place of the three-letter
country code in the Country table; 
2) same for letter not appearing in the second place; 
3) same for the third place.

[Solution](./task-1.sql)

#### Answer:
1) X
2) Q
3) J


## Task 2
Task description:
1) determine the ratio of population per square mile for each country;
2) using CTE (common table expression) and the result of the previous step, determine
the maximum, minimum and median of the ratio mentioned in the previous step;
3) challenge yourself: using UNION or otherwise write a query such that the result set
for this query has two columns "Metric" and "Value" and contains exactly three lines
with maximum, minimum and median values in the "Value" column, and the metic
names (i.e. literally 'Minimum', 'Maximum' and 'Median') in the "Metric" column.

[Solution](./task-2.sql)
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

