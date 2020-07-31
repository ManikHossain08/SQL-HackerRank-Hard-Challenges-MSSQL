-- hackerrank Problem Statement link: https://www.hackerrank.com/challenges/occupations/problem


SELECT [Doctor],[Professor],[Singer],[Actor] FROM
(
    select row_number() over(partition by occupation order by name) as rn,
    Name, Occupation from occupations
)
AS occupationsTable
PIVOT(
    max(name)
    FOR occupation IN ([Doctor],[Professor],[Singer],[Actor])
) AS occupationsPivotTable
order by rn
