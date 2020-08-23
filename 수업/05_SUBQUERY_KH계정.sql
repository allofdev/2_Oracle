

/*
    * SUBQUERY (서브쿼리)
    - 하나의 SQL문(INSERT, UPDATE, CREATE, SELECT ...) 안에 포함된 또다른 SELECT문
    - 메인 SQL문을 위해 보조 역할을 하는 쿼리문
    
*/

-- 간단 서브쿠리 예시1
-- 노옹철 사원과 같은 부서인 사원들의 이름 조회

-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME = '노옹철'; --> D9인걸 알아냄!

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';

--> 위의 2단계를 하나의 쿼리로!!
SELECT EMP_NAME               
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT DEPT_CODE 
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');
-- 밖에있는게 MAINQUERY 안쪽에있는게 SUBQUERY
                -- 단일행 SUBQUERY(SUBQUERY만 드래그해서 실행시켜보면 알 수 있음)
                

-- 간단서브쿼리예시2
-- 전 직원의 평균급여보다 더 많은 급여를 받고 있는 사원들의 사번, 이름, 직급코드, 급여

-- 1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
  FROM EMPLOYEE; --> 대략 30479663원 정도구나!!

-- 2) 급여가 3047663원 이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY >= 3047663;

--> 위의 2단계를 하나로 합치자!!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY >= (SELECT AVG(SALARY)
            FROM EMPLOYEE);
                -- 단일행 SUBQUERY(SUBQUERY만 드래그해서 실행시켜보면 알 수 있음)
-------------------------------------------------------------------------------

/*
    * 서브쿼리구문
    서브쿼리를 수행한 결과값이 몇행 몇열이냐에 따라서 분류됨
    
    - 단일행 [단일열] 서브쿼리 : 서브쿼리의 조회 결과값이 갯수가 오로지 1개일 때
    - 다중행 [단일열] 서브쿼리 : 서브쿼리의 조회 결과값의 행수가 여러행일 때
    - [단일행] 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 한 행이지만 컬럼이 여러개일 때
    - 다중행  다중열  서브쿼리 : 서브쿼리의 조회 결과값이 여러행 여러컬럼일 경우
    
    > 서브쿼리의 결과값이 몇행 몇열이냐에 따라 사용가능한 연산자가 달라짐
*/

/*
    1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
       서브쿼리의 조회 결과값 갯수가 오로지 1개일 때
       
       일반 연산자 사용 가능
       = != <= > ..
*/

-- 전 직원의 평균 급여보다 더 적게 받는 직원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
 WHERE SALARY < (SELECT AVG(SALARY) --> 결과값 1행 1열
                 FROM EMPLOYEE);

-- 최저급여를 받는 사원의 사번, 이름, 직급코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE SALARY = (SELECT MIN(SALARY) --> 결과값 1행 1열
                 FROM EMPLOYEE);

-- 노옹철 사원의 급여보다 더 많이 받는 사원들의 
-- 사번, 이름, 부서코드, 직급코드, 급여, 부서명, 직급명 을 조회
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.JOB_CODE, E.SALARY, D.DEPT_TITLE, J.JOB_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J USING(JOB_CODE)
 WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
    
-- 전지연과 같은 부서인 사원들의 사번, 사원명, 전화번호, 부서명 조회 (단, 전지연은 제외)
-- >> 오라클 구문
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND E.DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                      WHERE EMP_NAME = '전지연')
   AND EMP_NAME != '전지연';

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
 WHERE E.DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                      WHERE EMP_NAME = '전지연')
   AND EMP_NAME != '전지연';

-- 부서별 급여합이 가장 큰 부서만을 조회 부서코드, 급여합 조회
-- 1)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 각 부서별 급여합 중 가장 큰 값
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; --> 1770만

-- 답
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                     FROM EMPLOYEE
                     GROUP BY DEPT_CODE);

-------------------------------------------------------------------------------

