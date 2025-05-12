create database project_medical_data_history;
-- 1. Show first name, last name, and gender of patients who's gender is 'M' ---
SELECT FIRST_NAME , LAST_NAME , GENDER 
from PATIENTS 
WHERE GENDER = "M";

-- 2. Show first name and last name of patients who does not have allergies.--

SELECT FIRST_NAME , LAST_NAME , ALLERGIES FROM PATIENTS 
WHERE ALLERGIES IS NULL;

-- 3. Show first name of patients that start with the letter 'C'--

SELECT FIRST_NAME , LAST_NAME FROM PATIENTS 
WHERE FIRST_NAME LIKE "c%";

-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)--

SELECT FIRST_NAME , LAST_NAME , WEIGHT 
FROM PATIENTS 
WHERE WEIGHT BETWEEN 100 AND  120 
ORDER BY WEIGHT desc;

-- 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' --
UPDATE PATIENTS 
SET ALLERGIES = "NKA"
WHERE ALLERGIES IS NULL;

-- NOTE : TO UPDAYTE THE COLOUMS WE SHOULD OFF THE SAFE MODE --

-- 6. Show first name and last name concatenated into one column to show their full name.--

SELECT *, concat(FIRST_NAME , " ", LAST_NAME) AS FULL_NAME 
FROM PATIENTS;

-- 7. Show first name, last name, and the full province name of each patient.--

SELECT FIRST_NAME , LAST_NAME , concat(FIRST_NAME, " ", LAST_NAME) AS FULL_PROVINCE_NAME
FROM PATIENTS;

-- 8. Show how many patients have a birth_date with 2010 as the birth year.--

SELECT COUNT(*) FROM PATIENTS 
WHERE BIRTH_DATE = 2010;

-- 9. Show the first_name, last_name, and height of the patient with the greatest height--
 SELECT FIRST_NAME , LAST_NAME , HEIGHT 
 FROM PATIENTS 
 ORDER BY HEIGHT DESC 
 LIMIT 1;

-- 10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT * FROM PATIENTS 
WHERE PATIENT_ID IN ( 1,45,534,879,1000);

-- 11. Show the total number of admissions--
select COUNT(*) FROM ADMISSIONS ;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.--
 
 SELECT * FROM ADMISSIONS 
 WHERE ADMISSION_DATE = DISCHARGE_DATE ;

-- 13. Show the total number of admissions for patient_id 579.--

SELECT COUNT(*) AS TOTAL_NUMBER_PATIENT  
FROM ADMISSIONS 
WHERE PATIENT_ID = 579;

-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?--
 SELECT DISTINCT city
FROM patients
WHERE province_id = "NS";

-- 15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70--

SELECT FIRST_NAME , LAST_NAME , BIRTH_DATE , HEIGHT , WEIGHT
FROM PATIENTS 
WHERE  HEIGHT >=160 AND WEIGHT >=70
ORDER BY HEIGHT desc;

-- 16. Show unique birth years from patients and order them by ascending.--
 SELECT distinct YEAR (BIRTH_DATE )  as BIRTH_YEAR FROM PATIENTS 
 ORDER BY BIRTH_YEAR asc;
 
-- 17. Show unique first names from the patients table which only occurs once in the list.--

SELECT FIRST_NAME FROM PATIENTS
GROUP BY FIRST_NAME 
HAVING COUNT(*) = 1 ; 

-- 18. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.--
 SELECT PATIENT_ID , FIRST_NAME FROM 
 PATIENTS 
 WHERE FIRST_NAME LIKE "S____%S";
 
 -- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table.--

SELECT P.PATIENT_ID, P.FIRST_NAME ,P.LAST_NAME FROM PATIENTS P
INNER JOIN ADMISSIONS A ON P.PATIENT_ID =A.PATIENT_ID 
WHERE A.DIAGNOSIS ="DEMENTIA";

-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name ASC;

-- 21. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.

SELECT 
COUNT( CASE WHEN GENDER ="M" THEN 1  END ) AS TOTAL_MALE ,
COUNT( CASE WHEN GENDER ="F" THEN 1 END ) AS TOTAL_FEMALE 
FROM PATIENTS;

-- 22. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
 SELECT 
COUNT( CASE WHEN GENDER ="M" THEN 1  END ) AS TOTAL_MALE ,
COUNT( CASE WHEN GENDER ="F" THEN 1 END ) AS TOTAL_FEMALE 
FROM PATIENTS;

-- 23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- 24. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

-- 25. Show first name, last name and role of every person that is either patient or doctor.    The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

-- 26. Show all allergies ordered by popularity. Remove NULL values from query.

SELECT allergies, COUNT(*) AS total_count
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_count DESC;

-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date BETWEEN '1970-01-01' AND '1979-12-31'
ORDER BY birth_date ASC;

-- 28. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. 
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

-- 29. Show the province_id(s), sum of height where the total sum of its patient's height is greater than or equal to 7,000
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING total_height >= 7000;

-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'.
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS total_admissions
FROM admissions
GROUP BY day_of_month
ORDER BY total_admissions DESC;

-- 32. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group.
 SELECT FLOOR(weight / 10) * 10 AS weight_group, COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- 33. Show patient_id, weight, height, and isObese as a boolean (0 or 1).
SELECT patient_id, weight, height,
       IF((weight / (height/100)*(height/100)) > 30, 1, 0) AS isObese
FROM patients;

-- 34. Show patients who have a diagnosis of 'Epilepsy' and an attending doctor with the first name 'Lisa'.

SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy' 
AND d.first_name = 'Lisa';


-- 35. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

  /* The password must be the following, in order:
    - patient_id
    - the numerical length of patient's last_name
    - year of patient's birth_date */
SELECT 
    p.patient_id, 
    CONCAT(p.patient_id, LENGTH(MAX(p.last_name)), YEAR(MAX(p.birth_date))) AS temp_password
FROM 
    patients p
JOIN 
    admissions a ON p.patient_id = a.patient_id
GROUP BY 
    p.patient_id;





