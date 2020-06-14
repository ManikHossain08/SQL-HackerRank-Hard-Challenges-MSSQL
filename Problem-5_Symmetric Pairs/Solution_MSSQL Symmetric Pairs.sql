declare @startId int;
declare @endId int;
declare @X1 int;
declare @X2 int;
declare @Y1 int;
declare @Y2 int;
declare @tempCount int;
DECLARE @tempTable TABLE
(
 x int, y int
);

select * into #temptbl from (
SELECT *, ROW_NUMBER() OVER (ORDER BY x) myrank FROM Functions
) a

set @startId = (select min(myrank) from #temptbl)
set @endId = (select max(myrank) from #temptbl)

WHILE @startId <= @endId
BEGIN
    set @X1 = (select x from #temptbl where myrank= @startId)
    set @Y1 = (select y from #temptbl where myrank= @startId)

    set @tempCount = @startId + 1
        WHILE @tempCount <= @endId
        BEGIN
            set @X2 = (select x from #temptbl where myrank= @tempCount)
            set @Y2 = (select y from #temptbl where myrank= @tempCount)
            if (@X1 = @Y2 and @X2 = @Y1)
            begin
                INSERT INTO @tempTable VALUES(@X1, @Y1)
            end
            set @tempCount = @tempCount + 1
        end
    SET @startId = @startId + 1;
END

SELECT * FROM @tempTable
order by  x asc
--select * from #temptbl
drop table #temptbl
--drop table @tempTable

--select * from Functions

--drop table #temptbl
