/*
    < GROUP BY 절 >
    그룹기준을 제시할 수 있는 구문 (해당 그룹기준별로 그룹을 묶어줄 수 있다.)
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

SELECT SUM(SALARY)
  FROM EMPLOYEE; --> 전체 사원들을 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)  -- 3
  FROM EMPLOYEE                -- 1
 GROUP BY DEPT_CODE;           -- 2
-- GROUP BY 로 DEPT_CODE를 그룹화 했기 때문에 SELECT에서 그룹함수와 함께 DEPT_CODE사용 가능


SELECT COUNT(*)
  FROM EMPLOYEE; --> 전체 사원 수

-- 각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

-- 각 부서별 총 급여합을 부서별 오름차순 정렬해서 조회
SELECT DEPT_CODE, SUM(SALARY) -- 4. SELECT절
  FROM EMPLOYEE               -- 1. FROM절
--WHERE                       -- 2. WHERE절
 GROUP BY DEPT_CODE           -- 3. GROUP BY 절
 ORDER BY DEPT_CODE ASC;      -- 5. ORDER BY 절


-- 각 직급별 총 급여합, 직급별 사원수, 직급별 보너스를 받는 사원수, 평균 급여(소수값 버리기), 최고급여, 최소급여
SELECT JOB_CODE, SUM(SALARY), COUNT(*), COUNT(BONUS),
       FLOOR(AVG(SALARY)), MAX(SALARY), MIN(SALARY)
  FROM EMPLOYEE
 GROUP By JOB_CODE
 ORDER BY 1;

-- 각 부서별 총사원수, 보너스받는사원수, 급여 합, 평균급여(반올림 처리), 최고급여, 최저급여
SELECT DEPT_CODE 부서,
       COUNT(*) 총사원수, 
       COUNT(BONUS) 보너스받는사원수, 
       SUM(SALARY) 급여합, 
       ROUND(AVG(SALARY), 0) 평균급여,
       MAX(SALARY) 최고급여,
       MIN(SALARY) 최저급여
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

-- * 여러 컬럼을 그룹기준으로 제시 가능
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), COUNT(*)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE, JOB_CODE
 ORDER BY 1; -- 첫번째 열을 기준으로 오름차순


---------------------------------------------------------------------------------------

/*
    < HAVING 절 >
    
    그룹에 대한 조건을 제시할 때 사용되는 구문(주로 그룹함수한 결과를 가지고 비교 수행)
    
    
*/

-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
  FROM EMPLOYEE
--WHERE AVG(SALARY) >= 3000000
 GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000
 ORDER BY 1;

-- 각 직급별 총급여합이 1000만원 이상인 직급, 급여합을 조회
SELECT JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000
 ORDER BY 1;

-- 각 부서별 보너스를 받는 사원이 없는 부서들만 조회
SELECT DEPT_CODE
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;


SELECT j.JOB_NAME, e.JOB_CODE, COUNT(*), SUM(SALARY)
  FROM EMPLOYEE e, JOB j
 WHERE e.JOB_CODE = j.JOB_CODE
 GROUP BY e.JOB_CODE, j.JOB_NAME
 ORDER BY 2;


--------------------------------------------------------------------------------
/*
    <실행 순서>
    5 : SELECT *|조회하고자하는컬럼명|산술연산식|함수식  [AS]  "별칭"
    1 :   FROM 조회하고자하는테이블명
    2 :  WHERE 조건식
    3 :  GROUP BY 그룹기준에 해당하는 컬럼명, 컬럼명, ...
    4 : HAVING 그룹함수식에 대한 조건식
    6 : ORDER BY 컬럼명|별칭|컬럼순번  [ASC|DESE] [NULLS LAST|NULLS FIRST];
*/
--------------------------------------------------------------------------------

/*
    < 집계 함수 > - 잘 안씀!!!! (자격증 딸때는 필요)
    
    그룹별 산출한 결과값의 중간집계(총합)를 계산해주는 함수
    
    ROLLUP, CUBE  (GROUP BY절에 사용 되는 함수)
*/
-- ROLLUP   각 직급별 급여 합 
SELECT JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(JOB_CODE)
 ORDER BY JOB_CODE;

-- CUBE
SELECT JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY CUBE(JOB_CODE)
 ORDER BY JOB_CODE;
