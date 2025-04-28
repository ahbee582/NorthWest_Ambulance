
SELECT *
FROM [dbo].[NWAS_Sample_Data];

---- CONVERTED CATEGORICAL TO NUEMRICAL FOR OUTCOME

 SELECT
    Hospital_transported_to,
    Outcome,
     CASE
        WHEN Outcome = 'Treated On Scene' THEN 0
        WHEN Outcome = 'Transported' THEN 1
       -- ELSE 0  -- Optional: a default value for unexpected data
    END AS OutcomeCode
	into OutcomeCode 
FROM [dbo].[NWAS_Sample_Data] ;
GROUP BY outcomecode;	


---AVERAGE RESPONSE TIME
SELECT Response_Category, ROUND (AVG(Response_Time_Min),2) AS Avg_Response_Time
FROM [dbo].[NWAS_Sample_Data]
GROUP BY Response_Category;


----NUMBER OF INCIDENTS BY LOCATION
SELECT Incident_Location, COUNT(*) AS Total_Incidents
FROM [dbo].[NWAS_Sample_Data]
GROUP BY Incident_Location
ORDER BY Total_Incidents DESC;

----TREND OF INCIDENTS BY MONTHS
SELECT 
  FORMAT(CAST(Call_DateTime AS DATETIME), 'yyyy-MM') AS Month,
  COUNT(*) AS Total_Incidents
FROM [dbo].[NWAS_Sample_Data]
GROUP BY FORMAT(CAST(Call_DateTime AS DATETIME), 'yyyy-MM')
ORDER BY Month;
	
--- MOST FREQUENT OUTCOMES
SELECT Outcome, COUNT(*) AS Total
FROM [dbo].[NWAS_Sample_Data]
GROUP BY Outcome
ORDER BY Total DESC;

----CREW WITH MOST INCIDENT ATTENDED
SELECT Crew_ID, COUNT(*) AS Total_Incidents
FROM [dbo].[NWAS_Sample_Data]
GROUP BY Crew_ID
ORDER BY Total_Incidents DESC;

--- TOP 5 HOSPITALS FOR TRANSPORT
SELECT Hospital_Transported_To, COUNT(*) AS Total_Transports
FROM [dbo].[NWAS_Sample_Data]
WHERE Hospital_Transported_To IS NOT NULL
GROUP BY Hospital_Transported_To
ORDER BY Total_Transports DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

---Response Time Distribution by Category
SELECT Response_Category, 
       ROUND (MIN(Response_Time_Min),2) AS Min_Time,
       ROUND (MAX(Response_Time_Min),2) AS Max_Time,
       ROUND ( AVG(Response_Time_Min),2) AS Avg_Time
FROM [dbo].[NWAS_Sample_Data]
GROUP BY Response_Category;
