-- TASK A) What is the total number of units sold per product SKU?

select productid,
sum(inventoryquantity) As Total_Units_Sold
From sales
Group by productid
Order by Total_Units_Sold Desc;

-- TASK B - Which product category had the highest sales volume last month?

Select * From sales

SELECT 
    p.productcategory, 
    SUM(s.inventoryquantity) AS sales_volume
FROM 
    sales s
JOIN 
    product p ON p.productid = s.productid
WHERE 
    s.sales_year = '2021' 
    AND s.sales_month = '11'
GROUP BY 
    p.productcategory
ORDER BY 
    sales_volume DESC
LIMIT 1;

--TASK C- How does the inflation rate correlate with sales volume for a specific month?

SELECT 
    s.sales_month, 
    s.sales_year, 
    AVG(f.inflationrate) AS avg_inflation, 
    SUM(s.inventoryquantity) AS sales_volume
FROM 
    sales s
JOIN 
    factors f 
ON 
    s.sales_year = f.factors_year 
    AND s.sales_month = f.factors_month
GROUP BY 
    s.sales_month, 
    s.sales_year;

-- Task D: What is the correlation between the inflation rate and sales quantity for all 
-- products combined on a monthly basis over the last year?

SELECT 
    CORR(monthly_data.total_sales, monthly_data.avg_inflation) AS sales_inflation_correlation
FROM (
    SELECT 
        s.sales_month,
        s.sales_year,
        SUM(s.inventoryquantity) AS total_sales,
        AVG(f.inflationrate) AS avg_inflation
    FROM 
        sales s
    JOIN 
        factors f 
    ON 
        s.sales_year = f.factors_year 
        AND s.sales_month = f.factors_month
    WHERE 
        s.sales_year = '2021'
    GROUP BY 
        s.sales_month, s.sales_year
) AS monthly_data;

-- Task E: Did promotions significantly impact the sales quantity of products?

SELECT 
    p.promotions, 
    SUM(s.inventoryquantity) AS total_sales,
    AVG(s.inventoryquantity) AS avg_sales_per_product
FROM 
    sales s
JOIN 
    product p 
ON 
    s.productid = p.productid
GROUP BY 
    p.promotions
ORDER BY 
    total_sales DESC;

SELECT 
    p.productcategory, 
    p.promotions, 
    SUM(s.inventoryquantity) AS total_sales,
    AVG(s.inventoryquantity) AS avg_sales_per_product
FROM 
    sales s
JOIN 
    product p 
ON 
    s.productid = p.productid
GROUP BY 
    p.productcategory, 
    p.promotions
ORDER BY 
    p.productcategory, 
    total_sales DESC;

--Task F: What is the average sales quantity per product category?

SELECT 
    p.productcategory, 
    AVG(s.inventoryquantity) AS avg_sales_quantity
FROM 
    sales s
JOIN 
    product p 
ON 
    s.productid = p.productid
GROUP BY 
    p.productcategory
ORDER BY 
    avg_sales_quantity DESC;


-- Task G: How does GDP affect the total sales volume?

SELECT 
    f.gdp, 
    SUM(s.inventoryquantity) AS total_sales_volume
FROM 
    sales s
JOIN 
    factors f 
ON 
    s.sales_year = f.factors_year 
    AND s.sales_month = f.factors_month
GROUP BY 
    f.gdp
ORDER BY 
    f.gdp DESC;



SELECT 
    CORR(monthly_data.gdp, monthly_data.total_sales) AS gdp_sales_correlation
FROM (
    SELECT 
        f.gdp, 
        SUM(s.inventoryquantity) AS total_sales
    FROM 
        sales s
    JOIN 
        factors f 
    ON 
        s.sales_year = f.factors_year 
        AND s.sales_month = f.factors_month
    GROUP BY 
        f.gdp
) AS monthly_data;


-- Task H: What are the top 10 best-selling product SKUs?

SELECT 
    s.productid, 
    SUM(s.inventoryquantity) AS total_sales
FROM 
    sales s
GROUP BY 
    s.productid
ORDER BY 
    total_sales DESC
LIMIT 10;
 

--Task I: How do seasonal factors influence sales quantities for different product categories?


SELECT 
    p.productcategory, 
    f.seasonalfactor, 
    SUM(s.inventoryquantity) AS total_sales
FROM 
    sales s
JOIN 
    product p 
ON 
    s.productid = p.productid
JOIN 
    factors f 
ON 
    s.sales_year = f.factors_year 
    AND s.sales_month = f.factors_month
GROUP BY 
    p.productcategory, f.seasonalfactor
ORDER BY 
    total_sales DESC;

-- Task J: What is the average sales quantity per product category,
--and how many products within each category were part of a promotion?

SELECT 
    p.productcategory, 
    AVG(s.inventoryquantity) AS avg_sales_quantity,
    COUNT(CASE WHEN p.promotions = 'Yes' THEN p.productid END) AS promoted_products
FROM 
    sales s
JOIN 
    product p 
ON 
    s.productid = p.productid
GROUP BY 
    p.productcategory
ORDER BY 
    avg_sales_quantity DESC;







