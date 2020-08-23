/*
    < DML : DATA MANIPULATION LANGUAGE >
    데이터 조작 언어
    
    테이블에 값을 삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
    
*/

/*
    1. INSERT 
       테이블에 새로운 행을 추가하는 구문
     
    1) 테이블에 모든 컬럼에 대한 값을 한 행 INSERT하고자 할 때   
       INSERT INTO 테이블명 VALUES(값, 값, 값, 값, ...);
       
       주의할점 : 테이블에 존재하는 컬럼 수 만큼 값 제시 / 컬럼 순번 지켜서 값 나열
*/

INSERT INTO EMPLOYEE 
VALUES(900, '장채현', '980914-2112457', 'jang_ch@kh.or.kr',
       NULL, 'D1', 'J7', 2000000, NULL, 200, SYSDATE, NULL, DEFAULT);
       
SELECT * 
FROM EMPLOYEE
WHERE EMP_ID = 900;

/*
    2) 테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
       
       INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값, 값, 값);
       
       그래도 한 행 단위로 추가되기 때문에 지정안한 컬럼은 기본적으로 NULL값이 들어감 
       => 주의할점 : NOT NULL제약조건이 걸려있는 컬럼은 반드시 지정해서 직접 값 제시해야됨
       
       (단, 기본값(DEFAULT)이 지정되어있는 컬럼일 경우 NULL값이 아닌 DEFAULT값이 담김)
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(901, '강람보', '800918-2145344', 'D2', 'J7', SYSDATE);

SELECT * 
FROM EMPLOYEE
WHERE EMP_NAME = '강람보';

-----------------------------------------------------------------------------

/*
    3) 서브쿼리로 조회한 결과값을 통째로 INSERT하는 방법
    
       INSERT INTO 테이블명 (서브쿼리);
       
*/

-- 새로운 테이블 세팅
CREATE TABLE EMP_01(
    EMP_ID NUMBER, 
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(30)
);

SELECT * FROM EMP_01;

-- 전 사원의 사번, 사원명, 부서명 조회
-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID));
    
SELECT * FROM EMP_01;

----------------------------------------------------------------

/*
    2. INSERT ALL 
       두개 이상의 테이블에 각각 INSERT할 때 사용
       단, 그 때 사용되는 서브쿼리가 동일한 경우 
*/

-- 테이블 세팅
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1=0;

SELECT * FROM EMP_DEPT;     -- EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
SELECT * FROM EMP_MANAGER;  -- EMP_ID, EMP_NAME, MANAGER_ID


-- 부서코드 D1인 사원들의 사번, 사원명, 부서코드, 입사일, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    1) 
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명, 컬럼명,..)
        서브쿼리;
*/
SELECT * FROM EMP_DEPT;     -- EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
SELECT * FROM EMP_MANAGER;  -- EMP_ID, EMP_NAME, MANAGER_ID

INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1'; 
    

-- * 조건을 사용해서도 각 테이블에 INSERT 가능 

-- 2000년도 이전 입사한 입사자들을 보관할 테이블
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;

-- 2000년도 이후 입사한 입사자들을 보관할 테이블   
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;
   
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
    2) 
    INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블명1 VALUES(컬럼명, 컬럼명, 컬럼명)
    WHEN 조건2 THEN
        INTO 테이블명2 VALUES(컬럼명, 컬럼명, 컬럼명)
    서브쿼리;
*/

INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-------------------------------------------------------------------

/*
    3. UPDATE 
       테이블에 기록되어있는 데이터를 수정하는 구문
       
       [표현법]
       UPDATE 테이블명 
       SET 컬럼명 = 바꿀값,
           컬럼명 = 바꿀값, ... --> 여러개의 컬럼값 동시변경 가능(,로 나열!! AND아님!!)
       [WHERE 조건식]; --> 생략하면 전체 모든 행의 데이터가 변경되버림!!
*/

-- 복사본 테이블 만든 후 작업
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_ID가 D9인 부서명이 '전략기획팀'으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_COPY;

ROLLBACK;

-- 복사본 떠서
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;


SELECT * FROM EMP_SALARY;

-- 노옹철사원의 급여를 1000000원으로 변경
UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '노옹철';

SELECT * FROM EMP_SALARY;

-- 선동일 사원의 급여를 700만원으로, 보너스를 0.2로 변경
UPDATE EMP_SALARY
   SET SALARY = 7000000
     , BONUS = 0.2
 WHERE EMP_NAME = '선동일';
 
