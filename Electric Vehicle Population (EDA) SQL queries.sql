
select * 
from electric_vehicle ;

-- finding total_records, unique_dol_vehicle_ids, unique_brands and unique_models

select count(*) as total_records, count(distinct dol_vehicle_id) as unique_dol_vehicle_ids, 
count(distinct brand) as unique_brands, count(distinct model) as unique_models
from electric_vehicle ;



-- finding the capacity of each vehicle type

select vehicle_type, count(vehicle_type) as total_vehicles, round(count(vehicle_type)/(select count(*)
	                     from electric_vehicle) * 100.0 , 2) as percentage
from electric_vehicle
group by vehicle_type
order by total_vehicles desc ;


-- Finding Top 10 Brands by Vehicle Count

select brand, count(dol_vehicle_id) as vehicle_count
from electric_vehicle
group by brand
order by vehicle_count desc
limit 10 ;


-- Finding Average Electric Range by Brand

select brand, round(avg(electric_range), 1) as average_electric_range
from electric_vehicle
where electric_range is not null
group by brand
order by average_electric_range desc  ;


-- Finding Electric Range Trends by Model Year

select model_year, round(avg(electric_range), 1) as average_range
from electric_vehicle
where electric_range is not null
group by model_year
order by model_year ;


-- Finding vehicle count of Clean_Alternative_Fuel Eligible vs. Ineligible Vehicles

select Clean_Alternative_Fuel_Vehicle_Eligibility, count(*) as vehicle_count
from electric_vehicle
group by Clean_Alternative_Fuel_Vehicle_Eligibility
order by vehicle_count desc ;



-- Finding top 10 counties who registered the most electric vehicles.

select county, count(DOL_Vehicle_ID) as vehicle_count
from electric_vehicle
group by county
order by vehicle_count desc
limit 10 ;


--  Checking if higher-priced vehicles tend to have better range 


select Base_MSRP, round(avg(Electric_Range), 1) as avg_electric_range
from electric_vehicle
where Base_MSRP is not null and Electric_Range is not null 
group by Base_MSRP
order by Base_MSRP desc ;



-- Identifying districts with the highest Clean alternative fuel eligible vehicle

select Legislative_District, count(DOL_Vehicle_ID) as count_of_Clean_Alternative_Fuel_eligible_Vehicles
from electric_vehicle
where Clean_Alternative_Fuel_Vehicle_Eligibility = 'eligible'
group by Legislative_District
order by count_of_Clean_Alternative_Fuel_eligible_Vehicles desc
limit 10 ;


-- Discovering which electric utilities serve the most EVs.

select Electric_Utility, count(dol_vehicle_id) as number_of_vehicles_served
from electric_vehicle
group by Electric_Utility
order by number_of_vehicles_served desc
limit 10 ;


-- Checking average range by county for regional analysis

select county, round(avg(Electric_Range), 1) as avg_electric_range
from electric_vehicle
where Electric_Range is not null
group by county
order by avg_electric_range desc ;


-- Assessing which brand offers the widest model varieties

select brand, count(distinct Model) as number_of_models
from electric_vehicle
group by brand
order by number_of_models desc
limit 1









