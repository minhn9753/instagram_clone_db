-- CALCULATE AVERAGE NUMBER OF PHOTOS PER USER

SELECT 
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;
