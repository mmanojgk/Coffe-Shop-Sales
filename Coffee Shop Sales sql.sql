use coffee_shop_sales_database;
SELECT * FROM coffee_shop_sales_database.coffee_shop_sales;

describe coffee_shop_sales;

update coffee_shop_sales set transaction_date = str_to_date(transaction_date,'%d-%m-%Y');

alter table coffee_shop_sales modify column transaction_date date;

update coffee_shop_sales set transaction_time = str_to_date(transaction_time,'%H:%i:%s');

alter table coffee_shop_sales modify column transaction_time time;

alter table coffee_shop_sales change column ï»¿transaction_id transaction_id int;

select round(sum( unit_price * transaction_qty )) as total_sales from coffee_shop_sales where month(transaction_date) = 5;

SELECT 
    CASE 
        WHEN SUM(unit_price * transaction_qty) >= 1000 
            THEN CONCAT(ROUND(SUM(unit_price * transaction_qty) / 1000,1), 'K')
        ELSE 
            ROUND(SUM(unit_price * transaction_qty))
    END AS total_sales, month(transaction_date) as sales_month
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) group by MONTH(transaction_date) order by MONTH(transaction_date); -- monthwise sales in k format
    
    
    SELECT 
         month(transaction_date) as month,
         round(sum(unit_price * transaction_qty)) as total_sales,
         (sum(unit_price * transaction_qty ) - lag(sum(unit_price * transaction_qty),1)
         over (order by month(transaction_date))) / lag(sum(unit_price * transaction_qty),1)
		 over (order by month(transaction_date)) * 100 as mom_increase_percentage
         from
           coffee_shop_sales
         where 
             month(transaction_date) in (4,5)
             group by MONTH(transaction_date) order by MONTH(transaction_date);
             
             
             
select concat((count(transaction_id)), ' K') as total_orders 
 from coffee_shop_sales
 where month(transaction_date) = 3; 
 
 
 select month(transaction_date) as month,
 concat((count(transaction_id)), ' K') as total_orders 
 from coffee_shop_sales
 where month(transaction_date) group by month(transaction_date) order by month(transaction_date); -- month wise total orders


SELECT 
         month(transaction_date) as month,
         round(count(transaction_id)) as total_orders,
         (count(transaction_id ) - lag(count(transaction_id),1)
         over (order by month(transaction_date))) / lag(count(transaction_id),1)
		 over (order by month(transaction_date)) * 100 as mom_increase_percentage
         from
           coffee_shop_sales
         where 
             month(transaction_date) in (4,5)
             group by MONTH(transaction_date) order by MONTH(transaction_date);



select 
	transaction_date as date,
	concat(round(sum(unit_price * transaction_qty)/1000,1),' K') as total_sales,
    concat(round(sum(transaction_qty)/1000,1),' K') as total_quantity_sold,
    concat(round(count(transaction_id)/1000,1),' K') as total_orders 
    from coffee_shop_sales
    group by transaction_date order by transaction_date;
    

    
select 
		case when dayofweek(transaction_date) in (1,7) then 'Weekend'
        else 'Weekdays'
        end as day_type,
        concat(round(sum(unit_price * transaction_qty)/1000,1),' K') as total_sales
        from coffee_shop_sales
        where month(transaction_date) = 5
        group by( case when dayofweek(transaction_date) in (1,7) then 'Weekend'
        else 'Weekdays'
        end );
        
        
        
select 
	month(transaction_date) as month,
	store_location,
	concat(round(sum(unit_price * transaction_qty)/1000,1),' K') as total_sales
	from coffee_shop_sales
    -- where month(transaction_date) = 5
    group by store_location , month(transaction_date)
    order by sum(unit_price * transaction_qty) desc;
    
    
    select 
		concat(round(avg(total_sales)/1000,1),' K') as avg_sales
        from 
			( 
				select sum(transaction_qty * unit_price ) as total_sales
                from coffee_shop_sales
                where month(transaction_date) = 5
                group by transaction_date ) as inner_query; 
                

select
		day(transaction_date) as day_of_month,
        concat(round(sum(transaction_qty * unit_price )/1000,1),' K') as total_sales
       from coffee_shop_sales
                where month(transaction_date) = 5
                group by day(transaction_date)
                order by day(transaction_date);
                
                
select 
	  day_of_month,
      case
      when total_sales > avg_sales then 'above average'
      when total_sales < avg_sales then 'below average'
      else 'Equal to average'
      end  as sales_status,total_sales 
      from 
		(
			select day(transaction_date) as day_of_month,
            sum(transaction_qty * unit_price ) as total_sales,
            avg(sum(transaction_qty * unit_price )) over()  as avg_sales
            from coffee_shop_sales
            where
            month( transaction_date) =5 
            group by
            day(transaction_date)) as sales_data
            order by day_of_month;
            
            
            
select 
	    product_category,
        concat(round(sum(unit_price * transaction_qty )/1000,1), 'K') as total_sales
        from coffee_shop_sales
        where month(transaction_date)=5
        group by product_category
		order by sum(unit_price * transaction_qty ) desc;
    
    
    
    select 
	    product_type,
        concat(round(sum(unit_price * transaction_qty )/1000,1), 'K') as total_sales
        from coffee_shop_sales
        where month(transaction_date)=5
        group by product_type
		order by sum(unit_price * transaction_qty ) desc
        limit 10;
    
    
    
    
    select 
        concat(round(sum(unit_price * transaction_qty )), 'K') as total_sales,
		concat(round(sum(transaction_qty)/1000,1), 'K') as total_qty_sold,
		count(*) as total_orders
        from coffee_shop_sales
        where month(transaction_date)=5
        and dayofweek(transaction_date)=2
        and  hour(transaction_time) =8;
        
        
        
        
        select 
		hour(transaction_time),
		concat(round(sum(transaction_qty * unit_price)/1000,1), 'K') as total_sales
        from coffee_shop_sales
        where month(transaction_date)=5
        group by hour(transaction_time)
        order by hour(transaction_time) 
		
    
    
    
    
    
