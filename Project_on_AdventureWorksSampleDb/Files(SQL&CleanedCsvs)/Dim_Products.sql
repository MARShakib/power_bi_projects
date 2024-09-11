-- Cleansed Dim_Products Table --
SELECT 
  p.ProductKey, 
  p.ProductAlternateKey AS ProductItemCode, 
  p.EnglishProductName AS [Product Name], 
  psc.EnglishProductSubcategoryName AS [Sub Category], 
  pc.EnglishProductCategoryName AS [Product Category], 
  p.Color AS [Product Color], 
  p.Size AS [Product Size], 
  p.ProductLine AS [Product Line], 
  p.ModelName AS [Product Model Name], 
  p.EnglishDescription AS [Product Description], 
  ISNULL(p.Status, 'Outdated') AS [Product Status]
FROM 
  DimProduct AS p 
  LEFT JOIN DimProductSubcategory AS psc ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey 
  LEFT JOIN DimProductCategory AS pc ON psc.ProductCategoryKey = pc.ProductCategoryKey 
ORDER BY 
  p.ProductKey ASC;