/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
       서브쿼리의 조회 결과값이 여러행일 때
       
       - IN 서브쿼리 / NOT IN 서브쿼리 : 여러개의 결과값 중에서 한개라도 일치하는 값이 있으면 / 없다면 이라는 의미
       
       - > ANY 서브쿼리 : 여러개의 결과값 중에서 "하나라도" 클 경우
                         여러개의 결과값 중엣 가장 작은값 보다 클 경우
       - < ANY 서브쿼리 : 여러개의 결과값 중에서 "하나라도" 작을 경우
                         여러개의 결과값 중에서 가장 큰 값 보다 작을 경우
    
       - > ALL 서브쿼리 : 여러개의 결과값의 "모든" 값보다 클 경우
                         여러개의 결과값 중에서 가장 큰 값 보다 클 경우
       - < ALL 서브쿼리 : 여러개의 결과값의 "모든" 값보다 작을 경우
                         여러개의 결과값 중에서 가장 작은 값 보다 작을 경우



*/

-- 부서코드 D5 또는 D6 또는 D7인 사원들을 조회
SELECT *
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D7';
WHERE DEPT_CODE IN ('D5', 'D6', 'D7');

-- 1) 각 부서별 최고급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; --> 2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000

-- 2) 위의 급여를 받는 사원들 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);

-->> 합쳐서 하나의 쿼리문!!
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY) --> 결과값 여러행 1열 이기때문에 IN사용
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);

-- 사원 => 대리 => 과장 => 차장 => 부장 ...
-- 대리 직급임에도 불구하고 과장 직급들의 최소급여보다 많이 받는 직원 조회 (사번, 이름, 직급, 급여)

-->> 과장 직급의 급여 조회
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';     -- 2200000, 2500000, 3760000

-->> 직급이 대리이면서 급여값이 위의 목록들 값 중에 하나라도 큰 사원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리' 
AND SALARY > ANY (2200000, 2500000, 3760000);
--        OR과 같음
--AND (SALARY > 2200000 OR SALARY > 2500000 OR SALARY > 3760000);

-->> 다중행 서브쿼리
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리' 
AND SALARY > ANY (SELECT SALARY               --> 결과값 여러행
                  FROM EMPLOYEE
                  JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '과장');

--> 단일행 서브쿼리로도 가능
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리' 
AND SALARY > (SELECT MIN(SALARY)
              FROM EMPLOYEE
              JOIN JOB USING(JOB_CODE)
              WHERE JOB_NAME = '과장');

-- 과장직급임에도 불구하고 차장 직급의 최대 급여보다 더 많이 받는 사원 (사번, 사원명, 직급명, 급여)

-->> 차장 직급의 급여 조회
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장'; --> 2800000, 1550000, 2490000, 2480000

-->> 과장 직급이면서 급여값이 위의 목록들 모든 값보다 큰 직원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
  AND SALARY > ALL (2800000, 1550000, 2490000, 2480000);
--        AND 와 같음
--AND SALARY > 2800000 AND SALARY > 1550000 AND SALARY > 2490000 AND SALARY > 2480000;

-->> 다중 쿼리 사용
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
  AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_CODE)
                    WHERE JOB_NAME = '차장');

-->> 단일행 서브쿼리로도 가능
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
  AND SALARY > (SELECT MAX(SALARY) --> 결과값 1행
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '차장');
                
-------------------------------------------------------------------------------

/*
    3. [단일행] 다중열 서브쿼리
        조회결과 값은 한 행이지만 나열된 컬럼수가 여러개일 때
*/

-- 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'; --> D5 / J5

-->> 부서코드가 D5이면서 직급코드가 J5인 사원들 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
  AND JOB_CODE = 'J5';

--> 하나의 쿼리문 (단일행 서브쿼리) 1
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '하이유')
   AND JOB_CODE = (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '하이유');
                   
--> 하나의 쿼리문 (다중열 서브쿼리) 2
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE  --> 결과값 1행 여러열
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '하이유');

-- 박나라 사원과 직급코드가 일치하면서 같은 사수를 가지고 있는 사원 조회(사번, 이름, 직급코드, 사수사번)
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID   --> 결과값 1행 여러열
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '박나라');

