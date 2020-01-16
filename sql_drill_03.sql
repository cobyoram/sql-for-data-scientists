--SQL Drill III

/* Write a query that returns the namefirst and namelast fields of the people table, 
along with the inducted field from the hof_inducted table. All rows from the people 
table should be returned, and NULL values for the fields from hof_inducted should be 
returned when there is no match found. */

SELECT namefirst, namelast, ind.inducted
FROM people
LEFT OUTER JOIN
hof_inducted AS ind
ON ind.playerid = people.playerid
ORDER BY ind.inducted;


/*In 2006, a special Baseball Hall of Fame induction was conducted for players from the 
negro baseball leagues of the 20th century. In that induction, 17 players were posthumously
inducted into the Baseball Hall of Fame. Write a query that returns the first and last 
names, birth and death dates, and birth countries for these players. Note that the year
of induction was 2006, and the value for votedby will be “Negro League.”*/


SELECT namefirst, namelast, birthyear, deathyear
FROM people
INNER JOIN (SELECT playerid FROM hof_inducted WHERE votedby = 'Negro League') AS hof
ON hof.playerid = people.playerid
WHERE deathyear < 2006;


/*Write a query that returns the yearid, playerid, teamid, and salary fields from the 
salaries table, along with the category field from the hof_inducted table. Keep only the
records that are in both salaries and hof_inducted. Hint: While a field named yearid is
found in both tables, don’t JOIN by it. You must, however, explicitly name which field
to include. */

SELECT s.yearid, s.playerid, teamid, salary, h.category
FROM hof_inducted AS h
INNER JOIN
salaries AS s
ON h.playerid = s.playerid;


/*Write a query that returns the playerid, yearid, teamid, lgid, and salary fields from
the salaries table and the inducted field from the hof_inducted table. Keep all records 
from both tables. */

SELECT s.*, h.inducted
FROM salaries AS s
FULL OUTER JOIN
hof_inducted AS h
ON s.playerid = h.playerid;


/*There are 2 tables, hof_inducted and hof_not_inducted, indicating successful and unsuccessful 
inductions into the Baseball Hall of Fame, respectively. */

-- Combine these 2 tables by all fields. Keep all records.
SELECT *
FROM hof_inducted
UNION ALL
SELECT *
FROM hof_not_inducted;

-- Get a distinct list of all player IDs for players who have been put up for HOF induction.
SELECT DISTINCT playerid
FROM hof_inducted
UNION
SELECT DISTINCT playerid
FROM hof_not_inducted;


/*Write a query that returns the last name, first name (see people table), and total recorded 
salaries for all players found in the salaries table. */

SELECT namelast, namefirst, s.ttl_salary
FROM people
LEFT OUTER JOIN
(SELECT playerid, SUM(salary) AS ttl_salary FROM salaries GROUP BY playerid) AS s
ON people.playerid = s.playerid;


/*Write a query that returns all records from the hof_inducted and hof_not_inducted
tables that include playerid, yearid, namefirst, and namelast. Hint: Each FROM statement 
will include a LEFT OUTER JOIN!*/

SELECT p.playerid, yearid, namefirst, namelast 
FROM hof_inducted AS h
LEFT OUTER JOIN people AS p
ON p.playerid = h.playerid

UNION ALL

SELECT p.playerid, yearid, namefirst, namelast
FROM hof_not_inducted AS h
LEFT OUTER JOIN people AS p
ON p.playerid = h.playerid;


/*Return a table including all records from both hof_inducted and hof_not_inducted, 
and include a new field, namefull, which is formatted as namelast , namefirst (in 
other words, the last name, followed by a comma, then a space, then the first name).
The query should also return the yearid and inducted fields. Include only records 
since 1980 from both tables. Sort the resulting table by yearid, then inducted so that
Y comes before N. Finally, sort by the namefull field, A to Z.*/

SELECT yearid, inducted, CONCAT(namelast, ', ', namefirst) AS namefull
FROM hof_inducted AS h
LEFT OUTER JOIN people AS p
ON p.playerid = h.playerid
WHERE yearid > 1980

UNION ALL

SELECT yearid, inducted, CONCAT(namelast, ', ', namefirst) AS namefull
FROM hof_not_inducted AS h
LEFT OUTER JOIN people AS p
ON p.playerid = h.playerid
WHERE yearid > 1980

ORDER BY yearid, inducted DESC, namefull;


/*Write a query that returns the highest annual salary for each teamid, ranked 
from high to low, along with the corresponding playerid. Bonus! Return namelast
and namefirst in the resulting table. (You can find these in the people table.)*/

WITH sal AS 
(
SELECT x.teamid, x.salary, y.playerid
FROM (SELECT teamid, MAX(salary) as salary FROM salaries GROUP BY teamid) AS x
INNER JOIN
salaries AS y
ON x.teamid = y.teamid
)
SELECT sal.teamid, sal.salary, sal.playerid, p.namelast, p.namefirst
FROM sal INNER JOIN people AS p
ON sal.playerid = p.playerid;


/*Select birthyear, deathyear, namefirst, and namelast of all the players born
since the birth year of Babe Ruth (playerid = ruthba01). Sort the results by
birth year from low to high.*/

SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear >= (SELECT birthyear FROM people WHERE playerid = 'ruthba01');


/*Using the people table, write a query that returns namefirst, namelast, and a field 
called usaborn where. The usaborn field should show the following: if the player's 
birthcountry is the USA, then the record is 'USA.' Otherwise, it's 'non-USA.' 
Order the results by 'non-USA' records first.*/

SELECT namefirst, namelast, 
CASE
	WHEN birthcountry = 'USA' THEN birthcountry
	ELSE 'non-USA'
END AS usaborn
FROM people
ORDER BY usaborn;


/*Calculate the average height for players throwing with their right hand versus their left
hand. Name these fields right_height and left_height, respectively. */

SELECT
(SELECT AVG(height) FROM people GROUP BY throws HAVING throws = 'R') AS right_height,
(SELECT AVG(height) FROM people GROUP BY throws HAVING throws = 'L') AS left_height;


/*Get the average of each team's maximum player salary since 2010. Hint: WHERE will go inside your CTE.*/
WITH team_max AS
(
SELECT teamid, MAX(salary) AS max_sal 
	FROM salaries 
	GROUP BY teamid
)
SELECT ROUND(AVG(max_sal), 2) AS avg_of_team_max_salaries
FROM team_max;