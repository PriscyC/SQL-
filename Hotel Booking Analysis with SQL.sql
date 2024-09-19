use may_batch;
select * from hotel_bookings;

/* Extract the first three characters of each guest's last name.*/
select * from hotel_bookings ;
select left(guestlastname, 3) as first_three from hotel_bookings;

/* Convert all hotel names to uppercase.*/
select upper(hotelname) from hotel_bookings;
   
/* Find the length of each guest's first name.*/
select length(guestfirstname) from hotel_bookings;

/* Concatenate the guest's first and last names with a space in between.*/
select * from hotel_bookings;
select concat(guestfirstname," ", guestlastname) 
as full_name from hotel_bookings;

/* Replace all occurrences of 'Hotel' with 'Inn' in the hotel names.*/
 select replace(hotelname, "hotel" ,"inn") from hotel_bookings;

/* Extract the year from the booking date.*/
  select year(bookingdate) as YEAR from hotel_bookings;
  
/* Find the difference in days between the check-in date and check-out date.*/
select * from hotel_bookings;
select bookingid,datediff(checkoutdate,checkindate) as difference_in_days
from hotel_bookings;

/* Add 10 days to each booking date.*/
select adddate(bookingdate, interval 10 day) as date_add from hotel_bookings;
  
/* Find bookings made in the last 30 days.*/
select * from hotel_bookings where bookingdate
>=date_sub(curdate(), interval 30 day);

/* Format the check-in date as 'YYYY-MM-DD'.*/
SELECT BookingID, DATE_FORMAT(CheckInDate, '%Y-%m-%d') 
  AS Formatted_CheckInDate FROM hotel_bookings;

-- Logical and Comparison Operators--
/*. Find all bookings with more than 3 guests.*/
select * from hotel_bookings where numberofguests > 3;

/*. List all bookings where the room rate is between $100 and $200.--*/
select * from hotel_bookings where roomrate
between 100 and 200;

/* Find all bookings where the hotel is either 'Hotel A' or 'Hotel B'.*/
select * from hotel_bookings 
where HotelName = "Hotel A"or HotelName = "Hotel B";

/*. Find all bookings where the check-in date is before '2024-01-01'.*/
select * from hotel_bookings 
where checkindate < "2024-01-01";

/*. Find bookings with a non-null special request.*/
select * from hotel_bookings where not specialrequest = "";
select * from hotel_bookings where not specialrequest is not null;

 ### Group By, Having, and Order By
/* Count the number of bookings per hotel.*/
select hotelname,count(BookingID) as count
from hotel_bookings
group by hotelname;

/* Find the average room rate per hotel.*/
select * from hotel_bookings;
select roomrate,avg(roomrate) as avg
from hotel_bookings
group by roomrate;

/* List hotels with more than 50 bookings.*/
select * from hotel_bookings;  
select hotelname,count(hotelname) as bookings
from hotel_bookings 
group by hotelname
having bookings > 50;
    
/* Order the bookings by check-in date in descending order.*/
select * from hotel_bookings
order by checkindate DESC;

/* List the total revenue generated by each hotel, sorted from highest to lowest.*/
select * from hotel_bookings;
select hotelname,round(sum(roomrate * NumberOfNights)) as total_revenue
from hotel_bookings 
group by hotelname
order by total_revenue DESC;

-- Case Expressions --
/* Classify the room rate into categories: 'Budget' (under $100), 'Standard' ($100-$200), 'Luxury' (over $200).*/
select * from hotel_bookings;
select *,
case
when roomrate < 100 then "budget"
when roomrate between 100 and 200 then "standard"
else "luxury"
end as category
from hotel_bookings;

/* Flag bookings with more than 3 guests as 'Large' and others as 'Small'.*/
select * from hotel_bookings;
select *,
case
when numberofguests > 3 then "large"
else "small"
end as capacity
from hotel_bookings; 

/* Classify the length of stay: 'Short Stay' (1-3 days), 'Medium Stay' (4-7 days), 'Long Stay' (more than 7 days).*/  
select *,
case
when numberofnights between 1 and 3 then "short"
when numberofnights between 4 and 7 then "medium stay"
else "long stay"
end as staycategory
from hotel_bookings; 

   
