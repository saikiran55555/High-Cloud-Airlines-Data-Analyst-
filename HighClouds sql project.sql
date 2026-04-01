create Database High_clouds;
use High_clouds;
SELECT * FROM `carrier operating region`;
select * from maindata_final;
SELECT COUNT(*) FROM maindata_final;


#Total_Passengers
SELECT 
CONCAT(ROUND(SUM(`# Transported Passengers`) / 1000000, 2), 'M') 
AS Total_Passengers FROM maindata_final;


#Total_Seats
SELECT 
CONCAT(ROUND(SUM(`# Available Seats`) / 1000000, 2), 'M') 
AS Total_Seats FROM maindata_final;


#Total_Departures
SELECT 
CONCAT(ROUND(SUM(`# Departures Scheduled`) / 1000000, 2), 'M') 
AS Total_Departures FROM maindata_final;


#Load_Factor
SELECT CONCAT(ROUND(
(SUM(`# Transported Passengers`) / SUM(`# Available Seats`)) * 100, 1), '%') 
AS Load_Factor FROM maindata_final; 


#Load_Factor_Yearly
SELECT Year,ROUND(
(SUM(`# Transported Passengers`) /SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM maindata_final GROUP BY Year ORDER BY Year;


#Load_Factor_Quarterly
SELECT Quarter,ROUND(
(SUM(`# Transported Passengers`) /SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM maindata_final GROUP BY Quarter ORDER BY Quarter;


#Load_Factor_Monthly
SELECT MonthFullName,ROUND(
(SUM(`# Transported Passengers`) /SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM maindata_final GROUP BY MonthFullName ORDER BY MonthFullName;


#Load Factor by Carrier
SELECT `Carrier Name`,
CONCAT(ROUND((SUM(`# Transported Passengers`) /SUM(`# Available Seats`)) * 100, 2),'%') AS Load_Factor_Percentage
FROM maindata_final GROUP BY `Carrier Name`
ORDER BY Load_Factor_Percentage DESC LIMIT 10;


#Top 10 Carriers by Passengers
SELECT `Carrier Name`,
CONCAT(ROUND(SUM(`# Transported Passengers`) / 1000000, 2), 'M') AS Total_Passengers
FROM maindata_final GROUP BY `Carrier Name`
ORDER BY SUM(`# Transported Passengers`) DESC LIMIT 10;


#Weekend vs Weekday Load Factor
SELECT CASE 
WHEN WeekdayName IN ('Saturday','Sunday') THEN 'Weekend'
ELSE 'Weekday'
END AS Day_Type,
ROUND(
(SUM(`# Transported Passengers`) /SUM(`# Available Seats`)) * 100, 2) AS Load_Factor
FROM maindata_final GROUP BY Day_Type;


#Top 10 routes(from city to city) based on number of flights
SELECT CONCAT(`Origin City`, ' → ', `Destination City`) AS Route,
SUM(`# Departures Scheduled`) AS Total_Flights
FROM maindata_final
GROUP BY `Origin City`, `Destination City`
ORDER BY Total_Flights DESC
LIMIT 10;


SELECT `From - To City`,
SUM(`# Departures Scheduled`) AS Total_Flights
FROM maindata_final
GROUP BY `From - To City`
ORDER BY Total_Flights DESC
LIMIT 10;


#Flights by Distance Group
SELECT `%Distance Group ID`,
CONCAT(ROUND(SUM(`# Departures Scheduled`) / 1000000, 2), 'M') 
AS Total_Flights FROM maindata_final
GROUP BY `%Distance Group ID`
ORDER BY `%Distance Group ID`;


ALTER TABLE `distance groups`
CHANGE COLUMN `ï»¿%Distance Group ID` distance_group_id INT;

DESCRIBE `distance groups`;
select * from `distance groups`;

