--Hannah Youssef
--Lab 10 exercises (11/27/17)

/* #1: function PreReqsFor(courseNum) - Returns the immediate prerequisites for the passed-in course number. */
CREATE OR REPLACE FUNCTION preReqsFor(INT, refcursor) RETURNS refcursor AS
$$
DECLARE
  course_number INT       := $1;
  results       refcursor := $2;
BEGIN
  OPEN results FOR
    SELECT num, name
    FROM COURSES c
    WHERE c.num IN (
      SELECT p.preReqNum
      FROM Prerequisites p
      WHERE coursenum = course_number
    );
  return results;
END;
$$
language plpgsql;

SELECT preReqsFor(225, 'prereqs');
FETCH ALL FROM prereqs;

/* #2: function isPreReqFor(courseNum) - Returns all the courses for which this course is a pre-requisite. */
CREATE OR REPLACE FUNCTION isPreReqFor(INT, refcursor) RETURNS refcursor AS
$$
DECLARE
  course_number INT       := $1;
  results       refcursor := $2;
BEGIN
  OPEN results FOR
    SELECT num, name
    FROM COURSES c
    WHERE c.num IN (
      SELECT p.courseNum
      FROM Prerequisites p
      WHERE preReqNum = course_number
    );
  return results;
END;
$$
language plpgsql;

SELECT isPreReqFor(220, 'postreqs');
FETCH ALL FROM postreqs;