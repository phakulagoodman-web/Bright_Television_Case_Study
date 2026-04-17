select * from `workspace`.`default`.`user_profiles_Btv` limit 100;


---------------------------------------------------------------------
-- Counting IDs
--------------------------------------------------------------------
select count(UserID) from `workspace`.`default`.`user_profiles_Btv`; 


-----------------------------------------------------------------------------
-- Checking how many province we have: we have 9 Provinces
-----------------------------------------------------------------------------

select distinct Province from `workspace`.`default`.`user_profiles_Btv`;

----------------------------------------------------------------------------
-- Checking Gender: we have Male and female
----------------------------------------------------------------------------                

select distinct (Gender) from `workspace`.`default`.`user_profiles_Btv`;

--------------------------------------------------------------------------
--Checking race: we have 5 races
--------------------------------------------------------------------------

select distinct(Race) from `workspace`.`default`.`user_profiles_Btv`

--------------------------------------------------------------------------
-- Categorising Age into Different age groups
-------------------------------------------------------------------------

select Race,
       Province,
       Gender,
       CASE 
        When Age <19 Then 'Teenager'
        When Age Between 20 and 24 then 'Young Adult'
        When Age Between 25 and 34 then 'Middle Aged'
        When Age Between 35 and 44 then 'Adult'
        When Age Between 45 and 54 then 'Senior'
        When Age Between 55 and 64 then 'OLder Adult'
        else 'very Old'
        end as Age_Group
        from `workspace`.`default`.`user_profiles_Btv`;
-----------------------------------------------------------------------------
--Categorising Race
----------------------------------------------------------------------------
select 
        case 
        When Race is Null Then 'Unknown'
        When Race ='black' Then 'B'
        When Race ='white' Then 'W'
        When Race ='indian'Then 'I'
        When Race ='coloured'Then 'C'
        else 'not applicable'
        end as Race_Group
        from `workspace`.`default`.`user_profiles_Btv`;
       





                
  
