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

#Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"
   Query: SELECT first_name, last_name, 'Patient' AS role
         FROM patients
         UNION ALL
         SELECT first_name, last_name, 'Doctor' AS role
         FROM doctors;

#Show all allergies ordered by popularity. Remove NULL values from query.
   Query: select allergies, count(allergies) from patients 
         where allergies is not null  
         group by allergies order by count(allergies) desc

#Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
   Query: select first_name, last_name, birth_date from patients where year(birth_date) between 1970 and 1979 order by birth_date

#Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
   Query: SELECT province_id, SUM(height) AS total_height
         FROM patients
         GROUP BY province_id
         HAVING SUM(height) >= 7000;

#We want to display each patients full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order.
   Query: select concat(upper(last_name),"," ,lower(first_name)) As FULL_NAME from patients order by first_name Desc;

#Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
   Query: select (max(weight) - min(weight)) AS difference from patients where last_name = 'Maroni'

#Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
   Query: select day(admission_date) As day_number , count(*) As number_of_admissions from admissions group by day_number order by number_of_admissions DESC

#Show all columns for patient_id 542s most recent admission_date.
   Query: SELECT * FROM admissions WHERE patient_id = 542 GROUP BY patient_id HAVING admission_date = MAX(admission_date);

#Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
   Query: select patient_id, attending_doctor_id, diagnosis from admissions where (patient_id % 2 !=0 And attending_doctor_id In( 1, 5, 19)) OR (attending_doctor_id like '%2%'And length(patient_id)==3)

#Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.
   Query: select d.first_name, d.last_name, count(a.admission_date) as admision_total from doctors d join admissions a ON a.attending_doctor_id == d.doctor_id group by first_name, last_name

#For each doctor, display their id, full name, and the first and last admission date they attended.
   Query: select d.doctor_id, concat(d.first_name, " ", d.last_name) as full_name , min(a.admission_date) as first_admission_date, max(a.admission_date) as last_admission_date from doctors d join admissions a on d.doctor_id == a.attending_doctor_id group by d.doctor_id

#Display the total amount of patients for each province. Order by descending.
Query:   select pro.province_name, count(pat.patient_id) As amount_of_patients 
         from  patients pat 
         join province_names pro on pro.province_id == pat.province_id  
         group by pro.province_name 
         order by amount_of_patients desc 

#For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem
Query:   select concat(p.first_name," ", p.last_name) As full_name, a.diagnosis, concat(d.first_name," ", d.last_name) As doctors_name 
         from admissions a
         join patients p on a.patient_id == p.patient_id
         join doctors d on a.attending_doctor_id == d.doctor_id

#display the first name, last name and number of duplicate patients based on their first name and last name.
Ex: A patient with an identical name can be considered a duplicate.
Query:select first_name, last_name, count(*) as num_of_duplicates
      from patients
      group by first_name, last_name
      having count(*) > 1

#Display patients full name, height in the units feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated.
Convert CM to feet by dividing by 30.48.Convert KG to pounds by multiplying by 2.205.
Query:SELECT 
      concat(first_name, " ", last_name) AS patient_full_name,
      ROUND(height / 30.48, 1) AS height_feet,
      ROUND(weight * 2.205, 0) AS weight_pounds,
      birth_date,
      CASE 
         WHEN gender = 'M' THEN 'Male'
         WHEN gender = 'F' THEN 'Female'
         ELSE 'Other'
      END AS gender
      FROM patients;

#Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
Query: select p.patient_id, p.first_name, p.last_name 
       from patients p 
       where p.patient_id not in (SELECT a.patient_id FROM admissions a)

#Show all of the patients grouped into weight groups.Show the total amount of patients in each weight group.Order the list by the weight group decending.
For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
Query: SELECT 
         FLOOR(Weight / 10) * 10 AS WeightGroup, 
         COUNT(*) AS TotalPatients
      FROM 
         patients
      GROUP BY 
         WeightGroup
      ORDER BY 
         WeightGroup DESC;

#Show patient_id, weight, height, isObese from the patients table.Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30.weight is in units kg.height is in units cm.
Query: SELECT 
         patient_id, 
         weight, 
         height, 
         CASE 
            WHEN weight / ((height / 100.0) * (height / 100.0)) >= 30 THEN 1 
            ELSE 0 
         END AS isObese
      FROM patients;

#Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
Check patients, admissions, and doctors tables for required information. 
Query:SELECT 
         p.patient_id, 
         p.first_name, 
         p.last_name, 
         d.specialty
      FROM 
         patients p
      JOIN 
         admissions a ON a.patient_id = p.patient_id
      JOIN 
         doctors d ON a.attending_doctor_id = d.doctor_id
      WHERE 
         a.diagnosis = 'Epilepsy' 
         AND d.first_name = 'Lisa';

#All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date

Query:SELECT DISTINCT 
         a.patient_id, 
         CONCAT(a.patient_id, LENGTH(p.last_name), YEAR(p.birth_date)) AS temp_password
      FROM 
         admissions a
      JOIN 
         patients p ON p.patient_id = a.patient_id;

#Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a Yes if they have insurance, and a No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

Query:SELECT 
    has_insurance,
    SUM(admission_cost) AS total_admission_cost
FROM (
    SELECT 
        patient_id,
        CASE WHEN patient_id % 2 = 0 THEN 'Yes' ELSE 'No' END AS has_insurance,
        CASE WHEN patient_id % 2 = 0 THEN 10 ELSE 50 END AS admission_cost
    FROM admissions
) AS patient_info
GROUP BY has_insurance;

#Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

Query:SELECT province_name
      FROM province_names
      JOIN patients 
      ON province_names.province_id = patients.province_id
      GROUP BY province_name
      HAVING SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) > SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END);

#We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'

Query:SELECT *
      FROM patients
      WHERE
      SUBSTRING(first_name, 3) LIKE '%r%' AND
      gender = 'F' AND
      MONTH(birth_date) IN (2, 5, 12) AND
      weight BETWEEN 60 AND 80 AND
      MOD(patient_id, 2) = 1 AND
      city = 'Kingston';

#Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

Query:SELECT 
    CONCAT(
        ROUND((COUNT(CASE WHEN gender = 'M' THEN 1 END) * 100.0 / COUNT(*)), 2), 
        '%'
    ) AS percent_of_male_patients
FROM 
    patients;

#For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
Query:SELECT 
         admission_date,
         COUNT(patient_id) AS total_admissions,
         COUNT(patient_id) - LAG(COUNT(patient_id), 1) OVER (ORDER BY admission_date) AS change_from_previous_day
      FROM 
         admissions
      GROUP BY 
         admission_date
      ORDER BY 
         admission_date;
#Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
Query:SELECT province_name
      FROM provinces
      ORDER BY 
         CASE 
            WHEN province_name = 'Ontario' THEN 0
            ELSE 1
         END, 
         province_name ASC;

#We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
Query: SELECT 
         d.doctor_id,
         CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name,
         d.specialty,
         YEAR(a.admission_date) AS year,
         COUNT(a.patient_id) AS total_admissions
      FROM 
         admissions a
      JOIN 
         doctors d ON a.attending_doctor_id = d.doctor_id
      GROUP BY 
         d.doctor_id,
         doctor_full_name,
         d.specialty,
         year
      ORDER BY 
         d.doctor_id,
         year;