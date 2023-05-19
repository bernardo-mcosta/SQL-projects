# CO2 Emissions Analysis - SQL Portfolio Project

This repository contains SQL queries and analysis for a dataset on CO2 emissions by vehicles. The dataset captures details on how CO2 emissions can vary with different vehicle features such as fuel type, transmission, engine size, and more. The dataset has been compiled from the Canada Government official open data website, covering a period of 7 years and was obtained from [Kaggle](https://www.kaggle.com/datasets/debajyotipodder/co2-emission-by-vehicles).

## SQL Queries and Analysis

The repository contains SQL queries to perform various analyses on the CO2 emissions dataset. Here's an overview of the queries included:
1. **Average CO2 Emissions:** Calculate the average CO2 emissions (in grams per kilometer) for all vehicles in the dataset.
2. **Average CO2 Emissions by Fuel Type:** Determine how the average CO2 emissions differ between different fuel types (regular gasoline, premium gasoline, diesel, ethanol, natural gas).
3. **Impact of Number of Cylinders on CO2 Emissions:** Analyze how the number of cylinders in a vehicle affects its CO2 emissions.
4. **Average Fuel Consumption by Fuel Type:** Calculate the average fuel consumption (city, highway, and combined) for each fuel type.
5. **Comparison of CO2 Emissions for Automatic and Manual Transmissions:** Determine if there are significant differences in CO2 emissions between automatic and manual transmissions.

### Abbreviations Used in the Dataset

- Model: 
  - 4WD/4X4: Four-wheel drive
  - AWD: All-wheel drive
  - FFV: Flexible-fuel vehicle
  - SWB: Short wheelbase
  - LWB: Long wheelbase
  - EWB: Extended wheelbase

- Transmission:
  - A: Automatic
  - AM: Automated manual
  - AS: Automatic with select shift
  - AV: Continuously variable
  - M: Manual
  - 3 - 10: Number of gears

- Fuel type:
  - X: Regular gasoline
  - Z: Premium gasoline
  - D: Diesel
  - E: Ethanol (E85)
  - N: Natural gas

- Fuel Consumption:
  - City and highway fuel consumption ratings are shown in litres per 100 kilometres (L/100 km).
  - The combined rating (55% city, 45% highway) is shown in L/100 km and in miles per gallon (mpg).

- CO2 Emissions:
  - The tailpipe emissions of carbon dioxide (in grams per kilometer) for combined city and highway driving.

