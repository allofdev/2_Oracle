-- 한줄 주석

/*
    < SELECT >
    데이터를 조회할 때 사용되는 명령어 (DML, DQL) -- 사람들마다 DML 또는 DQL이라고 말함
    
    >> RESULT SET : SELECT문을 통해 조회된 결과물
    
    [표현법]
    SELECT 초회하고자하는컬럼, 컬럼, 컬럼...
    FORM 테이블명;
*/

-- EMPLOYEE 테이블로부터 전체 사원의 모든 컬럼 (*) 정보 조회
SELECT *
FROM EMPLOYEE;

-- JOB 테이블로부터 전체 직급의 전체 컬럼 조회
SELECT * 
FROM JOB;

-- DEPARTMENT 테이블로부터 전체 부서의 전체 컬럼 조회
SELECT * 
FROM DEPARTMENT;

-- EMPLOYEE 테이블로부터 전체 사원들의 사번, 이름, 급여만을 조회
-- SELECT 절에 조회하고자 하는 컬럼명들 나열

SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE;

-- DEPARTMENT 테이블로부터 부서아이디, 부서명만을 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- EMPLOYEE 테이블로부터 사원명, 이메일, 전화번호, 입사일 정보만을 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

Select Emp_Name, Email, Phone, Hire_Date
From Employee;
-- 컬럼명, 테이블명, 키워드는 대소문자를 가리지 않음 (단, 실제 담겨있는 데이터값은 가린다!!)

-------------------------------------------------------------------------------------

/*
    < 컬럼값을 통한 산술연산 >
    SELECT 절에 산술연산자(+-/*)를 기입해서 산술연산된 결과 조회 가능
*/

-- EMPLOYEE 테이블로부터 직원명, 급여, 직원의 연봉 조회
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 급여, 보너스, 연봉, 보너스가포함된 연봉
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + BONUS * SALARY)*12
FROM EMPLOYEE;
--> 산술연산 중에 NULL값이 존재할 경우 산술연산한 결과마저도 무조건 NULL값으로 조회됨!!!

-- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식끼리도 연산 가능
-- 오늘날짜 : SYSDATE(DATE형식 == 년월일시분초) -> (컴퓨터)시스템 날짜
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

----------------------------------------------------------------------------------
/*
    < 컬럼명에 별칭 지정하기 >
    컬럼명 AS 별칭 | 컬럼명 AS "별칭" | 컬럼명 별칭 | 컬럼명 "별칭"
    
    AS를 붙이든 안붙이든간에 부여하고자 하는 별칭에 특수문자 또는 띄어쓰기가 포함될 경우 반드시 쌍따옴표를 써야된다!
*/

SELECT EMP_NAME AS 이름, SALARY AS "급여", BONUS 보너스, 
       SALARY*10 "연봉(원)", (SALARY + BONUS * SALARY)*12 "총 소득"
FROM EMPLOYEE;

----------------------------------------------------------------------------------

/*
    < 리터럴 >
    임의로 지정한 문자열('')을 SELECET절에 기술하면
    실제 그 테이블에 존재하는 데이터처럼 조회가능
*/

-- EMPLOYEE 테이블로부터 사번, 사원명, 급여, 단위('원') 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' 단위
FROM EMPLOYEE;
--> SELECT절에 제시한 리터럴 값은 조회결과의 모든 행에 반복적으로 출력됨

----------------------------------------------------------------------------------

/*
    < DISTINCT >
    컬럼에 포함된 중복값을 단 한번씩만 표시하고자 할 때 사용
    (단, SELECET절에 단 한개만 기입 가능)
*/

-- EMPLOYEE 테이블로부터 부서코드 조회 (현재 사원들이 어떤 부서에 속해있는지..)
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYeE 테이블로부터 중복제거한 부서코드 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 중복제거한 직급코드 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
--> DEPT_CODE값이랑 JOB_CODE값이랑 세트로 묶어서 중복판별!

----------------------------------------------------------------------------------

/*
    < WHERE 절 >
    조회하고자 하는 테이블에서 특정 조건에 만족하는 데이터만을 조회하고자 할 때 기술하는 구문
    
    [표현법]
    SELECT 조회하고자하는 컬럼, 컬럼, ...
    FROM 테이블명
    WHERE 조건식;
    
    -> 조건식에 다양한 연산자들 사용 가능



    < 비교연산자 >
    >, <, >=, <=     -> 대소비교
          =          -> 동등비교(같다)
     !=, ^=, <>               (다르다)
*/

-- EMPLOYEE 테이블로부터 급여가 400만원 이상인 사원들만 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 부소코드가 D9인 사원들의 사원명, 부서코드, 급여 조회
                                    -- 실행 순서
SELECT EMP_NAME, DEPT_CODE, SALARY  -- 3
FROM EMPLOYEE                       -- 1
WHERE DEPT_CODE = 'D9';             -- 2

-- EMPLOYEE 테이블에서 부서코드가 D9가 아닌 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

