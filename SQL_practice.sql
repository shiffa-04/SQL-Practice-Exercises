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