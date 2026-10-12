CREATE DATABASE ENERGYDB2;
USE ENERGYDB2;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

SELECT * FROM COUNTRY;

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM EMISSION_3;


-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);


SELECT * FROM PRODUCTION;

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

SELECT * FROM GDP_3;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM CONSUMPTION;

-- General & Comparative Analysis
#1 What is the total emission per country for the most recent year available?
SELECT 
    country,
    year,
    SUM(emission) AS total_emission
FROM emission_3
WHERE year = (SELECT MAX(year) FROM emission_3)
GROUP BY country, year
ORDER BY total_emission DESC;


#2 What are the top 5 countries by GDP in the most recent year?
SELECT Country, GDP
FROM (
    SELECT Country, SUM(Value) AS GDP
    FROM gdp_3
    WHERE year = (SELECT MAX(year) FROM gdp_3)
    GROUP BY Country
) AS t
ORDER BY GDP DESC
LIMIT 5;


#3Compare energy production and consumption by country and year.
WITH energy_data AS (
    SELECT
        p.country,
        p.year,
        SUM(p.production) AS total_production,
        SUM(c.consumption) AS total_consumption
    FROM production p
    JOIN consumption c
        ON p.country = c.country
        AND p.year = c.year
    GROUP BY p.country, p.year
)
SELECT
    country,
    year,
    total_production,
    total_consumption,
    total_production - total_consumption AS production_consumption_difference
FROM energy_data
ORDER BY country, year;

#4 Which energy types contribute most to emissions across all countries? 

SELECT
    energy_type,
    total_emission
FROM
(
    SELECT
        energy_type,
        SUM(emission) AS total_emission
    FROM emission_3
    GROUP BY energy_type
) AS energy_data
ORDER BY total_emission DESC;


--  Trend Analysis Over Time
#5 How have global emissions changed year over year?
SELECT 
    year,
    SUM(emission) AS total_emission,
    SUM(emission) - LAG(SUM(emission)) OVER (ORDER BY year) AS yoy_change
FROM emission_3
GROUP BY year
ORDER BY year;

#6 What is the trend in GDP for each country over the given years?
SELECT
    Country,
    year,
    GDP
FROM
(
    SELECT
        Country,
        year,
        Value AS GDP
    FROM gdp_3
) AS gdp_data
ORDER BY Country, year;

#7 How has population growth affected total emissions in each country?
SELECT
    p.country,
    p.total_emission
FROM
(
    SELECT
        e.country,
        SUM(e.emission) AS total_emission
    FROM emission_3 e
    GROUP BY e.country
) AS p;


#8 Has energy consumption increased or decreased over the years for major economies?
  -- first find the major countries #VIEW
SELECT
    Country,
    GDP
FROM
(
    SELECT
        Country,
        Value AS GDP
    FROM gdp_3
    WHERE year = (SELECT MAX(year) FROM gdp_3)
) AS gdp_data
ORDER BY GDP DESC
LIMIT 10;
SELECT country, year, SUM(consumption) AS consumption,
CASE
WHEN SUM(consumption) > LAG(SUM(consumption)) OVER(PARTITION BY country ORDER BY year)
THEN 'Increased'
WHEN SUM(consumption) < LAG(SUM(consumption)) OVER(PARTITION BY country ORDER BY year)
THEN 'Decreased'
ELSE 'No Change'
END AS trend
FROM consumption
WHERE country IN ('China','United States','India','Japan','Germany',
'Russia','Indonesia','Brazil','United Kingdom','France')
GROUP BY country, year
ORDER BY country, year;

#9 What is the average yearly change in emissions per capita for each country?
WITH epc AS (
    SELECT
        e.country,
        e.year,
        SUM(e.emission) / p.Value AS epc
    FROM emission_3 e
    JOIN population p
        ON e.country = p.countries
        AND e.year = p.year
    GROUP BY e.country, e.year, p.Value
)
SELECT
    a.country,
    AVG(a.epc - b.epc) AS avg_yearly_change
FROM epc a
JOIN epc b
    ON a.country = b.country
    AND a.year = b.year + 1
