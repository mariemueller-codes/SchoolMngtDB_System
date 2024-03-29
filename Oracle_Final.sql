CREATE TABLE ADDRESSES(
ADDRESS_ID  NUMBER NOT NULL,
ADDRESS     VARCHAR2(100) NOT NULL,
CITY        VARCHAR2(50),
STATE       VARCHAR2(2),
ZIPCODE     VARCHAR2(10),
CONSTRAINT ADDRESS_ID_PK PRIMARY KEY (ADDRESS_ID)
);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (1, '123 APPLE ST', 'AUSTIN', 'TX', 12345);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (2, '110 CHERUBINI ST', 'AUSTIN', 'TX', 12345);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (3, '210 CHERUBINI ST', 'AUSTIN', 'TX', 12345);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (4, '12345 CROSS ST', 'AUSTIN', 'TX', 12345);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (5, '3366 METRIC ST', 'AUSTIN', 'TX', 12347);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (6, '1211 PLOUGH ST', 'PFLUGERVILLE', 'TX', 12366);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (7, '209 HIGHLAND ST', 'ROUND ROCK', 'TX', 12350);

INSERT INTO ADDRESSES (ADDRESS_ID, ADDRESS, CITY, STATE, ZIPCODE)
VALUES (8, '1129 HIGHLAND ST', 'ROUND ROCK', 'TX', 12350);
COMMIT;

CREATE TABLE SCHOOLS (
SCHOOL_ID    NUMBER NOT NULL,
SCHOOLNAME   VARCHAR2(100) NOT NULL,
PRINCIPAL    VARCHAR2(50),
ADDRESS_ID   NUMBER,
CONSTRAINT SCHOOL_ID_PK PRIMARY KEY (SCHOOL_ID)
);

ALTER TABLE SCHOOLS ADD CONSTRAINT FK_SCL_ID_ADD_ID FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESSES(ADDRESS_ID);

INSERT INTO SCHOOLS (SCHOOL_ID, SCHOOLNAME, PRINCIPAL, ADDRESS_ID)
VALUES(1, 'ABC ELEMENTARY SCHOOL', 'JOHN DOE I', 1);

INSERT INTO SCHOOLS (SCHOOL_ID, SCHOOLNAME, PRINCIPAL, ADDRESS_ID)
VALUES(2, 'XYZ MIDDLE SCHOOL', 'JANE DOE', 2);

INSERT INTO SCHOOLS (SCHOOL_ID, SCHOOLNAME, PRINCIPAL, ADDRESS_ID)
VALUES(3, 'RR HIGH SCHOOL', 'ALAN WELLS', 3);

COMMIT;

CREATE TABLE PARENTS (
PARENT_ID    NUMBER NOT NULL,
LASTNAME     VARCHAR2(50) NOT NULL,
FIRSTNAME    VARCHAR2(50),
ADDRESS_ID   NUMBER,
CONTACTNO    VARCHAR2(20),
GENDER       CHAR(1) NOT NULL,
RELATIONSHIP VARCHAR2(20) NOT NULL,
CONSTRAINT PARENT_ID_PK PRIMARY KEY (PARENT_ID)
);

ALTER TABLE PARENTS ADD CONSTRAINT FK_PRNT_ID_ADD_ID FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESSES(ADDRESS_ID);

ALTER TABLE PARENTS ADD CONSTRAINT CHK_GENDER CHECK(GENDER IN ('M','F'));

INSERT INTO PARENTS (PARENT_ID, LASTNAME, FIRSTNAME, ADDRESS_ID, CONTACTNO, GENDER, RELATIONSHIP)
VALUES(1, 'DOE', NULL, 4, NULL, 'M', 'FATHER');

INSERT INTO PARENTS (PARENT_ID, LASTNAME, FIRSTNAME, ADDRESS_ID, CONTACTNO, GENDER, RELATIONSHIP)
VALUES(2, 'DOE', 'JANE', 5, '111-222-3333', 'F', 'MOTHER');

INSERT INTO PARENTS (PARENT_ID, LASTNAME, FIRSTNAME, ADDRESS_ID, CONTACTNO, GENDER, RELATIONSHIP)
VALUES(3, 'WELLS', 'ROSE', 6, '876-252-3333', 'F', 'MOTHER');

COMMIT;

CREATE TABLE STUDENTS(
STUDENT_ID   NUMBER NOT NULL,
LASTNAME     VARCHAR2(50) NOT NULL,
FIRSTNAME    VARCHAR2(50),
DATEOFBIRTH  DATE NOT NULL,
SCHOOL_ID    NUMBER NOT NULL,
ADDRESS_ID   NUMBER,
PARENT_ID    NUMBER NOT NULL,
GENDER       CHAR(1) NOT NULL,
CONTACTNO    VARCHAR2(20),
CONSTRAINT STUDENT_ID_PK PRIMARY KEY (STUDENT_ID)
);

