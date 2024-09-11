-- Cleansed Dim_Customer Table --
SELECT 
  c.CustomerKey AS CustomerKey, 
  c.FirstName AS [First Name], 
  c.LastName AS [Last Name], 
  c.FirstName + ' ' + c.LastName AS [Full Name], 
  CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, 
  c.DateFirstPurchase AS DateFirstPurchase, 
  g.city AS [Customer City] 
FROM 
  DimCustomer AS c 
  left join DimGeography AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  CustomerKey ASC;
