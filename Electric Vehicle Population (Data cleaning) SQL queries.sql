
select * 
from electric_vehicle ;

-- fixing column headers

alter table electric_vehicle rename column `VIN (1-10)` to `Vehicle_ID_Number (1-10)` ;
alter table electric_vehicle rename column `Postal Code` to `Postal_Code` ;
alter table electric_vehicle rename column `Model Year` to `Model_Year`;
alter table electric_vehicle rename column `Make` to `Brand` ; 
alter table electric_vehicle rename column `Electric Vehicle Type` to `Vehicle_Type` ;
alter table electric_vehicle rename column `Clean Alternative Fuel Vehicle (CAFV) Eligibility` to `Clean_Alternative_Fuel_Vehicle_Eligibility` ;
alter table electric_vehicle rename column `Electric Range` to `Electric_Range` ;
alter table electric_vehicle rename column `Base MSRP` to `Base_MSRP` ;
alter table electric_vehicle rename column `Legislative District` to `Legislative_District` ;
alter table electric_vehicle rename column `DOL Vehicle ID` to `DOL_Vehicle_ID` ;
alter table electric_vehicle rename column `Vehicle Location` to `Vehicle_Location` ;
alter table electric_vehicle rename column `Electric Utility` to `Electric_Utility` ;
alter table electric_vehicle rename column `2020 Census Tract` to `2020_Census_Tract` ;


-- finding 0 values in Electric_Range

select *
from electric_vehicle
where Electric_Range = 0 ;



-- replacing 0 values with null in Electric_Range

update electric_vehicle
set Electric_Range = null
where Electric_Range = 0 ;


-- replacing 0 values with null in Base_MSRP

update electric_vehicle
set Base_MSRP = null
where Base_MSRP = 0 ;


-- fixing some flaws in electric utility colomn

select Electric_Utility, replace(Electric_Utility,'||',' | ')
from electric_vehicle ;

update electric_vehicle
set Electric_Utility = replace(Electric_Utility,'||',' | ') ;


-- adding longitude and latitude column

alter table electric_vehicle
add column Longitude decimal (10, 6) after vehicle_location ;

alter table electric_vehicle
add column Latitude decimal (10, 6) after Longitude ; 


-- extracting longitude and latitude from vehicle_location

select vehicle_location, regexp_substr(Vehicle_Location, '-?[0-9]+\\.[0-9]+', 1, 1), regexp_substr(Vehicle_Location, '-?[0-9]+\\.[0-9]+', 1, 2)
from electric_vehicle ;


-- updating added longitude and latitude columns with the extracted values

update electric_vehicle
set longitude = regexp_substr(Vehicle_Location, '-?[0-9]+\\.[0-9]+', 1, 1) ;

update electric_vehicle
set latitude = regexp_substr(Vehicle_Location, '-?[0-9]+\\.[0-9]+', 1, 2) ;




-- simplifying Clean_Alternative_Fuel_Vehicle_Eligibility column 

update electric_vehicle
set Clean_Alternative_Fuel_Vehicle_Eligibility = 
							case when Clean_Alternative_Fuel_Vehicle_Eligibility =  'Not eligible due to low battery range' then 'Not eligible'
								when Clean_Alternative_Fuel_Vehicle_Eligibility = 'Clean Alternative Fuel Vehicle Eligible' then 'Eligible'
                                else 'Unknown' end
	