GROUP BY a.country;

 
-- Ratio & Per Capita Analysis
#10 What is the emission-to-GDP ratio for each country by year?
WITH emission_data AS (
    SELECT
        e.country,
        e.year,
        SUM(e.emission) AS total_emission
    FROM emission_3 e
    GROUP BY e.country, e.year
)
SELECT
    e.country,
    e.year,
    ROUND(e.total_emission / g.Value, 4) AS emission_gdp_ratio
FROM emission_data e
JOIN gdp_3 g
    ON e.country = g.Country
    AND e.year = g.year;

#11 What is the energy consumption per capita for each country over the last decade?
SELECT
    c.country,
    c.year,
    ROUND(SUM(c.consumption) * 1000000000 / p.Value, 2) AS consumption_per_capita
FROM consumption c
JOIN population p
    ON c.country = p.countries
    AND c.year = p.year
WHERE c.year >= (SELECT MAX(year) FROM consumption) - 9
GROUP BY c.country, c.year, p.Value
ORDER BY c.country, c.year;

#12 How does energy production per capita vary across countries?
SELECT
    pr.country,
    ROUND(SUM(pr.production) * 1000000000 / p.Value, 2) AS production_per_capita
FROM production pr
JOIN population p
    ON pr.country = p.countries
    AND pr.year = p.year
WHERE pr.year = (SELECT MAX(year) FROM production)
GROUP BY pr.country, p.Value
ORDER BY production_per_capita DESC;

#13 Which countries have the highest energy consumption relative to GDP?
SELECT
    c.country,
    ROUND(SUM(c.consumption) / g.Value, 4) AS consumption_gdp_ratio
FROM consumption c
JOIN gdp_3 g
    ON c.country = g.Country
    AND c.year = g.year
WHERE c.year = (SELECT MAX(year) FROM consumption)
GROUP BY c.country, g.Value
ORDER BY consumption_gdp_ratio DESC;

#14 What is the correlation between GDP growth and energy production growth?
SELECT
    g.Country,
    g.year,
    g.Value AS GDP,
    SUM(p.production) AS production
FROM gdp_3 g
JOIN production p
    ON g.Country = p.country
    AND g.year = p.year
GROUP BY g.Country, g.year, g.Value
ORDER BY g.Country, g.year;

  -- Global Comparisons
# 15 What are the top 10 countries by population and how do their emissions compare?
SELECT
    p.countries AS country,
    p.Value AS population,
    SUM(e.emission) AS total_emission
FROM population p
JOIN emission_3 e
    ON p.countries = e.country
    AND p.year = e.year
WHERE p.year = (
    SELECT MAX(year)
    FROM population
    WHERE year IN (SELECT year FROM emission_3)
)
GROUP BY p.countries, p.Value
ORDER BY p.Value DESC
LIMIT 10;


#16 Which countries have improved (reduced) their per capita emissions the most over the last decade?

SELECT
    e.country,
    ROUND(SUM(e.emission) / p.Value, 4) AS per_capita
FROM emission_3 e
JOIN population p
ON e.country = p.countries
AND e.year = p.year
WHERE e.year = (SELECT MAX(year) FROM emission_3)
GROUP BY e.country, p.Value
ORDER BY per_capita ASC;


#17 What is the global share (%) of emissions by country?

SELECT
    country,
    ROUND(total_emission / global_emission * 100, 2) AS global_share
FROM
(
    SELECT
        country,
        SUM(emission) AS total_emission
    FROM emission_3
    GROUP BY country
) AS country_data
CROSS JOIN
(
    SELECT
        SUM(emission) AS global_emission
    FROM emission_3
) AS global_data
ORDER BY global_share DESC;

#18 What is the global average GDP, emission, and population by year?
WITH yearly_data AS (
    SELECT
        g.year,
        g.Value AS gdp,
        e.emission,
        p.Value AS population
    FROM gdp_3 g
    JOIN emission_3 e
        ON g.Country = e.country
        AND g.year = e.year
    JOIN population p
        ON g.Country = p.countries
        AND g.year = p.year
)
SELECT
    year,
    AVG(gdp) AS avg_gdp,
    AVG(emission) AS avg_emission,
    AVG(population) AS avg_population
FROM yearly_data
GROUP BY year
ORDER BY year;