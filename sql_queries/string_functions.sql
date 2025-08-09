-- String Functions Lesson

-- UPPER, LOWER and INTCAP
-- ####################################

-- To convert a string into uppercase, you use PostgreSQL's UPPER function. 
-- UPPER('your_string_here');´

-- To convert a string into lowercase, you use PostgreSQL's LOWER function.
-- LOWER('your_string_here');

-- The INTCAP function converts a string expression into proper case or title case,
-- which the first letter of each word is in uppercase and the remaining characters in lowercase.

SELECT UPPER('amazing postgresql');

SELECT 
  UPPER(first_name) AS upper_first_name,
  UPPER(last_name) AS upper_last_name
FROM directors;

SELECT LOWER('AMAZING POSTGRESQL');

-- Initcap
SELECT INITCAP('the world is chaning with a lightning speed');


SELECT INITCAP(
  CONCAT (first_name, ' ', last_name)
) AS full_name
FROM directors
ORDER BY full_name;


-- LEFT and RIGHT functions
-- ####################################

-- PostgreSQL's LEFT function returns the first n characters in the string.

--- LEFT('your_string_here', n);

SELECT LEFT('PostgreSQL', 4) AS left_string; -- 'Post'

-- n is -2, therefore, the LEFT() function returns all characters except the last 2 characters.

SELECT LEFT('PostgreSQL', -2) AS left_string; -- 'PostgreS'

-- Get initial for all directors name

SELECT
  LEFT(first_name, 1) AS first_name_initial,
FROM directors
ORDER BY 1;

-- PostgreSQL's RIGHT function returns the last n characters in the string.

-- RIGHT('your_string_here', n);

SELECT RIGHT('PostgreSQL', 4) AS right_string; -- 'SQL'

SELECT RIGHT('PostgreSQL', -2) AS right_string; -- 'Postgre'

-- Get last name initials for all directors

SELECT
  RIGHT(last_name, 1) AS last_name_initial
FROM directors
ORDER BY 1;


-- REVERSE function
-- ####################################
-- PostgreSQL's REVERSE() function is used to arrange a string in reverse order.

-- REVERSE('your_string_here');


SELECT REVERSE('PostgreSQL') AS reversed_string; -- 'lSQetorgP'

SELECT REVERSE('111AAA') AS reversed_string; -- 'AA111'

SELECT REVERSE('LQSetorgP gnizamA') AS reversed_string; -- 'Amazing PostgreSQL'


-- SPLIT_PART function
-- ####################################
-- PostgreSQL's SPLIT_PART function splits a string on a specified delimiter and returns the nth substring.

-- SPLIT_PART('your_string_here', 'delimiter', n);

SELECT SPLIT_PART('1,2,3', ',', 2) AS second_part; -- '2'

SELECT SPLIT_PART('ONE,TWO,THREE', ',', 2) AS second_part; -- 'TWO'

SELECT SPLIT_PART('A|B|C|D', '|', 3) AS third_part; -- 'C'

-- Get the release year of all movies

SELECT
  movie_name,
  relase_date,
  SPLIT_PART(relase_date::text, '-', 1) AS release_year
FROM movies
ORDER BY release_year DESC;


-- TRIM, BTRIM, LTIM and RTRIM functions
-- ####################################

/*

  TRIM removes the longest string that contains a specific character from a string.

  LTRIM removes all characters, spaces by default, from the beginning of a string.

  RTRIM removes all characters, spaces by default, from the end of a string.

  BTRIM is the convination of the LTRIM and RTRIM functions.

*/

-- The TRIM() function removes the longest string that contains a specific character from a string.


-- TRIM([LEADING | TRAILING | BOTH] 'character' FROM 'your_string_here');

-- TRIM(LEADING FROM 'your_string_here');

-- TRIM(TRAILING FROM 'your_string_here');

-- TRIM(BOTH FROM 'your_string_here');


-- LTRIM('your_string_here', ['character']);
-- RTRIM('your_string_here', ['character']);
-- BTRIM('your_string_here', ['character']);

SELECT 
  TRIM(
    LEADING
    FROM '     Amazing PostgreSQL'
  ),
  TRIM(
    TRAILING
    FROM 'Amazing PostgreSQL     '
  ),
  TRIM(
     '     Amazing PostgreSQL     '
  );

-- Remove leading zeros from a string


SELECT 
  TRIM(
    LEADING '0'
    FROM 
    CAST (000123456789 AS TEXT)
  ) AS trimmed_string;


SELECT
  LTRIM('     Amazing PostgreSQL') AS ltrimmed_string,
  RTRIM('Amazing PostgreSQL     ') AS rtrimmed_string,
  BTRIM('     Amazing PostgreSQL     ') AS btrimmed_string;



-- LPAD and RPAD Functions
-- ####################################

/*
  
  LPAD function pads a string on the left to a specified length with a sequence of characters.

  RPAD function pads a string on the right to a specified length with a sequence of characters.

*/

-- LPAD('your_string_here', length, 'character_sequence');

-- RPAD('your_string_here', length, 'character_sequence');


-- The fill argument is optional, if you omit the fill arcgument, it's default value is a space.

SELECT 
  LPAD('PostgreSQL', 20, '*') AS left_padded_string, -- '*******PostgreSQL'
  RPAD('PostgreSQL', 20, '*') AS right_padded_string; -- 'PostgreSQL*******'

  SELECT LPAD('1111', 6, 'A') AS left_padded_string, -- 'AA1111'


-- LENGTH function
-- ####################################


-- length return the number of characters or bytes in a string.


-- LENGTH('your_string_here');

SELECT LENGTH('PostgreSQL') AS string_length; -- 11


SELECT LENGTH('') AS string_length; -- 0
SELECT LENGTH(' ') AS string_length; -- 1


SELECT LENGTH(NULL) AS string_length; -- NULL

-- POSITION function
-- ####################################


/*

  1. PostgreSQL's POSITION function returns the location of a substring within a string.

  2. POSITION('substring' IN 'string');

  3. return an integer that represents the location of the substring within the string.

  4. return the first instance of the substring within the string.

  5. searches for the substring in a case-sensitive manner.

*/

SELECT POSITION('SQL' IN 'PostgreSQL') AS position; -- 6

SELECT POSITION('is ' IN 'This is a computer') AS position; -- 3



