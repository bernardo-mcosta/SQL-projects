-- What is the average CO2 emissions (in grams per kilometer) for all vehicles in the dataset?
SELECT AVG(`CO2 Emissions(g/km)`)
FROM CO2_Emissions_Canada;

-- How does the average CO2 emissions differ between different fuel types (regular gasoline, premium gasoline, diesel, ethanol, natural gas)?
SELECT `Fuel Type`, AVG(`CO2 Emissions(g/km)`) AS average_emission
FROM CO2_Emissions_Canada
GROUP BY `Fuel Type`
ORDER BY average_emission DESC;

-- Verify if large vehicles are skewing the average emissions for Ethanol fuel type
SELECT Model, `Vehicle Class`, `CO2 Emissions(g/km)`
FROM CO2_Emissions_Canada
WHERE `Fuel Type` = 'E' 
ORDER BY `CO2 Emissions(g/km)` DESC;

-- The previous query presented Ethanol as the highest average emission. This is not the expected result, so we'll verify if large vehicles could be skewing the data
SELECT model, `Vehicle Class`, `CO2 Emissions(g/km)`
FROM CO2_Emissions_Canada
WHERE `Fuel Type` ='E' 
ORDER BY 3 DESC;

-- Indeed there were many Vans and SUVs listing Ethanol as Fuel Type. Let's redo the query with that in mind
SELECT `Fuel Type`, `Vehicle Class`, avg(`CO2 Emissions(g/km)`) as average_emission
FROM CO2_Emissions_Canada
GROUP BY `Fuel Type`, `Vehicle Class`
ORDER BY 2, 3 DESC;

-- How does the number of cylinders in a vehicle affect its CO2 emissions?
SELECT Cylinders, AVG(`Engine Size(L)`) AS average_engine_size, AVG(`CO2 Emissions(g/km)`) AS average_emission
FROM CO2_Emissions_Canada
GROUP BY Cylinders
ORDER BY average_engine_size DESC;

-- What is the average fuel consumption (city, highway, and combined) for each fuel type?
SELECT `Fuel Type`, AVG(`Fuel Consumption City (L/100 km)`), AVG(`Fuel Consumption Hwy (L/100 km)`), AVG(`Fuel Consumption Comb (L/100 km)`)
FROM CO2_Emissions_Canada
GROUP BY `Fuel Type`
ORDER BY AVG(`Fuel Consumption Comb (L/100 km)`) ASC;

-- Are there significant differences in CO2 emissions between automatic and manual transmissions?
SELECT 
	-- Using regex to isolate the number of gears from transmission type
    REGEXP_REPLACE(Transmission, '\\d+$', '') AS TransmissionType,
    AVG(`CO2 Emissions(g/km)`) AS average_emission
FROM CO2_Emissions_Canada
GROUP BY TransmissionType
ORDER BY average_emission DESC;