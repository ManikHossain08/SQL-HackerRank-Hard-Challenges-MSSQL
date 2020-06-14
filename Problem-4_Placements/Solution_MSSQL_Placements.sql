/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

select s.name  from students s
inner join (
select p.id,p.salary,f.friend_id,f_sal = (select salary from packages where id = f.friend_id)
from packages p
inner join friends f
on p.id = f.id
) rt
on s.id = rt.id
where rt.salary < rt.f_sal
order by rt.f_sal asc
