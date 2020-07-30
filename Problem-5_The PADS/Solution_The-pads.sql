-- hackerrank Problem Statement link: https://www.hackerrank.com/challenges/the-pads/problem


select CONCAT(name,'(' ,SUBSTRING(occupation,1,1),')') from occupations
order by name asc

select CONCAT('There are a total of ', numberOfOcu, ' ', LOWER(occupation), 's.') from (
select occupation, count(*)  numberOfOcu from occupations 
group by occupation
) a 
order by numberOfOcu asc, occupation asc