-- hackerrank Problem Statement link: https://www.hackerrank.com/challenges/occupations/problem


Select N,
CASE
     WHEN N NOT IN (select distinct P from BST where P is not null) THEN 'Leaf'
     WHEN P IS NULL THEN 'Root' ELSE 'Inner'
END AS NodeType
from BST order by N
