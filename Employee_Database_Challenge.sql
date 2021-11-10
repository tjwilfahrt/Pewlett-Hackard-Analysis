--Deliverable 1: create a Retirement Table that holds all the titles of current employees
--who were born between 1/1/1952 and 12/31/1955.

--Join tables using INTO clause
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
	t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

	SELECT * FROM retirement_titles;

--Select columns for new database
SELECT emp_no, first_name, last_name, title
FROM retirement_titles;

--Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON(emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

	SELECT * FROM unique_titles;
	
--Retrieve number of employees by most recent job title who are about to retire.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

	SELECT * FROM retiring_titles;

--Deliverable 2: create a mentorship-eligibility table that holds current employees
--who were born between 1/1/1965 and 12/31/1965.

--Create new table for mentorship
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
    de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

	SELECT * FROM mentorship_eligibility;