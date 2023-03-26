SELECT * FROM `datafinalproject.DataJobs.SQL_PROJECT` LIMIT 1000

--Bring back everything
SELECT * FROM `datafinalproject.DataJobs.SQL_PROJECT`

--DROP Avg salary Expected Column
alter table `datafinalproject.DataJobs.SQL_PROJECT` 
drop column Avg_Salary_Expected__k_;

--Drop unnamed Column 
alter table `datafinalproject.DataJobs.SQL_PROJECT` 
drop column Column1; 

--Bring back all tables
SELECT * FROM  `datafinalproject.DataJobs.SQL_PROJECT` 

--How many data analyst jobs were posted ?
select Job_Title from `datafinalproject.DataJobs.SQL_PROJECT` 
where Job_Title like '%Data Analyst%'

--What are the average salary expected across all data job posts 
select Job_Title, Salary_Expected_
from `datafinalproject.DataJobs.SQL_PROJECT`
where Salary_Expected_ is not null;

--what is the highest salary expected and what sector is this from? 
select Sector, Salary_Expected_
from `datafinalproject.DataJobs.SQL_PROJECT`
where Salary_Expected_ is not null and Sector is not null
order by 2 desc;

--What Percentage of job posts is from IT what is the average salary expected?
select Sector,count(Sector)/(select count(*) 
from `datafinalproject.DataJobs.SQL_PROJECT`) as PercentageOfITJObs
from `datafinalproject.DataJobs.SQL_PROJECT`
where Sector = 'Information Technology'
Group by Sector;

--Find the average salary expected across IT?
select Sector, round (avg(Salary_Expected_), 2) as AVGSalaryExpected
from `datafinalproject.DataJobs.SQL_PROJECT`
where Sector = 'Information Technology'
group by Sector;

--What are the top 3 companys paying the highest?
SELECT Company_Name, Salary_Expected_
from `datafinalproject.DataJobs.SQL_PROJECT`
order by 2 desc;

--What is the job title for the highest paying job post?
select Job_Title, Salary_Expected_, rank() over (PARTITION BY Salary_Expected_ order by Salary_Expected_ desc) as RankbySalaryExpected
from `datafinalproject.DataJobs.SQL_PROJECT`
order by 3 desc;

--Is there a relationship between the highest paying jobs and the year they were founded? 
SELECT Job_Title, Year_Founded, Salary_Expected_
from `datafinalproject.DataJobs.SQL_PROJECT`
where Year_Founded is not null 
ORDER BY 3 DESC 

--Does the number of years the company have existed for affect the average salary expected? 
select Year_Founded, Salary_Expected_
from `datafinalproject.DataJobs.SQL_PROJECT`
where Year_Founded is not null and Salary_Expected_ is not null

--what companies are advertising data analyst roles above the average of all the salary expected?
select Company_Name, Salary_Expected_, Avg(Salary_Expected_) as AVGSalaryExpected
from `datafinalproject.DataJobs.SQL_PROJECT`
where Salary_Expected_ >= AVGSalaryExpected
order by AVGSalaryExpected desc

--Categorise job titles 
select Job_Title, Salary_Expected_,
case 
when Salary_Expected_ > Avg(Salary_Expected_) then 'AboveAverage'
when Salary_Expected_ < Avg(Salary_Expected_) then 'BelowAverage'
Else 'Average'
END AS SalaryRating
from `datafinalproject.DataJobs.SQL_PROJECT`
group by Job_Title, Salary_Expected_
order by 2 desc;

--join with job posts from linkedin 

SELECT * FROM  `datafinalproject.DataJobs.SQL_PROJECT`