-- 그룹기준으로 하나의 컬럼만 제시하게 되면 ROOLUP이든 CUBE든 별 차이 없음
-- 마지막 행에 전체 총급여합까지 같이 나옴


----- ROLLUP과 CUBE의 차이점 (그룹기준이 적어도 두개이상의 컬럼이여야됨) -----

-- 부서코드도 같고 직급코드도 같은 사원들을 그룹지어서
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE, JOB_CODE
 ORDER BY DEPT_CODE; -- >13개의 그룹

-- ROLLUP(컬럼1, 컬럼2) => 컬럼1을 가지고 다시 중간집계를 내주는 함수
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
 ORDER BY DEPT_CODE;

-- CUBE(컬럼1, 컬럼2) => 컬럼1을 가지고 중간집계내고, 컬럼2를 가지고도 중간집계를 냄
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), COUNT(*)
  FROM EMPLOYEE
 GROUP BY CUBE(DEPT_CODE, JOB_CODE)
 ORDER BY 2;
 
 
--------------------------------------------------------------------------------
 
 
 /*
    < 집합 연산자(SET OPERATION) >
    
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION     : 합집합 (두 쿼리문 수행한 결과값을 더한 후 중복되는 부분 한번 뺀거) = OR
    - INTERSECT : 교집합 (두 쿼리문 수행한 결과값에 중복된 결과값) = AND
    - UNION ALL : 합집합 결과값 + 교집합 결과값(UNION + INTERSECT) (두 쿼리문 수행한 결과값을 무조건 더함) => 중복된 값이 두번 들어갈 수 있음
    - MINUS     : 차집합 (선행 쿼리문 결과값 - 후행 쿼리문 결과값)
 */
 
-- 1. UNION
-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회(사번, 이름, 부서코드, 급여)
-- 부서코드가 5D인 사원들만 조회
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       SALARY 급여
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5';

-- 급여가 300만원 초과인 사람들만 조회
SELECT EMP_ID 사원번호,
       EMP_NAME 사원이름,
       DEPT_CODE 부서코드,
       SALARY 급여
  FROM EMPLOYEE
 WHERE SALARY > 3000000;

-- UNION
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       SALARY 급여
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'      --> 6행
 UNION                     --> UNION을 하면 중복값 2개 제거하여 12행
SELECT EMP_ID 사원번호,
       EMP_NAME 사원이름,
       DEPT_CODE 부서코드,
       SALARY 급여
  FROM EMPLOYEE
 WHERE SALARY > 3000000;  --> 8행

-- 위의 쿼리문 대신 아래처럼 WHERE 절을 통해서도 해결가능
SELECT EMP_ID 사원번호,
       EMP_NAME 사원이름,
       DEPT_CODE 부서코드,
       SALARY 급여
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5' OR SALARY > 3000000;

---------------------------------------------------------------------------

-- 각 부서별 급여합 (GROUP BY절 이용)
SELECT SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

-- 각 부서별 급여합 (UNION)
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE='D1'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE='D2'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE='D9';


---------------------------------------------------------------------------

-- 2. UNION ALL : 여러개의 쿼리 결과를 무조건 더하는 연산자 (중복값이 여러개 들어갈 수 있음) -- 컬럼의 수가 같아야 한다
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       BONUS "보너스 또는 급여"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'      --> 6행
 UNION ALL                 --> UNION ALL을 하면 중복값 2개 포함 14행
SELECT EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;  --> 8행


-- 3. INTERSECT (교집합)
-- 부서코드가 D5이면서 그리고 급여까지도 300만원 초과인 사원
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       BONUS "보너스 또는 급여"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'
INTERSECT
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       BONUS "보너스 또는 급여"
  FROM EMPLOYEE
 WHERE SALARY > 3000000;

-- AND로도 가능 (이미 자바에서 많이 했기때문에 AND OR이  UNION보다 편함)
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       BONUS "보너스 또는 급여"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5' AND SALARY > 3000000;


-- 4. MINUS
-- 부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원을 제외해서 조회
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       SALARY "급여"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'
MINUS
SELECT EMP_ID, 
       EMP_NAME, 
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;

-- 아래와같이 바꿀 수 있음
SELECT EMP_ID 사원번호, 
       EMP_NAME 사원이름, 
       DEPT_CODE 부서코드, 
       SALARY 급여
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5' AND SALARY <= 3000000;
