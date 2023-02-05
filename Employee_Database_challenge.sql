-- DELIVERY 1
-- Create a retirement list

SELECT e.emp_no, e.first_name, e.last_name, 
ti.title, ti.from_date, ti.to_date
into retiring_info
from employees as e
inner join titles as ti 
on (e.emp_no= ti.emp_no)
where (birth_date between '1952-01-01'and '1955-12-31')
order by emp_no

select*from retiring_info;

-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (r.emp_no) r.emp_no, r.first_name, r.last_name, r.title
INTO unique_titles
FROM retiring_info as r
WHERE (r.to_date='9999-01-01')
ORDER BY r.emp_no, r.to_date DESC;

SELECT*FROM unique_titles;

--Number of employees by their most recent job title who are about to retire.
SELECT COUNT(u.title),u.title
INTO  retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY (count(u.title)) DESC;

select*from retiring_titles;

-- DELIVERY 2
-- Create Mentorship table
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
d.from_date, d.to_date, ti.title
INTO ment_tab
FROM employees as e
INNER JOIN dept_emp as d on e.emp_no=d.emp_no
INNER JOIN titles as ti on e.emp_no=ti.emp_no
WHERE (d.to_date='9999-01-01') AND (e.birth_date between '1965-01-01'and '1965-12-31')
ORDER BY(e.emp_no);

SELECT*FROM ment_tab;

--Additional Analysis: Number of mentor per title

SELECT COUNT (m.title),m.title
INTO additional_1
FROM ment_tab as m
inner join retiring_titles as i on i.title=m.title
group by m.title
order by count((m.title)) desc;

select* from additional_1

--Additional Analysis: Retired people by gender
SELECT count (e.gender), e.gender
into gender_retired
from employees as e
inner join unique_titles as u on e.emp_no= u.emp_no
group by(e.gender);

select *from gender_retired;

drop table gender_retired;

-- Retired Gender by title 
SELECT count (e.gender), e.gender,u.title
into gender_retired
from employees as e
inner join unique_titles as u on e.emp_no= u.emp_no
group by(e.gender, u.title)

select *from gender_retired;