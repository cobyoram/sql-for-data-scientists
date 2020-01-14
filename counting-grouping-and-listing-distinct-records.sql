SELECT COUNT(DISTINCT yearbuilt), COUNT(DISTINCT neighborhood)
From houseprices
WHERE yearbuilt < 2000 AND neighborhood NOT LIKE 'G%';

SELECT neighborhood, COUNT(DISTINCT(yearbuilt))
FROM houseprices
GROUP BY neighborhood;

SELECT yearbuilt AS yearbuilt, COUNT(neighborhood) AS number_of_neighborhoods
FROM houseprices
GROUP BY yearbuilt;

SELECT COUNT(*), neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY neighborhood;

SELECT COUNT(*), neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY COUNT(*);

--INstead use an alias
SELECT COUNT(*) AS count_houses, neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY count_houses DESC;

--Count of records by year sorted in descending order
SELECT COUNT (*), yearbuilt
FROM houseprices
GROUP BY yearbuilt
ORDER BY yearbuilt DESC;

SELECT yearbuilt, housestyle, COUNT(*)
FROM houseprices
GROUP BY yearbuilt, housestyle
ORDER BY yearbuilt DESC, housestyle;

--Count multiple fields

SELECT COUNT(*) AS count_records, COUNT(alley) AS count_alleys, neighborhood
FROM houseprices
GROUP BY neighborhood;

SELECT COUNT(*) AS count_records, COUNT(alley) AS count_alleys, neighborhood
FROM houseprices
WHERE yearbuilt > 1990
GROUP BY neighborhood
ORDER BY count_alleys DESC;

SELECT COUNT(*) AS count_records, COUNT(alley) as count_alleys, neighborhood, street
FROM houseprices
GROUP BY neighborhood, street
ORDER BY neighborhood;


-- Count and Group By the same field
SELECT neighborhood, roofstyle, COUNT(roofstyle) AS count_roofstyle
FROM houseprices
GROUP BY neighborhood, roofstyle, count_roofstyle;