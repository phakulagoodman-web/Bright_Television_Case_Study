select * from  workspace.default.viewership_btv LIMIT 100;

-------------------------------------------------------------------------------
--Counting Ids
------------------------------------------------------------------------------

select count(Userid)from  workspace.default.viewership_btv LIMIT 100;

------------------------------------------------------------------------------
--Cheching how many channels are there: we have 21 channels
------------------------------------------------------------------------------
select  distinct Channel2 from workspace.default.viewership_btv;


--------------------------------------------------------------------------------
--Checking the maximum date 
---------------------------------------------------------------------------------
select max(RecordDate2) from  workspace.default.viewership_btv;


--------------------------------------------------------------------------------
--Checking the minimum date 
---------------------------------------------------------------------------------

select min(RecordDate2) from  workspace.default.viewership_btv;



-----------------------------------------------------------------------------
--Count userid we have 10000 records
-----------------------------------------------------------------------------

select count(Userid) from workspace.default.viewership_btv;


-----------------------------------------------------------------------------
--Converted time to south african time 
-----------------------------------------------------------------------------

select  date_format (RecordDate2 + INTERVAL '2 hour','HH:mm:ss') as Converted_time from workspace.default.viewership_btv;


---------------------------------------------------------------------------------------------------------
--Extracting Date from the timestamp
--------------------------------------------------------------------------------------------------------

select  date_format (RecordDate2,'yyy-MM-dd') as Date from workspace.default.viewership_btv;


---------------------------------------------------------------------------------------------------
--Checking if there is any null value in the channel column
--------------------------------------------------------------------------------------------------
select Channel2,
       RecordDate2,
       Duration2,
       userid,
       UserID0
       from workspace.default.viewership_btv
       where Channel2 is null;



---------------------------------------------------------------------------------------------------
--Compiling one big query
--------------------------------------------------------------------------------------------------

select
      Province,
      Gender,
      Race,
      Age,
      Channel2,
      dayofweek(RecordDate2) as day_of_week,
      dayname(RecordDate2) as Day_day,
      date_format(RecordDate2,'MMMM') as Month_name,
      dayofmonth(RecordDate2) as day_of_month,
      date_format (RecordDate2,'yyy-MM-dd') as Record_Date,
      date_format (RecordDate2 + INTERVAL '2 hour','HH:mm:ss') as Converted_time,
      date_format (Duration2,'HH:mm:ss') as Duration_viewed,

Case
          when Dayname(RecordDate2) in ('Sat','Sun') Then 'weekend'
          Else 'Weekday'
          End as day_Buckets,

 Case
        When Age is Null Then 'unkwown'
        When Age <19 Then 'Teenager'
        When Age Between 20 and 24 then 'Young Adult'
        When Age Between 25 and 34 then 'Middle Aged'
        When Age Between 35 and 44 then 'Adult'
        When Age Between 45 and 54 then 'Senior'
        When Age Between 55 and 64 then 'OLder Adult'
        else 'very Old'
        end as Age_Group,
   
Case 
        When Race is Null Then 'Unknown'
        When Race ='black' Then 'B'
        When Race ='white' Then 'W'
        When Race ='indian'Then 'I'
        When Race ='coloured'Then 'C'
        else 'not applicable'
        end as Race_Group,  

Case
        When Province is Null Then 'unknown'
        When Province='Gauteng' Then 'Code 01'
        When Province='Limppopo' Then 'Code 02'
        When Province='Western Cape' then 'Code 03'
        When Province='Kwazulu Natal' then 'Code 04'
        When Province='Eastern Cape' Then 'Code 05'
        When Province='Northern Cape' then 'Code 06'
        When Province='Free State' then 'Code 07'
        When Province='North West' Then 'Code 08'
        When Province='Mpumalanga' Then 'Code 09'
        else 'Unknown'
        end as Province_code,

   Case
          When date_format (Duration_viewed,'HH:mm:ss') <= '00:30:00'  then '01 Very Short'
          When date_format (Duration_viewed,'HH:mm:ss') Between '00:30:01' and  '01:00:00' then '02 Moderate'
          When date_format (Duration_viewed,'HH:mm:ss') >='01:00:01'  then '03 Too long'
          End as Time_Buckets

      from workspace.default.viewership_btv as A
      left join workspace.default.user_profiles_btv as B
      on A.Userid = B.Userid
      order by day_buckets,
               Time_Buckets,
               Age_Group,
               Province_code,
               Race_Group;
      
               