---------------------------실습문제----------------------------
-- 1. EMPLOYEE 테이블에서 급여가 300만원 이상인 직원들의 직원명, 급여, 입사일 조회
SELECT EMP_NAME 직원명, SALARY 급여, HIRE_DATE 입사일, '일' 날짜
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE 테이블에서 재직중인 직원들의 사번, 이름, 입사일 조회
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, '일' 날짜
FROM EMPLOYEE
WHERE ENT_YN != 'Y';

-- 3. EMPLOYEE 테이블에서 직급코드가 J2인 직원들의 직원명, 급여, 보너스 조회
SELECT EMP_NAME 직원명, SALARY 급여, BONUS 보너스
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 4. EMPLOYEE 테이블에서 연봉이 5000만원 이상인 직원들의 직원명, 급여, 연봉, 입사일 조회
SElECT EMP_NAME 직원명, SALARY 급여, SALARY*12 연봉, HIRE_DATE 입사일, '일' 날짜   -- 3
FROM EMPLOYEE                   -- 1
WHERE SALARY*12 >= 50000000;    -- 2
--> WHERE절에서는 SELECT절에 부여한 별칭 쓸수 없음!!

----------------------------------------------------------------------------------

/*
    <논리연산자>
    여러개의 조건을 엮을 때 사용
    AND(~이면서, 그리고), OR(~이거나, 또는)
*/

-- EMPLOYEE 테이블에서 부서코드가 'D9'이면서 급여가 500만원 이상인 직원들의 직원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- EMPLOYEE 테이블에서 부서코드가 'D6'이거나 급여가 300만원 이상인 직원들의 직원명, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- EMPLOYEE 테이블에서 급여가 350만원 이상이고 600만원 이하인 직원들의 직원명, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

----------------------------------------------------------------------------------

/*
    < BETWEEN AND >
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용
    
    [표현법]
    비교대상컬럼명 BETWEEN 하한값 AND 상한값
*/
-- EMPLOYEE 테이블에서 급여가 350만원 이상, 600만원 이하인 사원들의 사워명, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
-- WHERE SALARY >= 3500000 AND SALARY <=6000000;
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서 급여가 350만원 이상, 600만원 이하가 아닌 사원들을 조회 (급여가 350만 미만이거나 급여가 600만 초과인)
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000; -- NOT을 붙이게 되면 해당조건의 반대되는 조건 (자바로 따졌을 때 !와 동일)
                                              -- NOT은 컬럼명 앞, 뒤에 사용가능


-- * BETWEEN AND 연산자 DATE형식간에서도 사용 가능
-- 입사일이 '90/01/01' ~ '01/01/01' 인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'; -- 10개행 조회 됨

-- 위 조건의 반대되는 조건
SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'; -- 13개행 조회 됨

----------------------------------------------------------------------------------

/*
    < LIKE '특정패턴' >
    비교하려는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼명 LIKE '특정패턴'
    
    - 특정패턴에 '%', '_' 를 와일드 카드로 사용할 수 있음
    > '%' : 0글자이상
    EX) 비교대상컬럼명 LIKE '문자%' => 컬럼값 중에서 '문자'로 "시작"되는 걸 조회
        비교대상컬럼명 LIKE '%문자' => 컬럼값 중에서 '문자'로 "끝"나는 걸 조회
        비교대상컬럼명 LIKE '%문자%' => 컬럼값 중에서 '문자'가 "포함"되는 걸 조회
    
    > '_' : 1글자
    EX) 비교대상컬럼명 LIKE '_문자' => 컬럼값 중에 '문자'앞에 무조건 한글자가 올 경우 조회
        비교대상컬럼명 LIKE '__문자' => 컬럼값 중에 '문자'앞에 무조건 두글자가 올 경우 조회
*/

-- 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 사원명, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%'; -- 정중하, 하이유, 하동운, 유하진 등 '하'가 앞뒤 어디든 포함되어있으면 조회됨

-- 전화번호 4번째 자리가 9로 시작하는 사번들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';



-- 이메일 중 _ 앞글자가 3글자인 이메일 주소를 가진 사원들의 사번, 이름, 이메일 조회
-- 이메일 4번째 자리가 _로 시작하는 사원
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- 와일드 카드로 사용되는 문자와 실제담겨있는 컬럼값이 동일할 경우 문제 발생!!

-- 어떤게 와일드 카드고 어떤게 데이터값인지 구분지어주면됨!!
-- 데이터값으로 인식시킬 값 앞에 임의로 나만의 와일드 카드로 제시하고 나만의 와일드카드를 ESCAPE로 등록
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- 김씨 성이 아닌 사원들의 사번, 사원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
-- WHERE EMP_NAME NOT LIKE '김%';
WHERE NOT EMP_NAME LIKE '김%';

