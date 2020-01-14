SELECT ROUND(AVG(saleprice), 0), yearbuilt, neighborhood
FROM houseprices
GROUP BY yearbuilt, neighborhood
ORDER BY neighborhood, yearbuilt DESC;

SELECT ROUND(AVG(saleprice), 0) AS avg_houseprice, COUNT(saleprice) AS count_houseprice, yearbuilt, neighborhood
FROM houseprices
GROUP BY yearbuilt, neighborhood
ORDER BY neighborhood, yearbuilt DESC;

SELECT AVG(lotfrontage)
FROM houseprices;

SELECT SUM(lotfrontage) AS sum_lotfrontage,
COUNT(*) AS count_all_records,
COUNT(lotfrontage) AS count_lotfront_records,
AVG(lotfrontage) AS avg_lotfrontage
FROM houseprices;


SELECT garagetype, AVG(garagearea/NULLIF(garagecars, 0)) AS avg_area_per_garage_bay
FROM houseprices
GROUP BY garagetype;

SELECT SUM(lotfrontage) AS sum_lotfront, lotshape, street
FROM houseprices
WHERE yearbuilt < 1980
GROUP BY lotshape, street
ORDER BY sum_lotfront DESC;

SELECT MIN(lotarea) AS min_lotarea, roofstyle
FROM houseprices
WHERE yearbuilt >= 1970
GROUP BY roofstyle
ORDER BY min_lotarea DESC;

SELECT MAX(saleprice) AS max_salesprice, yrsold, housestyle
FROM houseprices
GROUP BY yrsold, housestyle
ORDER BY housestyle, max_salesprice DESC;