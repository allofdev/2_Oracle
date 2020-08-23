
-- CREATE TABLE 할 수 있는 권한이 없어서 문제 발생
-- 3_1. CREATE TABLE 권한 부여 받음
-- 3_2. TABLESPACE 할당 받음
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 계정이 소유하고 있는 테이블들은 바로 조작 가능
SELECT * FROM TEST;
INSERT INTO TEST VALUES(10);

-- 뷰 객체를 생성할 수 있는 CREATE VIEW 권한이 없기때문에 
-- 4. CREATE VIEW 권한 부여받음
CREATE VIEW V_TEST
AS SELECT * FROM TEST;

--------------------------------------------
-- 다른 계정의 테이블에 접근할 수 있는 권한이 없기때문에 발생한 문제
-- 5. KH.EMPLOYEE에 SELECT 권한 부여받음
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.DEPARTMENT;

-- 6. KH.DEPARTMENT에 INSERT 권한 부여받음
INSERT INTO KH.DEPARTMENT 
VALUES('D0', '회계부', 'L2');

ROLLBACK;








