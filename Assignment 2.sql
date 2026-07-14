# Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
select * from sakila.customer;

Select first_name,last_name,email,Count(*) as duplicate_count
From sakila.customer
Group By first_name,last_name,email
Having Count(*) > 1;

# Number of times letter 'a' is repeated in film descriptions
Select title, description, Length(description) - Length(Replace(Lower(Description), 'a', '')) AS a_count
From sakila.film
Order By a_count desc;

# Number of times each vowel is repeated in film descriptions 
Select title, 
Length(description) - Length(Replace(Lower(Description), 'a', '')) AS a_count,
Length(description) - Length(Replace(Lower(Description), 'e', '')) AS e_count,
Length(description) - Length(Replace(Lower(Description), 'i', '')) AS i_count,
Length(description) - Length(Replace(Lower(Description), 'o', '')) AS o_count,
Length(description) - Length(Replace(Lower(Description), 'u', '')) AS u_count
From sakila.film;


# Display the payments made by each customer
Select * from sakila.payment;
# Month wise
Select customer_id,
	Year(payment_date) as payment_year,
	Month(payment_date) as payment_month,
	Count(*) as number_payments,
	Sum(amount) as total_paid
From sakila.payment
Group By customer_id, Year(payment_date), Month(payment_date)
Order By customer_id, payment_year, payment_month; 
	
        
# Year wise
Select customer_id,
	Year(payment_date) as payment_year,
    Count(*) as number_payments,
    Sum(amount) as total_paid
From sakila.payment
Group By customer_id, Year(payment_date)
Order By customer_id, payment_year;

# Week wise
Select customer_id,
	Year(payment_date) as payment_year,
	Week(payment_date) as payment_week,
	Count(*) as number_payments,
	Sum(amount) as total_paid
From sakila.payment
Group By customer_id, Year(payment_date), Week(payment_date)
Order By customer_id, payment_year, payment_week; 

# Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
Select
	2024 as input_year,
    Case
		When (2024 % 4 = 0 And 2024 % 100 != 0) OR (2024 % 400 = 0)
        Then 'Leap Year'
        Else 'Not an leap year'
	End as leap_year_status;


# Display number of days remaining in the current year from today.
Select 
	Datediff(
		Concat(year(curdate()), '-12-31'),
        Curdate()
	) As days_reamining_in_year;

# Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
Select payment_id, payment_date,
	Concat('Q',Quarter(payment_date)) As quarter_number
From sakila.payment;
    