-------------------------------------------------------------------------------

/*
    4. 다중행 다중열 서브쿼리
       서브쿼리 조회 결과값이 여러행 여러열일 경우
*/

-- 1) 각 직급별 최소 급여를 받는 사원 (사번, 이름, 직급코드, 급여)

-->> 각 직급 별로 최소 급여 조회
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE; --> (J2,3700000  J7,1380000  J3,3400000 ...)

-->> 다중행 다중열 서브쿼리
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) = ('J2', 3700000)
   OR (JOB_CODE, SALARY) = ('J7', 1380000)
   OR (JOB_CODE, SALARY) = ('J3', 3400000)
   ...
   이와같은 이 OR(또는)은 IN 사용
*/

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) --> 결과값 다중행 다중열
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);

-- 각 부서별 최고급여를 받는 사원들 사번, 사원명, 부서코드, 부서명, 지역명 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE);

-------------------------------------------------------------------------------

/*
    5. 인라인 뷰 (INLINE_VIEW)
       FROM 절에 서브퀄를 제시하는 것을 INLINE-VIEW라고 함
       
       서브쿼리를 수행한 결과를 테이블 대신에 사용함!!
*/

-- 보너스포함 연봉이 3000만원 이상인 사운들의 사번, 이름, 보너스포함연봉, 부서코드 조회
-- 인라인 뷰를 사용하지 않고 기본적인 문장으로 한경우
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 보너스포함연봉, DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY * NVL(BONUS, 0)) * 12 >= 30000000;

-- 인라인 뷰
SELECT EMP_NAME, 보너스포함연봉
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 보너스포함연봉, DEPT_CODE
      FROM EMPLOYEE)
WHERE 보너스포함연봉 >= 30000000;

-->> 인라인 뷰를 주로 사용하는 예
-- * TOP_N 분석

-- 전 직원 중 급여가 가장 높은 상위 5명
-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼
SELECT  ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- FROM => SELECT / 급여순 정렬되기전에 ROWNUM부여됨! => ORDER BY
-- 순서가 뒤죽박죽

--> ORDER BY한 결과값을 가지고 ROWNUM부여해야됨!!
SELECT ROWNUM 순위, E.*  -- ROWNUM과 있을때는 *호출 불가능 -> BUT, 테이블에 별칭을 부여하면 가능해짐
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5; -- 상위 10개 조회

-- 각 부서별 평균급여가 높은 3개의 부서의 부서코드, 평균 급여 조회
SELECT ROWNUM 순번, DEPT_CODE, ROUND(평균급여)
FROM(SELECT DEPT_CODE, AVG(SALARY) 평균급여
     FROM EMPLOYEE
     GROUP BY DEPT_CODE
     ORDER BY 2 DESC) E
WHERE ROWNUM <= 3;

-------------------------------------------------------------------------------

/*
    6. 순위 매기는 함수
    RANK() OVER(정렬기준)    /    DENSE_RANK() OVER(정렬기준)
    
  - RNAK() OVER(정렬기준) : EX) 공동 1위가 2명이면 그 다음 순위는 3위
  - DENSE_RANK() OVER(정렬기준) : EX)  공동 1위가 3명이더라도 그 다음 순위는 2위
    
  * SELECT절에서만 기입 가능
*/

--사원별 급여가 높은 순서대로 순위를 매겨서 사원명, 급여, 순위 조회
--RANK() OVER(정렬기준)
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;
--> 공동 19위 2명, 그 뒤의 순위 21위

--DANSE_RANK() OVER(정렬기준)
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;
--> 공동 19위 2명, 그 두으 순위 20위

-- 상위 5명만 조회
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
--WHERE 순위 <=5;  
--> 오류! WHERE - SELECT순이기 때문에 "순위"라는 별칭사용불가 
WHERE RANK() OVER(ORDER BY SALARY DESC) <=5;
--> 오류! 순위매기는 함수는 SELECT절에만 사용 가능!!

--> 결국 인라인뷰로 조회해야됨!!
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위
      FROM EMPLOYEE)
WHERE 순위 <= 5;


















