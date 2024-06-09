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

#Show unique first names from the patients table which only occurs once in the list.

#For example, if two or more people are named 'John' in the first_name column then do not include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
   Query: select first_name from patients group by first_name having count(first_name) = 1

#Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
   Query: select patient_id, first_name from patients where first_name like 's%s' and len(first_name) >= 6

#Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
   Query: select patient_id, first_name, last_name from patients join admissions  using(patient_id) where diagnosis = 'Dementia'

#Display every patients first_name. Order the list by the length of each name and then by alphabetically.
   Query: select first_name from patients order by len(first_name), first_name

#Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.
   Query:SELECT 
         sum(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
         sum(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
      FROM 
         patients;
#Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
   Query: select first_name, last_name, allergies from patients where allergies = 'Penicillin' or allergies= 'Morphine' 
         order by allergies , first_name, last_name

#Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
   Query: select patient_id, diagnosis from admissions group by patient_id , diagnosis having count(*)>1

#Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.
   Query: select city , count(patient_id) As total_patients from patients group by city 
         order by total_patients desc, city asc