-- 모든 사원의 급여를 기존의 급여에 10프로 인상한 금액(기존급여 * 1.1)으로 변경  
UPDATE EMP_SALARY
   SET SALARY = SALARY * 1.1;

SELECT * FROM EMP_SALARY;

-- * UPDATE 시에 서브쿼리 사용 가능
--   즉, 서브쿼리를 수행한 결과값으로 변경하겠다
/*
    UPDATE 테이블명
       SET 컬럼명 = (서브쿼리)
    [WHERE 조건식];
*/

-- 방명수 사원의 급여와 보너스값을 유재식 사원의 급여와 보너스값으로 변경
UPDATE EMP_SALARY
   SET SALARY = (
                 SELECT SALARY
                   FROM EMP_SALARY
                  WHERE EMP_NAME = '유재식'
                 )
      , BONUS = (
                 SELECT BONUS
                   FROM EMP_SALARY
                  WHERE EMP_NAME = '유재식'
                )
 WHERE EMP_NAME = '방명수';
 
UPDATE EMP_SALARY
   SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMP_SALARY
                           WHERE EMP_NAME = '유재식')
 WHERE EMP_NAME = '방명수';
 

SELECT * FROM EMP_SALARY;


-- 노옹철, 전형돈, 정중하, 하동운 사원들의 급여와 보너스값 유재식 사원의 급여와 보너스값으로 변경
UPDATE EMP_SALARY
   SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMP_SALARY
                           WHERE EMP_NAME = '유재식')
 WHERE EMP_NAME IN ('노옹철', '전형돈', '정중하', '하동운');
 
SELECT * FROM EMP_SALARY;


-- ASIA 지역에서 근무하는 사원들의 보너스를 0.3으로 변경

-- ASIA 지역에 근무하는 사원들의 사번 조회
SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) --> LOCATION_ID
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
   SET BONUS = 0.3
 WHERE EMP_ID IN (SELECT EMP_ID
                    FROM EMP_SALARY
                    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) --> LOCATION_ID
                    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                   WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT * FROM EMP_SALARY;

----------------------------------------------------------

-- UPDATE 시 변경할 값은 해당 컬럼에 대한 제약조건에 위배되면 안됨!
-- 뿐만아니라 DATA TYPE도 신경써서 변경해야됨!!

-- 선동일 사원의 주민번호값을 NULL 로 변경
UPDATE EMPLOYEE
   SET EMP_NO = NULL
 WHERE EMP_NAME = '선동일';

-- 노옹철 사원의 부서코드를 D0으로 변경
UPDATE EMPLOYEE
   SET DEPT_CODE = 'D0'
 WHERE EMP_NAME = '노옹철';
 
-- 심봉선 사원의 전화번호를 '010-1111-2222'로 변경   PHONE (VARCHAR2(12))
UPDATE EMPLOYEE
   SET PHONE = '010-1111-2222'
 WHERE EMP_NAME = '심봉선';
 
-------------------------------------------------------------------------

COMMIT;

/*
    4. DELETE 
       테이블에 기록된 데이터를 삭제하는 구문 (행 자체가 삭제됨)
       
       [표현법]
       DELETE FROM 테이블명
       [WHERE 조건];  --> WHERE 절 제시 안하면 전체 행 다 삭제됨!!
       
*/

-- 장채현 사원의 데이터 지우기
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '장채현';

SELECT * FROM EMPLOYEE;
ROLLBACK; --> 마지막 커밋시점으로 원복

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '강람보';

COMMIT;

-- DEPARTMENT 로부터 D1인 부서 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1'; --> D1의 값을 가져다 쓰는 자식데이터가 있기 때문에 삭제 안됨!! (삭제 제한)

-- D3인 부서 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;


-- * TRUNCATE(DDL) : 테이블의 전체 행을 삭제할 때 사용되는 구문 (DELETE보다 수행속도가 빠름)
--   [표현법] TRUNCATE TABLE 테이블명; -- 별도의 조건 제시 불가

--  주의할점 : DELETE는 ROLLBACK이 가능하지만 TRUNCATE는 ROLLBACK이 불가!!
SELECT * FROM EMP_SALARY;
DELETE FROM EMP_SALARY;
ROLLBACK;

TRUNCATE TABLE EMP_SALARY;





