ALTER TABLE STUDENTS ADD CONSTRAINT FK_STD_ID_ADD_ID FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESSES(ADDRESS_ID);

ALTER TABLE STUDENTS ADD CONSTRAINT FK_STD_ID_PRNT_ID FOREIGN KEY (PARENT_ID) REFERENCES PARENTS(PARENT_ID);

ALTER TABLE STUDENTS ADD CONSTRAINT FK_STD_SCH_ID FOREIGN KEY (SCHOOL_ID) REFERENCES SCHOOLS(SCHOOL_ID);

ALTER TABLE STUDENTS ADD CONSTRAINT CHK_STD_GENDER CHECK(GENDER IN ('M','F'));

INSERT INTO STUDENTS(STUDENT_ID, LASTNAME, FIRSTNAME, DATEOFBIRTH, SCHOOL_ID, ADDRESS_ID, PARENT_ID, GENDER, CONTACTNO)
VALUES(1, 'DOE', 'ROSS', TO_DATE('01/10/2013','MM/DD/YYYY'), 1, 4, 1, 'M', NULL);

INSERT INTO STUDENTS(STUDENT_ID, LASTNAME, FIRSTNAME, DATEOFBIRTH, SCHOOL_ID, ADDRESS_ID, PARENT_ID, GENDER, CONTACTNO)
VALUES(2, 'DOE', 'ALEX', TO_DATE('02/15/2013','MM/DD/YYYY'), 1, 5, 2, 'M', '111-222-3333');

INSERT INTO STUDENTS(STUDENT_ID, LASTNAME, FIRSTNAME, DATEOFBIRTH, SCHOOL_ID, ADDRESS_ID, PARENT_ID, GENDER, CONTACTNO)
VALUES(3, 'DOE', 'RITA', TO_DATE('06/10/2009','MM/DD/YYYY'), 2, 5, 2, 'F', '111-222-3333');

INSERT INTO STUDENTS(STUDENT_ID, LASTNAME, FIRSTNAME, DATEOFBIRTH, SCHOOL_ID, ADDRESS_ID, PARENT_ID, GENDER, CONTACTNO)
VALUES(4, 'WELLS', 'JOE', TO_DATE('08/13/2004','MM/DD/YYYY'), 3, 6, 3, 'F', '876-252-3333');

INSERT INTO STUDENTS(STUDENT_ID, LASTNAME, FIRSTNAME, DATEOFBIRTH, SCHOOL_ID, ADDRESS_ID, PARENT_ID, GENDER, CONTACTNO)
VALUES(5, 'WELLS', 'NIXON', TO_DATE('08/13/2004','MM/DD/YYYY'), 3, 6, 3, 'M', '876-252-3333');

COMMIT;

CREATE TABLE TEACHERS(
TEACHER_ID   NUMBER NOT NULL,
LASTNAME     VARCHAR2(50) NOT NULL,
FIRSTNAME    VARCHAR2(50),
ADDRESS_ID   NUMBER,
SCHOOL_ID    NUMBER NOT NULL,
GENDER       CHAR(1) NOT NULL,
CONTACTNO    VARCHAR2(20),
CONSTRAINT TEACHER_ID_PK PRIMARY KEY (TEACHER_ID)
);

ALTER TABLE TEACHERS ADD CONSTRAINT FK_TCHR_ADD_ID FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESSES(ADDRESS_ID);

ALTER TABLE TEACHERS ADD CONSTRAINT FK_TCHR_SCL_ID FOREIGN KEY (SCHOOL_ID) REFERENCES SCHOOLS(SCHOOL_ID);

ALTER TABLE TEACHERS ADD CONSTRAINT CHK_TCHR_GENDER CHECK(GENDER IN ('M','F'));

INSERT INTO TEACHERS (TEACHER_ID, LASTNAME, FIRSTNAME, SCHOOL_ID, ADDRESS_ID, GENDER, CONTACTNO)
VALUES(1, 'DOE', 'JOHN II', 1, 7, 'M', '334-567-9988');

INSERT INTO TEACHERS (TEACHER_ID, LASTNAME, FIRSTNAME, SCHOOL_ID, ADDRESS_ID, GENDER, CONTACTNO)
VALUES(2, 'WELLS', 'ROSE', 2, 6, 'F', '876-252-3333');

INSERT INTO TEACHERS (TEACHER_ID, LASTNAME, FIRSTNAME, SCHOOL_ID, ADDRESS_ID, GENDER, CONTACTNO)
VALUES(3, 'DOE', 'JANE', 2, 8, 'F', '876-222-3343');

INSERT INTO TEACHERS (TEACHER_ID, LASTNAME, FIRSTNAME, SCHOOL_ID, ADDRESS_ID, GENDER, CONTACTNO)
VALUES(4, 'DOE', 'CATHY', 3, 7, 'F', '334-567-9989');

COMMIT;

