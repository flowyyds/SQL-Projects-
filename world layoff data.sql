-- select * 
-- from dbo.layoffs

-- select * 
-- into layoffs_staging
-- from layoffs
-- where 1=0;

-- select * from layoffs_staging

-- insert layoffs_staging
-- select * 
-- from layoffs

-- with dup_cte AS
-- (
--  select *,
-- ROW_NUMBER() over( partition by company, location, industry, total_laid_off,percentage_laid_off order by ) as rownum
-- from layoffs_staging
-- )
-- select * 
-- from dup_cte
-- where rownum >1

-- select * FROM layoffs_staging

-- select *,
-- ROW_NUMBER() over( partition by company, industry, total_laid_off,percentage_laid_off order by company ) as rownum
-- from layoffs_staging

-- with dup_cte AS
-- (
--     select *,
-- ROW_NUMBER() over( partition by company, 'location', industry, total_laid_off,percentage_laid_off,'date', stage, country, funds_raised_millions order by company ) as rownum
-- from layoffs_staging
-- )

-- DELETE 
-- from dup_cte
-- where rownum>1

-- select * from layoffs_staging

-- CREATE TABLE layoffs_staging2 (
-- company nvarchar(50),
-- location nvarchar(50),
-- industry nvarchar(50),
-- total_laid_off nvarchar(50),
-- percentage_laid_off nvarchar(50),
-- date nvarchar(50),
-- stage nvarchar(50),
-- country nvarchar(50),
-- funds_raised_millions nvarchar(50),
-- rownum INT
-- )

-- insert into layoffs_staging2
-- select *,
-- ROW_NUMBER() over( partition by company, 'location', industry, total_laid_off,percentage_laid_off, 'date', stage, country, funds_raised_millions order by company ) as rownum
-- from layoffs_staging

-- select * 
-- from layoffs_staging2
-- where rownum >1



/*******-----standardizing data--------------*******/

----------remove empty

-- select company, trim(company)
-- from layoffs_staging2

-- update layoffs_staging2 
-- set company = TRIM(company)

-- select distinct industry
-- from layoffs_staging2
-- order by 1


-----remove crypto redundency
-- select * 
-- from layoffs_staging2
-- where industry like 'Crypto%'

-- UPDATE layoffs_staging2
-- set industry = 'Crypto'
-- where industry like 'Crypto%'



-- select distinct layoffs_staging2.country, trim('.'from layoffs_staging2.country)
-- from layoffs_staging2
-- order by 1

-- update layoffs_staging2
-- set country = trim('.'from layoffs_staging2.country)
-- where country like 'United States%'

-- select *
-- from layoffs_staging2



-------------change time format. date format etc, tbc


-- select layoffs_staging2.date
-- STR_To_date(layoffs_staging2.date,'%M/%d/%Y')
-- from layoffs_staging2



/**----IS NULL cant use here, (total_laid_off = 'null') works-***/
-- select *
-- FROM layoffs_staging2
-- where total_laid_off = 'null' and percentage_laid_off = 'null'

/**blow my mind guys! 2 types of null here, null or empty*/
-- select *
-- FROM layoffs_staging2
-- where industry IS NULL or industry='null'


-- select * FROM layoffs_staging2
-- where company = 'Airbnb'


/*********-----合并 空白值 比如同一家公司某个部门 裁员 update set-------********/

-- select distinct * 
-- FROM layoffs_staging2 t3
-- join layoffs_staging2 t4
-- on t3.company = t4.company     
-- where (t3.industry is null or t3.industry='null')


-- UPDATE t3
-- set t3.industry=t4.industry
-- from layoffs_staging2 as t3
--    join layoffs_staging2 as t4
--    on t3.company = t4.company 
--        where (t3.industry is null or t3.industry='null')

/*****-----最后一步检查---------******/
-- select * 
-- from layoffs_staging2
-- where company like 'Bally%'

-- delete 
-- from layoffs_staging2
-- where  total_laid_off ='null'
-- and  percentage_laid_off='null'

-- delete 
-- from layoffs_staging2
-- where (total_laid_off is null or total_laid_off ='null')
-- and (percentage_laid_off is null or percentage_laid_off='null')

-- select * 
-- from layoffs_staging2


/**********Alter table,
Drop one useless column*******/
-- alter table layoffs_staging2
-- drop COLUMN rownum

select * 
 from layoffs_staging2
