select con.contest_id, con.hacker_id, con.name,
sum(ss.total_submissions), sum(ss.total_accepted_submissions),
sum(vs.total_views), sum(vs.total_unique_views)
from contests con
inner join Colleges col on con.contest_id = col.contest_id
inner join Challenges ch on col.college_id = ch.college_id
left join (
select challenge_id, sum(total_submissions) as total_submissions,
sum(total_accepted_submissions) as total_accepted_submissions
from Submission_Stats  group by challenge_id
) as ss
on ch.challenge_id = ss.challenge_id
left join (
select challenge_id, sum(total_views) as total_views,
sum(total_unique_views) as  total_unique_views
from View_Stats group by challenge_id
) as vs
on ch.challenge_id = vs.challenge_id
group by con.contest_id, con.hacker_id, con.name
having (sum(ss.total_submissions) + sum(ss.total_accepted_submissions) + sum(vs.total_views) + sum(vs.total_unique_views)) > 0
order by con.contest_id
