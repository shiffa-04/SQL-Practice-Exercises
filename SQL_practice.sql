# Show first name, last name, and gender of patients whose gender is 'M'
 
    Query: SELECT first_name, last_name, gender  FROM patients WHERE gender ="M"

# Show first name and last name of patients who does not have allergies. (null)

    Query: SELECT first_name, last_name FROM patients WHERE allergies is null

# Show first name of patients that start with the letter 'C'

    Query: SELECT first_name FROM patients WHERE first_name like "C%"

#Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

    Query: SELECT first_name, last_name FROM patients WHERE weight between 100 and 120;

#Update the patients table for the allergies column. If the patients allergies is null then replace it with 'NKA'

    Query: update patients SET allergies = "NKA" where allergies is null

#Show first name and last name concatinated into one column to show their full name.

   Query: select concat(first_name," ",last_name) AS full_name from patients

#Show first name, last name, and the full province name of each patient.
 Example: 'Ontario' instead of 'ON'

   Query: select first_name, last_name, province_name from patients join province_names using(province_id);

#Show how many patients have a birth_date with 2010 as the birth year.
   Query: select count(patient_id) from patients where birth_date like '2010-%%-%%'

#Show the first_name, last_name, and height of the patient with the greatest height.
   Query: select first_name, last_name, height from patients where height = (select max(height) from patients);

#Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000
   Query: select * from patients where patient_id in (1,45, 534, 879, 1000);

#Show the total number of admissions
   Query: SELECT count(patient_id) FROM admissions

#Show all the columns from admissions where the patient was admitted and discharged on the same day.
   Query: SELECT * FROM admissions where admission_date == discharge_date

#Show the patient id and the total number of admissions for patient_id 579.
   Query: SELECT patient_id, count(*) As total_admission FROM admissions where patient_id = 579

#Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
   Query: SELECT distinct(CITY) FROM patients where province_id IS 'NS'

#Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
   Query: select first_name, last_name, birth_date from patients where height > 160 and weight > 70

#Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
   Query: select first_name, last_name, allergies from patients where allergies IS NOT null AND city = "Hamilton"

#Show unique birth years from patients and order them by ascending.
   Query: select distinct(year(birth_date)) As birth_year from patients order by birth_year