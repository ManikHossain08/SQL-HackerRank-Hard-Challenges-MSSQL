/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

declare @ProStartdate date;
declare @CurrStartdate date;
declare @Proenddate date;
declare @nextdate date;
declare @taskIdStart int;
declare @taskIdEnd int;
declare @daysInDiff int;
DECLARE @tempTable TABLE
(
    StartDate date, EndDate date, task_id int, days int
);

-- Create virtual rank in temptbl using the startdate order because the order was not
-- accurate according the the task_id
select * into #temptbl from (
SELECT
    *,
    RANK() OVER (
        ORDER BY Start_date
    ) myrank
FROM
    Projects
    ) a
--select * from #temptbl


set @taskIdStart = (select min(myrank) from #temptbl)
set @taskIdEnd = (select max(myrank) from #temptbl)
set @ProStartdate = (select Start_date from #temptbl where myrank = @taskIdStart)

WHILE @taskIdStart <= @taskIdEnd
BEGIN
    --print @taskIdStart+1
    set @nextdate = (select Start_date from #temptbl where myrank = @taskIdStart + 1)
    --print @nextdate

    set @CurrStartdate = (select Start_date from #temptbl where myrank = @taskIdStart)
    if (DATEDIFF(day, @CurrStartdate, @nextdate) != 1  and @nextdate is not null)
    begin
        set @Proenddate = (select end_date from #temptbl where myrank = @taskIdStart)
        set @daysInDiff = DATEDIFF(day,  @ProStartdate, @Proenddate)
        INSERT INTO @tempTable
            VALUES(@ProStartdate, @Proenddate, @taskIdStart, @daysInDiff)
        set @ProStartdate = @nextdate
    end
    else if (@nextdate is null)
    BEGIN
        set @Proenddate = (select end_date from #temptbl where myrank = @taskIdStart)
        set @daysInDiff = DATEDIFF(day,  @ProStartdate, @Proenddate)
        INSERT INTO @tempTable
            VALUES(@ProStartdate, @Proenddate, @taskIdStart, @daysInDiff)
    END
    --PRINT @counter;
    SET @taskIdStart = @taskIdStart + 1;
END
--StartDate, EndDate
SELECT StartDate, EndDate FROM @tempTable
order by  days,  StartDate asc