CREATE TABLE SUBJECTS(
SUBJECT_ID   NUMBER NOT NULL,
SUBJECTNAME  VARCHAR2(100) NOT NULL,
CONSTRAINT SUBJECT_ID_PK PRIMARY KEY (SUBJECT_ID)
);

INSERT INTO SUBJECTS (SUBJECT_ID, SUBJECTNAME)
VALUES(1, 'MATH');

INSERT INTO SUBJECTS (SUBJECT_ID, SUBJECTNAME)
VALUES(2, 'PHYSICS');

INSERT INTO SUBJECTS (SUBJECT_ID, SUBJECTNAME)
VALUES(3, 'CHEMISTRY');

INSERT INTO SUBJECTS (SUBJECT_ID, SUBJECTNAME)
VALUES(4, 'BOTONY');

INSERT INTO SUBJECTS (SUBJECT_ID, SUBJECTNAME)
VALUES(5, 'HISTORY');

COMMIT;

CREATE TABLE CLASSES(
CLASS_ID    NUMBER NOT NULL,
SUBJECT_ID  NUMBER NOT NULL,
TEACHER_ID  NUMBER,
SCHOOL_ID   NUMBER NOT NULL,
DAYOFWEEK   NUMBER,
CONSTRAINT CLASS_ID_PK PRIMARY KEY (CLASS_ID)
);

ALTER TABLE CLASSES ADD CONSTRAINT FK_CLS_SUBJ_ID FOREIGN KEY (SUBJECT_ID) REFERENCES SUBJECTS(SUBJECT_ID);

ALTER TABLE CLASSES ADD CONSTRAINT FK_CLS_TCHR_ID FOREIGN KEY (TEACHER_ID) REFERENCES TEACHERS(TEACHER_ID);

ALTER TABLE CLASSES ADD CONSTRAINT FK_CLS_SCH_ID FOREIGN KEY (SCHOOL_ID) REFERENCES SCHOOLS(SCHOOL_ID);

INSERT INTO CLASSES (CLASS_ID, SUBJECT_ID, TEACHER_ID, SCHOOL_ID, DAYOFWEEK)
VALUES(1, 1, 1, 1, 2);

INSERT INTO CLASSES (CLASS_ID, SUBJECT_ID, TEACHER_ID, SCHOOL_ID, DAYOFWEEK)
VALUES(2, 1, 1, 1, 3);

INSERT INTO CLASSES (CLASS_ID, SUBJECT_ID, TEACHER_ID, SCHOOL_ID, DAYOFWEEK)
VALUES(3, 1, 1, 1, 4); 

INSERT INTO CLASSES (CLASS_ID, SUBJECT_ID, TEACHER_ID, SCHOOL_ID, DAYOFWEEK)
VALUES(4, 1, 2, 2, 1);

INSERT INTO CLASSES (CLASS_ID, SUBJECT_ID, TEACHER_ID, SCHOOL_ID, DAYOFWEEK)
VALUES(5, 2, 3, 2, 4);

INSERT INTO CLASSES (CLASS_ID, SUBJECT_ID, TEACHER_ID, SCHOOL_ID, DAYOFWEEK)
VALUES(6, 3, 2, 2, 3);

INSERT INTO CLASSES (CLASS_ID, SUBJECT_ID, TEACHER_ID, SCHOOL_ID, DAYOFWEEK)
VALUES(7, 3, 4, 3, 1);

COMMIT;

CREATE TABLE ATTENDANCE(
CLASS_ID    NUMBER NOT NULL,
STUDENT_ID  NUMBER NOT NULL,
ATT_DATE    DATE NOT NULL,
STATUS      CHAR(1) DEFAULT 'N' NOT NULL,
CONSTRAINT ATT_PK PRIMARY KEY (CLASS_ID, STUDENT_ID, ATT_DATE)
);

ALTER TABLE ATTENDANCE ADD CONSTRAINT CHK_ATT_STATUS CHECK(STATUS IN ('P','N'));

ALTER TABLE ATTENDANCE ADD CONSTRAINT FK_ATT_CLS_ID FOREIGN KEY (CLASS_ID) REFERENCES CLASSES(CLASS_ID);

ALTER TABLE ATTENDANCE ADD CONSTRAINT FK_ATT_STD_ID FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID);

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(1, 1, '28-Nov-2017', 'P');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(1, 2, '28-Nov-2017', 'P');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(2, 1, '29-Nov-2017', 'P');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(2, 2, '29-Nov-2017', 'N');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(3, 1, '30-Nov-2017', 'N');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(3, 2, '30-Nov-2017', 'N');
--
INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(4, 3, '27-Nov-2017', 'P');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(5, 3, '30-Nov-2017', 'P');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE)
VALUES(6, 3, '29-Nov-2017');
--
INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(7, 4, '27-Nov-2017', 'P');

INSERT INTO ATTENDANCE (CLASS_ID, STUDENT_ID, ATT_DATE, STATUS)
VALUES(7, 5, '27-Nov-2017', 'P');


COMMIT;