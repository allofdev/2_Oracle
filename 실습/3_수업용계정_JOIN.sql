

-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
SELECT * FROM EMPLOYEE;   -- JOB_CODE  DEPT_CODE
SELECT * FROM JOB;        -- JOB_CODE
SELECT * FROM DEPARTMENT; --           DEPT_ID  LOCATION_ID
SELECT * FROM LOCATION;   --                    LOCAL_CODE

-- >> 오라클 구문
SELECT E.EMP_ID 사번, 
       E.EMP_NAME 사원명, 
       J.JOB_CODE 직급명, 
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명,
       E.SALARY 급여
  FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND J.JOB_NAME = '대리'
   AND L.LOCAL_NAME LIKE 'ASIA_';

-- >> ANSI 구문
SELECT E.EMP_ID 사번, 
       E.EMP_NAME 사원명, 
       JOB_CODE 직급명, 
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명,
       E.SALARY 급여
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE J.JOB_NAME = '대리' AND L.LOCAL_NAME LIKE 'ASIA%';

------------------------------------------------------------

-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오
SELECT * FROM EMPLOYEE;   -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;        --            JOB_CODE

-- >> 오라클 구문
SELECT EMP_NAME 사원명,
       EMP_NO 주민번호,
       DEPT_TITLE 부서명,
       JOB_NAME 직급명
  FROM EMPLOYEE E, DEPARTMENT D, JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND E.JOB_CODE = J.JOB_CODE
   AND E.EMP_NO LIKE '7%'
   AND SUBSTR(E.EMP_NO, 8, 1) = '2'
   AND E.EMP_NAME LIKE '전%'; 

-- >> ANSI 구문
SELECT EMP_NAME 사원명,
       EMP_NO 주민번호,
       DEPT_TITLE 부서명,
       JOB_NAME 직급명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J USING (JOB_CODE)
 WHERE E.EMP_NO LIKE '7%'
   AND SUBSTR(E.EMP_NO, 8 , 1) = '2'
   AND E.EMP_NAME LIKE '전%';

------------------------------------------------------------

-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오
SELECT * FROM EMPLOYEE; -- JOB_CODE
SELECT * FROM JOB;      -- JOB_CODE

-- >> 오라클 구문
SELECT E.EMP_ID 사번, 
       E.EMP_NAME 사원명, 
       J.JOB_NAME 직급명
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND E.EMP_NAME LIKE '%형%';

-- >> ANSI 구문
SELECT E.EMP_ID 사번, 
       E.EMP_NAME 사원명, 
       J.JOB_NAME 직급명
  FROM EMPLOYEE E
  JOIN JOB J USING(JOB_CODE)
 WHERE E.EMP_NAME LIKE '%형%';

------------------------------------------------------------

-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
SELECT * FROM EMPLOYEE;   -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB ;       --            JOB_CODE

-- >> 오라클 구문
SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       E.DEPT_CODE 부서코드,
       D.DEPT_TITLE 부서명
  FROM EMPLOYEE E, DEPARTMENT D, JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND E.JOB_CODE = J.JOB_CODE
   AND D.DEPT_TITLE LIKE '해외영업%부';

-- >> ANSI 구문
SELECT E.EMP_NAME 사원명,
       J.JOB_NAME 직급명,
       E.DEPT_CODE 부서코드,
       D.DEPT_TITLE 부서명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J USING (JOB_CODE)
 WHERE D.DEPT_TITLE LIKE '해외영업%부';

------------------------------------------------------------

-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
SELECT * FROM EMPLOYEE;    -- DEPT_CODE
SELECT * FROM DEPARTMENT;  -- DEPT_ID    LOCATION_ID
SELECT * FROM LOCATION;    --            LOCAL_CODE

-- >> 오라클 구문
SELECT E.EMP_NAME 사원명,
       E.BONUS 보너스,
       E.SALARY * 12  연봉,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명
  FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND E.BONUS IS NOT NULL;

-- >> ANSI 구문
SELECT E.EMP_NAME 사원명,
       E.BONUS 보너스,
       E.SALARY * 12  연봉,
       D.DEPT_TITLE 부서명,
       L.LOCAL_NAME 근무지역명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE E.BONUS IS NOT NULL;

------------------------------------------------------------
-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오

-- >> 오라클 구문
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND E.DEPT_CODE IS NOT NULL;

-- >> ANSI 구문
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE E.DEPT_CODE IS NOT NULL;

------------------------------------------------------------

-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
SELECT * FROM EMPLOYEE;   -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID    LOCATION_ID
SELECT * FROM LOCATION;   --            LOCAL_CODE   NATIONAL_CODE
SELECT * FROM NATIONAL;   --                         NATIONAL_CODE

-- >> 오라클 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
  FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND (N.NATIONAL_NAME = '한국' OR N.NATIONAL_NAME = '일본');

-- >> ANSI 구문
SELECT E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATIONAL N USING (NATIONAL_CODE)
 WHERE N.NATIONAL_NAME IN ('한국', '일본');

------------------------------------------------------------

-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오

-- >> 오라클 구문
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND BONUS IS NULL
   AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');

-- >> ANSI구문
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
 WHERE BONUS IS NULL 
   AND JOB_CODE IN ('J4', 'J7');
   
------------------------------------------------------------

-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오.
SELECT * FROM EMPLOYEE;  -- JOB_CODE  SALARY
SELECT * FROM JOB;       -- JOB_CODE  
SELECT * FROM SAL_GRADE; --           MIN_SAL/MAX_SEL

-- >> 오라클 구문 (DECODE 사용해보기)
SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       J.JOB_CODE 직급명,
       S.SAL_LEVEL 급여등급,
       DECODE(SAL_LEVEL, 'S1', '고급', 'S2', '고급', 'S3', '중급', 
                         'S4', '중급', 'S5', '초급', 'S6', '초급') 구분
  FROM EMPLOYEE E, JOB J, SAL_GRADE S
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL); 

-- >> ANSI 구문 (CASE 사용해보기)
SELECT E.EMP_ID 사번,
       E.EMP_NAME 사원명,
       JOB_CODE 직급명,
       S.SAL_LEVEL 급여등급,
       CASE WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '고급'
            WHEN S.SAL_LEVEL IN ('S3', 'S4') THEN '중급'
            WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '초급'
       END 구분
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

------------------------------------------------------------

-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오

-- >> 오라클 구문
SELECT D.DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- >> ANSI 구문
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

------------------------------------------------------------
-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.

-- >> 오라클 구문
SELECT DEPT_TITLE ,FLOOR(AVG(SALARY))
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+)
GROUP BY DEPT_TITLE;



-- >> ANSI 구문
SELECT DEPT_TITLE, ROUND(AVG(SALARY), 0)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;













