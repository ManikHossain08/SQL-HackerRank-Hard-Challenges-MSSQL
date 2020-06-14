/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/


--select * from Hackers
--select * from Submissions

-------------------------------------- SQL for Expected Output---------------------

with cte as (
    SELECT submission_date, hacker_id, COUNT(*) AS cnt FROM Submissions
    GROUP BY submission_date, hacker_id
)

select t1.submission_date, t2.hacker_cnt, t1.hacker_id, t1.name from (
        SELECT submission_date, t.hacker_id, h.name FROM cte t
        join hackers h
        on t.hacker_id = h.hacker_id
        WHERE NOT EXISTS (
            SELECT * FROM cte t1
            WHERE t1.submission_date = t.submission_date AND t1.hacker_id <> t.hacker_id
            AND (t1.cnt > t.cnt OR (t1.cnt = t.cnt AND t1.hacker_id < t.hacker_id))
        )
) t1
inner join (
SELECT submission_date, COUNT(DISTINCT hacker_id) AS hacker_cnt
          FROM (
                SELECT s1.submission_date, s1.hacker_id, COUNT(DISTINCT s2.submission_date) AS day_cnt
                  FROM Submissions s1
                  JOIN Submissions s2
                    ON s2.hacker_id = s1.hacker_id
                   AND s2.submission_date <= s1.submission_date
                GROUP BY s1.submission_date, s1.hacker_id
               ) rt
         WHERE DATEDIFF(DAY,'2016-03-01', submission_date) + 1 = day_cnt
        GROUP BY submission_date
) t2

on t1.submission_date = t2.submission_date
order by t1.submission_date
