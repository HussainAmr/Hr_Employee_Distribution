-- 1. what is the gender breakdown of employees in the company?
SELECT gender, count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' GROUP BY gender;


-- 2. what is the race/ethnicity breakdown of employees in the company?
SELECT race, count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' 
GROUP BY race ORDER BY count(*) DESC;


-- 3. what is the age distribution of employees in the company?
SELECT min(age) AS youngest, max(age) AS oldest FROM hr WHERE age>=18 AND termdate = '0000-00-00';

SELECT CASE 
	WHEN age>=18 AND age<=24 THEN '18-24'
    WHEN age>=25 AND age<=34 THEN '25-34'
    WHEN age>=35 AND age<=44 THEN '35-44'
    WHEN age>=45 AND age<=54 THEN '45-54'
    WHEN age>=55 AND age<=60 THEN '55-60'
    ELSE '60+'
END AS age_group,
count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group ORDER BY age_group;

-- age distribution according to gender
SELECT CASE 
	WHEN age>=18 AND age<=24 THEN '18-24'
    WHEN age>=25 AND age<=34 THEN '25-34'
    WHEN age>=35 AND age<=44 THEN '35-44'
    WHEN age>=45 AND age<=54 THEN '45-54'
    WHEN age>=55 AND age<=60 THEN '55-60'
    ELSE '60+'
END AS age_group,gender,
count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group,gender ORDER BY age_group,gender; 



-- 4. how many employees work at headquarters vs remote locations?
SELECT location, count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' GROUP BY location;



-- 5. What is the average length of employment for employees who have been terminated?
SELECT round(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_employment FROM hr 
	WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >=18;



-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, gender, count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY department,gender ORDER BY department;



-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' 
GROUP BY jobtitle ORDER BY jobtitle DESC;



-- 8. Which department has the highest turnover rate?
SELECT department, total_count, terminated_count, (terminated_count/total_count) AS termination_rate
 FROM(SELECT department, count(*) AS total_count,
	sum(CASE WHEN termdate <>'0000-00-00' AND termdate<= curdate() THEN 1 ELSE 0 END) 
    AS terminated_count FROM hr WHERE age>=18 GROUP BY department) AS subquery 
ORDER BY termination_rate DESC;


-- 9, What is the distribution of employees across locations by city and state?
SELECT location_state, count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' 
GROUP BY location_state ORDER BY count DESC;

SELECT location_city, count(*) AS count FROM hr WHERE age>=18 AND termdate = '0000-00-00' 
GROUP BY location_city ORDER BY count DESC;



-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT year, hires, terminations, hires-terminations AS net_change, round((hires-terminations)/hires*100, 2) AS net_change_percent
FROM(SELECT YEAR(hire_date) AS year, 
			count(*) AS hires,
            sum(CASE WHEN termdate <>'0000-00-00' AND termdate<= curdate() THEN 1 ELSE 0 END) AS terminations
	FROM HR WHERE age>=18 GROUP BY year) AS subquery
ORDER BY year ASC;



-- 11. What is the tenure distribution for each department?
SELECT department, round(AVG(datediff(termdate, hire_date)/365),0) AS avg_tenure FROM hr 
WHERE termdate <> '0000-00-00' AND age>=18 GROUP BY department ORDER BY avg_tenure DESC;


-- 12. department distribution location wise?
select department, location, count(*) as count from hr where age>=18 and termdate = '0000-00-00' group by department,location order by department;


-- 13. Which gender has the highest turnover rate?
select gender, total_count , terminated_count, (terminated_count/total_count) as termination_rate
from (select gender, count(*) as total_count, 
		sum(case when termdate <> '0000-00-00' and termdate <=curdate() then 1 else 0 end) as terminated_count
        from hr where  age>=18 group by gender) as subquery
order by termination_rate desc;

-- race location wise?
select location_state, race,count(*) as count from hr where age>=18 and termdate = '0000-00-00' group by location_state,race order by count desc;