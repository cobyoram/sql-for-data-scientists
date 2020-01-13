SELECT *
FROM houseprices
ORDER BY lotarea;

SELECT *
FROM houseprices
ORDER BY lotarea DESC;

SELECT *
FROM houseprices
ORDER BY mszoning DESC;

SELECT yearbuilt, saleprice
FROM houseprices
ORDER BY yearbuilt DESC, saleprice DESC;

SELECT yearbuilt, saleprice
FROM houseprices
ORDER BY saleprice DESC, yearbuilt DESC;

SELECT yearbuilt, saleprice
FROM houseprices
WHERE yearbuilt BETWEEN 1990 AND 2000
ORDER BY yearbuilt DESC, saleprice DESC;

SELECT *
FROM houseprices
LIMIT 100;

SELECT *
FROM houseprices
ORDER BY id DESC
LIMIT 100;

SELECT saleprice
FROM houseprices
WHERE yearbuilt < 1950
ORDER BY saleprice DESC
LIMIT 10;

SELECT COUNT(yearbuilt) AS count_yearbuilt, COUNT(alley)
FROM houseprices;

SELECT COUNT(*)
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950;

SELECT DISTINCT neighborhood, yearbuilt
FROM houseprices
ORDER BY neighborhood, yearbuilt DESC;