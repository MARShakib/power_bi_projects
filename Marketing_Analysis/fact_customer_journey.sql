WITH DuplicateRecords AS (
  SELECT 
    *, 
    ROW_NUMBER() OVER(
      PARTITION BY CustomerID, 
      ProductID, 
      VisitDate, 
      Stage, 
      "Action" 
      ORDER BY 
        JourneyID
    ) AS row_num 
  FROM 
    [PortfolioProject_MarketingAnalytics].[dbo].[customer_journey]
) 
SELECT 
  * 
FROM 
  DuplicateRecords 
WHERE 
  row_num > 1
ORDER BY 
  JourneyID;


SELECT 
  JourneyID, 
  CustomerID, 
  ProductID, 
  VisitDate, 
  Stage, 
  "Action", 
  COALESCE(Duration, avg_duration) as Duration -- Replaces missing durations with the average duration for the corresponding data
FROM 
  (
    SELECT 
      JourneyID, 
      CustomerID, 
      ProductID, 
      VisitDate, 
      UPPER(Stage) AS Stage, 
      "Action", 
      Duration, 
      AVG(Duration) OVER(PARTITION BY VisitDate) as avg_duration, 
      ROW_NUMBER() OVER(
        PARTITION BY CustomerID, 
        ProductID, 
        VisitDAte, 
        Stage, 
        "Action" 
        ORDER BY 
          JourneyID
      ) AS row_num 
    FROM 
      [PortfolioProject_MarketingAnalytics].[dbo].[customer_journey]
  ) AS subquery 
WHERE 
  row_num = 1; -- Keeps the first occurance of each duplicate group identified in the subquery

