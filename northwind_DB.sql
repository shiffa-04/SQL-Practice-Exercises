#Show the category_name and description from the categories table sorted by category_name.
Query:  select category_name, description 
        from categories 
        order by category_name;

#Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
Query:  select contact_name, address, city
        from customers 
        where country not in ('Germany', 'Mexico', 'Spain')