SELECT 
  EngagementID, 
  ContentID, 
  CampaignID, 
  ProductID, 
  UPPER(
    REPLACE(
      ContentType, 'Socialmedia', 'Social Media'
    )
  ) as ContentType, 
  LEFT(
    ViewsClicksCombined, 
    CHARINDEX('-', ViewsClicksCombined)-1
  ) as "Views", 
  RIGHT(
    ViewsClicksCombined, 
    LEN(ViewsClicksCombined)- CHARINDEX('-', ViewsClicksCombined)
  ) as Clicks, 
  Likes, 
  FORMAT(EngagementDate, 'dd.MM.yyyy') AS EngagementDate 
FROM 
  [PortfolioProject_MarketingAnalytics].[dbo].[engagement_data] 
WHERE 
  ContentType != 'Newsletter';