---------------------------실습문제----------------------------
-- 1. 이름 끝이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. 전화번호 처음 3글자가 010이 아닌 사원들의 사원명, 전화번호
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. DEPARTMENT 테이블에서 해외영업부인 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%부';

----------------------------------------------------------------------------------

/*
    < IS NULL / IS NOT NULL >
    
    [표기법]
    비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
    비교대상컬럼 IS NOT NULL : 컬럼값이 NULL이 아닌경우
*/
-- 보너스를 받지 않는 사원들의 사번, 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL; -- NULL값은 단순히 = 으로 비교 불가

-- 보너스를 받는 사원 (BONUS컬럼값이 있는)들 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 사수가 없는 사원(MANAGER_ID컬럼값이 NULL)들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 사수도 없고 부서배치도 받지 않은 사원 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서배치를 받진 않았지만 보너스는 받는 사원 조회 (사원명, 보너스, 부서코드)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


----------------------------------------------------------------------------------
/*
    < IN >
    비교대상컬럼갑에 목록들 중에 일치하는 값이 있는지
    [표현법]
    비교대상컬럼 IN(값, 값, 값 ....)
*/
-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 사원명, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';  OR로도 가능 하지만 IN으로 더편하게 가능
WHERE DEPT_CODE IN('D6', 'D8', 'D5');

-- 그 외인 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE NOT DEPT_CODE IN('D6', 'D8', 'D5');

----------------------------------------------------------------------------------


/*
    < 연결 연산자 || >
    여러 컬럼 값들을 하나의 컬럼인것처럼 연결시켜주는 연산자
    컬럼과 리터럴(임의의 문자열)을 연결할 수 도 있다.
*/
-- ex) 자바에서 System.out.println("num : " + num);

-- 사번, 사원명, 급여를 하나의 컬럼으로 합쳐서 조회
SELECT EMP_ID || EMP_NAmE || SALARY
FROM EMPLOYEE;

-- XXX번 XXX의 월급은 XXXXXX원 입니다.
-- 컬럼값과 리터럴과 연결
SELECT EMP_ID || '번' || EMP_NAME || '의 월급은' || SALARY || '원 입니다.' 급여정보
FROM EMPLOYEE;

----------------------------------------------------------------------------------

/*
    < 연산자 우선순위 >
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL     LIKE     IN --> 우선순위가 같으면 앞쪽부터 됨, 먼저하고싶으면 () 사용
    5. BETWEEN AND
    6. NOT
    7. AND (논리연산자)
    8. OR  (논리연산자)
*/
-- OR보다 AND가 먼저 수행

-- 직급코드가 J7이거나 또는 J2인 사원들 중 급여가 200만원 이상인 사원들만 조회 모든 컬럼 조회 
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;
-- ()로 묶지 않으면 해석이 달라짐-> 직급코드가 J2이면서 급여가 200만원이상인 사원 또는 직급코드가 J7인 사원

----------------------------------------------------------------------------------
/* 실행순서
   3  :  SELECT
   1  :  FROM
   2  :  WHERE
*/
----------------------------------------------------------------------------------

/*
    < ORDER BY 절 >
    SELECT문 가장 마지막에 기입 하는 구문
    SELECT문 가장 마지막에 작성하는 것 뿐만아니라 실행 순서 또한 가장 마지막
    
    [표현법]
    SELECT 조회할컬럼, 컬럼, ...
    FROM 조회할테이블명
    WHERE 조건식
    ORDER BY 정렬시키고자하는컬럼명|별칭|컬럼순번  [ASC|DESE]  [NULLS FIRST|NULLS LAST]
                                           생략하면 기본적으로 ASC
    
    - ASC : 오름차순 정렬 (생략시 기본값)
    - DESC : 내림차순 정렬
    
    - NULLS FIRST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 NULL값들을 맨 앞
    - NULLS LAST  : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 NULL값들을 맨 뒤
    
    ** 실행 순서 **
    1. FROM 절
    2. WHERE 절
    3. SELECT 절
    4. ORDER BY 절
*/

SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS; -- ASC 또는 DESC생략시 기본값이 ASC (오름차순정렬)
-- ORDER BY BONUS ASC; -- 오름차순 정렬은 기본적으로 NULLS LAST
-- ORDER BY BONUS ASC NULLS FIRST; -- 오름차순 정렬에서 NULL값을 앞으로 두고싶을때
-- ORDER BY BONUS DESC; -- 내림차순 정렬은 기본적으로 NULLS FIRST
ORDER BY BONUS DESC, SALARY ASC; -- 첫번째 제시한 정렬 컬럼값이 일치할 경우 두번째 제시한 정렬기준을 가지고 정렬


-- 연봉별 내림차순 정렬로 조회 (사원명, 연봉)
SELECT EMP_NAME, SALARY*12 연봉
FROM EMPLOYEE
-- ORDER BY SALARY*12 DESC;
-- ORDER BY 연봉 DESC; -- 별칭 사용 가능
ORDER BY 2 DESC;      -- 컬럼 순번 사용 가능