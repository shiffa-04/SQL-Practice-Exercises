#Show the category_name and description from the categories table sorted by category_name.
Query:  select category_name, description 
        from categories 
        order by category_name;

#Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
Query:  select contact_name, address, city
        from customers 
        where country not in ('Germany', 'Mexico', 'Spain')

#Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
Query:  select order_date, shipped_date, customer_id, freight 
        from orders 
        where order_date = "2018-02-26"

#Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date
Query:  select employee_id, order_id, customer_id, required_date, shipped_date
        from orders 
        where shipped_date > required_date

#Show all the even numbered Order_id from the orders table
Query:  SELECT order_id
        FROM orders
        WHERE mod(order_id,2)=0;

#Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name
Quey:   SELECT city, company_name, contact_name
        FROM customers
        WHERE city LIKE '%L%'
        ORDER BY contact_name;