-- 함수 연습 문제
-- 1. 직원명과 주민번호를 조회
--    단, 주민번호 9번째 자리부터 끝까지는 '*' 로 채움
--    EX) 771120-1******
SELECT EMP_NAME "직원명", 
       SUBSTR(EMP_NO, 1, 8) || '******' "주민번호"
  FROM EMPLOYEE;


-- 2. 직원명, 직급코드, 보너스포함연봉(원) 조회
--    단, 보너스포함연봉값에 절대 NULL이 나와서는 안됨
--    뿐만아니라 연봉은 \57,000,000원 형식으로 조회되게 함
SELECT EMP_NAME "직원명", 
       JOB_CODE "직급코드", 
       TO_CHAR((SALARY+(SALARY * NVL(BONUS, 0)))*12, 'L999,999,999') || '원' "보너스포함연봉(원)"
  FROM EMPLOYEE;

-- 3. 부서코드가 D5, D9인 직원들 중 2004년에 입사한 직원들의 
--    사번, 사원명, 부서코드, 입사일 조회
SELECT EMP_ID "사번", 
       EMP_NAME "사원명", 
       DEPT_CODE "부서코드", 
       HIRE_DATE "입사일"
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D5', 'D9')
   AND EXTRACT(YEAR FROM HIRE_DATE)=2004;

-- 아래처럼도 가능
SELECT EMP_ID "사번", 
       EMP_NAME "사원명", 
       DEPT_CODE "부서코드", 
       HIRE_DATE "입사일"
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D5', 'D9')
   AND SUBSTR(HIRE_DATE, 1, 2)='04';  -- DATE형식도 SUBSTR함수 사용가능하지롱


-- 4. 직원명, 입사일, 입사한 달의 근무일수 조회
--    단, 근무일수에 주말도 포함해서
SELECT EMP_NAME "직원명", 
       HIRE_DATE "입사일", 
       LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 "입사한 달의 근무일수"
  FROM EMPLOYEE;
-- 입사날도 근무일수에 포함하고 싶으면 +1, 아니면 안해도됨


-- 5. 직원명, 부서코드, 생년월일 조회
--    단, 생년월일은 XX년 XX월 XX일 형식으로 조회되게 함
--    꼭!!! 사번이 200, 201, 214가 아닌 사원들로만 조회하시오!!
--    (왜냐면... 200, 201, 214번 사원들의 주민번호쪽 생년월일 보면 날짜가 이상함....쏘리..)
SELECT EMP_NAME "직원명", 
       DEPT_CODE "부서코드",
       SUBSTR(EMP_NO, 1, 2) || '년 ' ||
       SUBSTR(EMP_NO, 3, 2) || '월 ' || 
       SUBSTR(EMP_NO, 5, 2) || '일 ' "생년월일"      -- 각각 SUBSTR로 추출한거 연결시켜주는 방법
  FROM EMPLOYEE
 WHERE EMP_ID NOT IN (200, 201, 214); -- 이 조건 없으면 제대로 조회안됨!!
 
-- 아래방법도 가능 (생년월일부분만 추출한 문자열을 DATE형식으로 변환후 다시 포맷지정해서 CHARACTER형식으로)
SELECT EMP_NAME "직원명", 
       DEPT_CODE "부서코드",
       TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'), 'YY"년" MM"월" DD"일"') "생년월일"
  FROM EMPLOYEE
 WHERE EMP_ID NOT IN (200, 201, 214); -- 이 조건 없으면 제대로 조회안됨!!


-- 6. 직원명, 부서코드, 부서명 조회
--    (부서명은 해당 부서코드가 D5일 경우 총무부, D6일 경우 기획부, D9일 경우 영업부로 조회되게끔)
--    단, 부서코드가 D5, D6, D9인 사원들만 조회하시오.
--    => CASE WHEN도 사용해보고, DECODE도 사용해보삼
SELECT EMP_NAME "직원명", 
       DEPT_CODE "부서코드",
       CASE
            WHEN DEPT_CODE = 'D5' THEN '총무부'
            WHEN DEPT_CODE = 'D6' THEN '기획부'
            WHEN DEPT_CODE = 'D9' THEN '영업부'
        END "부서명"
  FROM EMPLOYEE  
 WHERE DEPT_CODE IN('D5', 'D6', 'D9');

-- 아래는 DECODE 함수 방식
SELECT EMP_NAME "직원명", 
       DEPT_CODE "부서코드",
       DECODE(DEPT_CODE, 'D5', '총무부', 'D6', '기획부', 'D9', '영업부') "부서명"
  FROM EMPLOYEE  
 WHERE DEPT_CODE IN('D5', 'D6', 'D9');
