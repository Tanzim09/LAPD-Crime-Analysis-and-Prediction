# Crime Data Analysis and Power BI Dashboard

## Project Overview

This project analyzes crime data provided by the Los Angeles Police Department (LAPD) from 2020 to 2024. The dataset includes crime categories, case statuses, victim details, locations, and timestamps of occurrences.

The project involves:

- Data Cleaning and Feature Engineering
- SQL Queries for Insights
- Power BI Dashboard for Visualization

## Dataset Source

**Crime Data by LAPD (2020-2024)**  
You can access the dataset [here](https://catalog.data.gov/dataset/crime-data-from-2020-to-present).

## Data Cleaning & Feature Engineering

Performed various preprocessing tasks in the **Data Cleaning and EDA** folder, including:

- Handling missing values
- Creating generalized columns like holiday classification
- Ensuring data consistency

## SQL Queries

Executed SQL queries for further analysis, available in the **SQL Queries** folder. Queries include:

- Total crimes per category
- Crime trends over time
- Top crime locations
- Victim demographics analysis

Each query is documented with its query statement and output in sql_queries.

## Power BI Dashboard

Built an interactive Power BI dashboard featuring various insights. The dashboard includes:

### Page 1: Crime Overview

- **Bar Chart**: Crime Category vs. Total Crimes
- **Doughnut Chart**: Crime Severity (FBI classification: Level 1 or 2)
- **Doughnut Chart**: Case Status (Arrest, Investigation, etc.)
- **Column Chart**: Weekly Crime Reports
- **Column Chart**: Violent Crime Trends over Weekdays
- **Column Chart**: Financial Crime Trends over Weekdays

### Page 2: Victim Analysis & Trends

- **Bar Chart**: Sexual Crimes vs. Gender
- **Clustered Column Chart**: Crime Categories Over the Years
- **Bar Chart**: Victim Age vs. Crime Category
- **Area Chart**: Hourly Trends of Crime Reports
- **Area Chart**: Monthly Trends of Crime Reports
- **Doughnut Chart**: Victim Distribution

### Page 3: Crime Hotspots & Reporting Delays

- **Bar Chart**: Avg Delay in Reporting vs. Crime Category
- **Bar Chart**: Top 5 Crime Areas
- **Bar Chart**: Bottom 5 Crime Areas

## DAX Functions Include

- **Total Crimes**: `SUM(CrimeCount)`
- **Crime Percentage**: `DIVIDE(SUM(CrimeCount), SUMX(ALLSELECTED(CrimeCount)), 0)`
- **Moving Averages for Trends**
- **Conditional Formatting for Severity Levels**

---

**Author**: [Tanzim Rafat]  
**Date**: [Crime Report Analysis]
