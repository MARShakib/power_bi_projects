SELECT 
  ReviewID, 
  CustomerID, 
  ProductID, 
  ReviewDate, 
  Rating, 
  REPLACE(REPLACE(ReviewText, '  ', ' '), '  ', ' ') AS ReviewText -- Replace double & tripple spaces with single space
FROM 
  [PortfolioProject_MarketingAnalytics].[dbo].[customer_reviews];
