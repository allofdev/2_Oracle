-- DDL

-- 1. 계열 정보를 저장할 카테고리 테이블을 만들려고 한다. 다으과 같은 테이블을 작성하시오.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_IN CHAR(1) DEFAULT 'Y'
);
SELECT * FROM TB_CATEGORY;

-- 2. 과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR(10)
);

-- 3. TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY를 생성하시오.
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME); 

-- 4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL값이 들어가지 않도록 속성을 변경하시오.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

-- 5. 컬럼명 NO -> 크기 10으로 변경
--    컬럼명 NAME -> 크기 20으로 변경
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CLASS_TYPE 
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

-- 6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_를 제외한 테이블 이름이 앞에 붙은 형태로 변경한다.
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

-- 7. TB_CATEGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007292 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007293 TO PK_CLASS_TYPE_NO;

-- 8. INSERT
INSERT INTO TB_CATEGORY VALUES('공학', 'Y');
INSERT INTO TB_CATEGORY VALUES('자연과학', 'Y');
INSERT INTO TB_CATEGORY VALUES('의학', 'Y');
INSERT INTO TB_CATEGORY VALUES('예체능', 'Y');
INSERT INTO TB_CATEGORY VALUES('인문사회', 'Y');

COMMIT;

-- 9.
ALTER TABLE TB_DEPARTMENT 
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

-- 10. 춘 기술대학교 학생들의 VIEW
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
   FROM TB_STUDENT;

-- 11. 
CREATE OR REPLACE VIEW VW_지도면담
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
   FROM TB_STUDENT
   JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
   LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
   ORDER BY 2;

-- 12.
CREATE OR REPLACE VIEW VW_학과별학생수
AS SELECT DEPARTMENT_NAME, COUNT(*) "STUDENT_COUNT"
          FROM TB_STUDENT
          JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
          GROUP BY DEPARTMENT_NAME;


-- 13. 학생일반정보 VIEW에서 A213046 학생의 이름을 내이름으로 변경
UPDATE VW_학생일반정보
SET STUDENT_NAME = '김남규'
WHERE STUDENT_NO = 'A213046';

SELECT * FROM VW_학생일반정보;

-- 14. 13번에서와 같이 VIEW를 통해서 테이터가 변경될 수 있는 상황을 막으려면 VIEW를 어떻게 생성해야하는지 작성하시오.
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
   FROM TB_STUDENT
WITH READ ONLY;


