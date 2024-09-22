SELECT 
  c.CustomerID,
  c.CustomerName, 
  c.Email, 
  c.Gender, 
  c.Age, 
  g.Country, 
  g.City 
FROM 
  [PortfolioProject_MarketingAnalytics].[dbo].[customers] AS c 
  LEFT JOIN 
  [PortfolioProject_MarketingAnalytics].[dbo].[geography] AS g 
  ON 
  c.GeographyID = g.GeographyID;
