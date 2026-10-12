# MySQL-Project
# 🌍 Worldwide Energy Consumption Analysis | SQL Project

## 📌 Project Overview

The **Worldwide Energy Consumption Analysis** project focuses on analyzing global energy consumption, energy production, GDP, population, and carbon emissions across countries and years using **SQL**.

The project uses relational data and SQL queries to identify energy consumption patterns, compare countries, analyze emission trends, and understand the relationship between energy usage, economic growth, population, and environmental sustainability.

The main goal is to transform raw energy-related data into meaningful insights that support better energy management and sustainable decision-making.

## 🎯 Business Problem

Worldwide energy demand is increasing due to population growth, industrialization, urbanization, and economic development. Countries depend on various energy sources, including coal, oil, natural gas, solar, wind, and hydropower.

However, dependence on fossil fuels contributes to carbon emissions and environmental degradation. Countries must balance energy demand, production, economic development, and environmental sustainability.

This project uses SQL-based analysis to understand global energy patterns, compare countries, identify emission trends, and explore opportunities to improve energy efficiency.

## 🎯 Project Objectives

- Analyze global energy consumption patterns across countries and years.
- Compare energy production and consumption to identify energy surpluses and deficits.
- Identify energy types that contribute most to total emissions.
- Analyze changes in global emissions over time.
- Examine relationships between GDP, population, energy consumption, and emissions.
- Calculate per-capita energy production and emissions.
- Compare countries based on energy usage and environmental impact.
- Generate data-driven recommendations for sustainable energy management.

## 🗄️ Database Schema

The project uses six interrelated tables:

| Table Name | Purpose |
|---|---|
| `country` | Stores country information and country identifiers. |
| `consumption` | Stores energy consumption data by country, energy type, and year. |
| `production` | Stores energy production data by country, energy type, and year. |
| `emission_3` | Stores emission data, energy types, years, and per-capita emissions. |
| `population` | Stores population data by country and year. |
| `gdp_3` | Stores GDP values by country and year. |

### 🔗 Table Relationships

The `country` table is related to the consumption, production, emissions, population, and GDP tables through country-related keys.

These relationships help combine information from multiple tables to perform country-level and year-wise analysis.

## 🛠️ Tools & Technologies

- **MySQL** — Database management and SQL analysis
- **SQL** — Data querying and analytical calculations
- **Relational Database Concepts** — Table relationships and keys

## 🔍 Key SQL Analysis & Business Questions

The project explores the following questions using SQL queries:

1. Which countries have the highest total emissions in the most recent available year?
2. What percentage of global emissions comes from each country?
3. How do energy production and consumption compare across countries and years?
4. Which countries have the highest energy production per capita?
5. Which energy types contribute the most to total emissions?
6. How have global emissions changed year over year?
7. How are population growth and total emissions related?
8. Which countries have reduced their per-capita emissions the most over the last decade?

## 💡 Key Analytical Insights

The SQL analysis helps to:

- Identify countries with relatively high total emissions.
- Calculate each country's contribution to global emissions.
- Compare energy production with consumption to identify potential surpluses and deficits.
- Compare energy production per person across countries.
- Identify energy types associated with the largest total emissions.
- Track changes in emissions over time.
- Compare energy and emission measures alongside population and GDP data.
- Identify countries with changes in per-capita emissions.

*Note: Specific rankings, numerical findings, and trends depend on the dataset and query results.*

## 🧠 SQL Concepts Used

The project demonstrates practical use of:

- `SELECT`, `WHERE`, and `ORDER BY`
- Aggregate functions such as `SUM()` and `MAX()`
- `GROUP BY` and `HAVING`
- Joins across multiple related tables
- Common Table Expressions (CTEs)
- Subqueries
- Filtering by the latest available year
- Calculating global emission percentages
- Year-wise comparisons and trend analysis
- Per-capita calculations
- Sorting and ranking country-level results

## 📊 Recommendations

Based on the types of analysis performed, the project recommends:

1. Promote energy efficiency to reduce excessive energy consumption.
2. Encourage cleaner energy sources to help reduce carbon emissions.
3. Monitor energy production and consumption regularly.
4. Consider population and GDP growth when planning future energy requirements.
5. Track emission trends to support sustainable energy policies.
6. Use regular SQL-based analysis to monitor country-level energy and environmental indicators.

## 🏁 Conclusion

The Worldwide Energy Consumption Analysis project demonstrates how SQL can be used to analyze large, related datasets and answer real-world business questions.

By combining energy consumption, production, emissions, GDP, and population data, the project provides a structured approach to understanding global energy patterns, comparing countries, and examining environmental impacts.

It also strengthens practical skills in SQL querying, joins, aggregations, CTEs, subqueries, and analytical problem-solving.

## 🚧 Challenges & Learning Outcomes

- Understanding relationships among six interrelated database tables.
- Joining datasets using country and year information.
- Writing SQL queries for complex analytical questions.
- Calculating per-capita values and global emission shares.
- Comparing energy production, consumption, and emissions.
- Exploring different approaches to solving SQL problems.

## 👥 Project Team

- **E. Krishna Babu** — B.Tech, Computer Science and Engineering, Vijaya Engineering College
- **V. Baladithya** — B.Tech, Computer Science and Engineering, Anurag University

## 📌 Project Category

**SQL | Data Analysis | Energy Analytics | Sustainability**

---

*This project was developed for academic and learning purposes to demonstrate SQL-based analysis of worldwide energy consumption and related environmental and economic indicators.*
