/*
    < 함수 FUNCTION >
    - 자바로 치면 메소드같은 존재 
    - 전달값들을 읽어서 계산한 결과를 반환함
    
    > 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴 (매 행마다 함수 실행 결과 반환)
    > 그룹 함수  : N개의 값을 읽어서 1개의 결과를 리턴 (하나의 그룹별로 함수 실행 결과 반환)
    
    * 단일행함수와 그룹함수를 함께 사용할 수 없음!! : 결과 행의 갯수가 다르기 때문
    
    * 함수를 기술할 수 있는 위치 : SELECT 절, WHERE 절, ORDER BY 절, GROUP BY절, HAVING 절
    
*/

------------------------------------- < 단일행 함수 > ---------------------------------------
/*
    < 문자 관련 함수 >
    
    * LENGTH / LENGTHB
    
    LENGTH(STRING)   : 해당 문자의 글자 수 반환
    LENGTHB(STRING)  : 해당 문자의 바이트 수 반환
    
    => 결과값 NUMBER 타입으로 반환
    
    > STRING : 문자에해당하는컬럼|'문자값'
    
    '가', '강', '나'   한글 한 글자당 3BYTE로 취급
    'A', 'a', '1', '!'    한 글자당 1BYTE로 취급
    
*/

SELECT LENGTH('오라클!'), LENGTHB('오라클!')
FROM DUAL;  --> 가상테이블 (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*
    * INSTR 
    문자열로부터 특정 문자의 위치값 반환
    
    INSTR(STRING, '문자', [찾을위치의시작값, [순번]])
    => 결과값 NUMBER 타입
    
    > 찾을위치의 시작값
     1 : 앞에서부터 찾겠다. (기본값)
    -1 : 뒤에서부터 찾겠다.
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 찾을위치의 시작값, 순번 생략시 앞에서부터 첫번째의 B의 위치값
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@') "@위치"
FROM EMPLOYEE;

---------------------------------------------------------------------------

/*
    * SUBSTR
    문자열로부터 특정 문자열을 추출해서 반환
    (자바로 치면 문자열.substring()메소드와 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH])
    => 결과값 CHARACTER 타입
    
    > STRING : 문자타입 컬럼 또는 '문자값'
    > POSITION : 문자열을 잘라낼 시작위치값
    > LENGTH : 추출할 문자 개수 (생략시 끝까지 의미)
    
*/
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- 시작위치를 음수값으로 제시하면 뒤에서부터 위치를 찾음

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) 성별
FROM EMPLOYEE;

-- 남자사원들만 조회 (사원명, 급여)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- 여자사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

----------------------------------------------------------------------------

/*
    * LPAD / RPAD
    문자에 대해 통일감있게 보여주고자 할 때 사용
    
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의길이(바이트), [덧붙이고자하는 문자])
    => 결과값 CHARACTER 타입
    
    제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여 최종 N길이만큼의 문자열을 반환
    > 덧붙이고자하는 문자 생략시 기본값이 공백으로 처리
*/

SELECT EMAIL, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMAIL, RPAD(EMAIL, 20, '$')
FROM EMPLOYEE;

-- 891201-2****** 주민번호 조회       => 총 글자수 : 14글자
SELECT RPAD('891201-2', 14, '*') FROM DUAL;

-- 함수 중첩으로도 사용 가능
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

-------------------------------------------------------------------

/*
    * LTRIM / RTRIM
    
    LTRIM/RTRIM(STRING, [제거하고자하는문자들])
    => 결과값 CHARACTER 타입
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환
    
*/

SELECT LTRIM('   K H') FROM DUAL;
SELECT LTRIM('00012345600', '0') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM('5782KH123', '0123456789') FROM DUAL;

SELECT RTRIM('00012345600', '0') FROM DUAL;

-----------------------------------------------------------------------

/*
    * TRIM
    문자열의 앞/뒤/양쪽에 있는 특정 문자를 제거한 나머지 문자열을 반환
    
*/

-- 기본적으로 양쪽에 있는 문자 제거
SELECT TRIM('  K H  ') FROM DUAL;   -- 제거하고자 하는 문자 생략시 기본값이 공백

SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : 앞
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : 뒤
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;    -- BOTH : 양쪽 (기본값)

-- TRIM([[LEADING|TRAILING|BOTH] '제거하고자하는문자' FROM] STRING)
-- => 결과값 CHARACTER 타입

------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER : 다 소문자로
    UPPER : 다 대문자로
    INITCAP : 단어 앞글자마다 대문자로
    
    LOWER/UPPER/INITCAP(STRING) 
    => 결과값 CHARACTER 타입
    
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to myworld!') FROM DUAL;

-------------------------------------------------------------------------

/*
    * CONCAT
    전달된 두개의 문자열 하나로 합친 후 결과 반환
    
    CONCAT(STRING, STRING)
    => 결과값 CHARACTER 타입
*/
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;

SELECT CONCAT('가나다', 'ABC', 'DEF') FROM DUAL; -- CONCAT 두개의 문자열밖에 안댐..
SELECT '가나다' || 'ABC' || 'DEF' FROM DUAL;

-------------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)
    => 결과값 CHARACTER 타입
    
    STRING으로 부터 STR1 찾아서 STR2로 바꾼 문자열을 반환
    
*/
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com')
FROM EMPLOYEE;

-----------------------------------------------------------------------

/*
    < 숫자 관련 함수 >
    
    * ABS 
    절댓값 구해주는 함수
    
    ABS(NUMBER)
    
    > NUMBER : 숫자타입의 컬럼 / 숫자값
*/

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;

----------------------------------------------------------------

/*
    * MOD
    두 수를 나눈 나머지 값을 반환해주는 함수
    
    MOD(NUMBER, NUMBER)
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

------------------------------------------------------------------

/*
    * ROUND 
    반올림 처리해주는 함수
    
    ROUND(NUMBER, [위치])
*/
SELECT ROUND(123.456) FROM DUAL;  --- 위치 생략시 기본값 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 4) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(173.456, -2) FROM DUAL;

---------------------------------------------------------------------

/*
    * CEIL 
    무조건 올림처리해주는 함수
    
    CEIL(NUMBER)
*/
SELECT CEIL(123.156) FROM DUAL;
SELECT CEIL(123.156, 2) FROM DUAL; -- 위치 지정 불가

----------------------------------------------------------------

/*
    * FLOOR
    소수점 아래 무조건 버려버리는 함수
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.956) FROM DUAL;

SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) || '일' 근무일수
FROM EMPLOYEE;

----------------------------------------------------------------

/*
    * TRUNC
    위치 지정가능한 버림처리해주는 함수
    
    TRUNC(NUMBER, [위치])
    
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-------------------------------------------------------------------

/*
    < 날짜 관련 함수 > 
    
*/
-- DATE 타입의 형식 : 년/월/일, 시분초

-- * SYSDATE : 오늘날짜(시스템 날짜) 반환
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월 수 반환 
--   => 결과값 NUMBER 타입
SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) 근무일수, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) 근무개월수
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼의 개월수를 더한 날짜 반환
--   => 결과값 DATE 타입
-- 오늘날짜로부터 5개월 후
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- 각 사원들마다 직원명, 입사일, 입사후 6개월이 된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, 요일(문자|숫자)) : 특정날짜에서 가장 가까운 해당 요일을 찾아 그 날짜 반환
--   => 결과값 DATE 타입
SELECT NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '목') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 1:일요일, 2:월요일, .... 5:목요일, 6: 금요일, 7:토요일
SELECT NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- 에러 (현재언어가 KOREAN 이기 때문에)

-- 언어변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; 
SELECT NEXT_DAY(SYSDATE, '목요일') FROM DUAL;  -- 에러

-- 다시 언어변경
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE) : 해당 특정 날짜 월의 마지막 날짜를 구해서 반환
--   => 결과값 DATE 타입
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 직원명, 입사일, 입사월의 마지막날짜 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

/*
    * EXTRACT 
    년도, 월, 일 정보를 추출해서 반환
    
    EXTRACT(YEAR FROM DATE) : 특정 날짜로 부터 년도만 추출
    EXTRACT(MONTH FROM DATE) : 특정 날짜로부터 월만 추출
    EXTRACT(DAY FROM DATE) : 특정 날짜로부터 일만 추출
    
    => 결과값 NUMBER 타입
*/
-- 직원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME, 
       EXTRACT(YEAR FROM HIRE_DATE) 입사년도, 
       EXTRACT(MONTH FROM HIRE_DATE) 입사월,
       EXTRACT(DAY FROM HIRE_DATE) 입사일
  FROM EMPLOYEE
 ORDER BY 입사년도, 입사월, 입사일;
 
--------------------------------------------------------------------------

/*
    < 형변환 함수 >
    
    * NUMBER|DATE       =>  CHARACTER 으로 변환시키는 함수
    
    TO_CHAR(NUMBER|DATE, [포맷]) : 숫자형 또는 날짜형 데이터를 문자형타입으로 변환
    => 결과값 CHARACTER 타입
    
*/
-- NUMBER => CHARACTER
SELECT TO_CHAR(1234) FROM DUAL; -- 1234 => '1234'
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 1234 => '01234'         => 빈칸 0으로 채움
-- System.out.printf("%5d", 1234);
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 1234 => ' 1234'         => 빈칸 공백으로 채움

SELECT TO_CHAR(1234, 'L00000') FROM DUAL; -- 1234 => '\01234'       => 현재 설정된 나라(LOCAL)의 화폐단위
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

-- DATE(년월일시분초) => CHARACTER
SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;

-- 년도로써 쓸수있는 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월로써 쓸수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')     -- 로마 숫자 
FROM DUAL;

-- 일로써 쓸 수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'D'),       -- 1주기준 몇일째
       TO_CHAR(SYSDATE, 'DD'),      -- 1달기준 몇일째
       TO_CHAR(SYSDATE, 'DDD')      -- 1년기준 몇일째
FROM DUAL;

-- 요일로써 쓸수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'DY'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- 2020년 08월 04일 (화)
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" (DY)') FROM DUAL;

-- 직원명, 입사일(위의 포맷적용)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)')
FROM EMPLOYEE;

------------------------------------------------------------------------

/*
    * NUMBER/CHARACTER     => DATE 로 변환시키는 함수
    
    TO_DATE(NUMBER|CHARACTER, [포맷]) : 숫자형 또는 문자형 데이터를 날짜타입으로 변환
    => 결과값 DATE 타입
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE('20100101') FROM DUAL;
SELECT TO_DATE('100101') FROM DUAL;

SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('041030 143021', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;       
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- TO_DATE 함수를 통해 DATE형식으로 변환시 
                                              --        YY 포맷 : 무조건 현재세기

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;       
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- RR 포맷 : 해당 두자리 숫자값이 50이상이면 이전세기,
                                              --                            50미만이면 현재세기
                                              

-- 1998년 1월 1일 이후에 입사한 사원들 조회 (사번, 이름, 입사일 조회)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('19980101', 'YYYYMMDD'); -- 1998/1/1

-----------------------------------------------------------------------------------

/*
    * CHARACTER         =>   NUMBER 
    
    TO_NUMBER(CHARACTER, [포맷]) : 문자형 데이터를 숫자타입으로 변환
    => 결과값 NUMBER 타입
*/
-- 123123
SELECT '123' + '123' FROM DUAL; --> 알아서 자동으로 숫자로 형변환 한 뒤 산술연산까지 진행

SELECT '10,000,000' + '550,000' FROM DUAL; --> 문자가 포함되어있기 때문에 자동형변환 안됨..

SELECT TO_NUMBER('0123') FROM DUAL;
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;

----------------------------------------------------------------------------------

/*
    < NULL 처리 함수 >
*/
-- * NVL(컬럼명, 해당 컬럼값이 NULL일 경우 반환할 결과값)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 보너스 포함 연봉 조회
SELECT EMP_NAME, (SALARY + NVL(BONUS, 0)*SALARY) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '없음')
FROM EMPLOYEE;

-- * NVL2(컬럼명, 결과값1, 결과값2)
-- 해당 컬럼값이 존재하면 결과값1으로
-- 해당 컬럼값이 NULL이면 결과값2으로

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0)
FROM EMPLOYEE;

-- * NULLIF(비교대상1, 비교대상2)
-- 두 개의 값이 동일하면 NULL 반환
-- 두 개의 값이 동일하지 않으면 비교대상1 반환
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

---------------------------------------------------------------------

/*
    < 선택 함수 >
    
    * DECODE( 비교대상(컬럼명|산술연산|함수), 조건값1, 결과값1, 조건값2, 결과값2, .... , 결과값 )
    
    > 자바에서의 switch문과 유사
    switch(비교대상){
    case 조건값1 : 결과값1;
    case 조건값2 : 결과값2;
    default : 결과값;
    }
*/

-- 사번, 사원명, 주민번호로부터 성별자리 추출
SELECT EMP_ID, EMP_NAME, 
       DECODE( SUBSTR(EMP_NO, 8, 1) , '1', '남', '2', '여' ) 성별
FROM EMPLOYEE;

-- 직원들의 급여를 인상시켜서 조회

-- 직급코드가 J7인 사원은 급여를 10%로 인상해서 조회
--          J6인 사원은 급여를 15%로 인상해서 조회
--          J5인 사원은 급여를 20%로 인상해서 조회
--   그 외의 직급 사원들은 급여를 5%로만 인상해서 조회

SELECT EMP_NAME, JOB_CODE, SALARY 기존급여, 
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                              SALARY * 1.05) 인상급여
FROM EMPLOYEE;

------------------------------------------------------------------------

/*
    * CASE WHEN THEN 구문
    
    DECODE 선택함수와 비교하면 DECODE는 해당 조건 검사시 동등비교만을 수행한다면
    CASE WHEN THEN구문으로는 특정 조건 제시시 범위지정가능
    (자바로 IF-ELSE IF문)
    
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         ....
         ELSE 결과값
     END
    
*/
SELECT EMP_ID, EMP_NAME, 
       DECODE( SUBSTR(EMP_NO, 8, 1) , '1', '남', '2', '여' ) 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME,
       CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남'
            WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여'
        END 성별
FROM EMPLOYEE;

-- 사원명, 급여, 급여등급(고급, 중급, 초급)
-- SALARY값이 500만원 초과일 경우 '고급'
-- SALARY값이 500만원 이하 350만원 초과일 경우 '중급'
-- SALARY값이 350만원 이하일 경우 '초급'

SELECT EMP_NAME, SALARY, 
       CASE WHEN SALARY > 5000000 THEN '고급'
            WHEN SALARY > 3500000 THEN '중급'
            ELSE '초급'
        END 급여등급
FROM EMPLOYEE;

---------------------------------------------------------------------------------

----------------------------------- < 그룹함수 >----------------------------------
-- 1. SUM(숫자타입컬럼) : 해당 컬럼 값들의 총 합계를 반환해주는 함수

-- 전 사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 7009만~

-- 남자 사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1'; -- 4976만~

-- 부서코드가 D5인 사원들의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG(숫자타입컬럼) : 해당 컬럼값들의 평균값을 구해서 반환
-- 전사원의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ANY타입컬럼) : 해당 컬럼값들 중에 가장 작은 값 반환
SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_dATE)
FROM EMPLOYEE;

-- 4. MAX(ANY타입컬럼) : 해당 컬럼값들 중에 가장 큰 값 반환
SELECT MAX(SALARY), MAX(EMP_NAME), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|컬럼명|DISTINCT 컬럼명) : 행 갯수를 세서 반환
--    COUNT(*) : 조회결과에 해당하는 모든 행 갯수 다 세서 반환
--    COUNT(컬럼명) : 제시한 해당 컬럼값이 NULL이 아닌것만 행 갯수 세서 반환
--    COUNT(DISTINCT 컬럼명) : 제시한 해당 컬럼값이 중복이였을 경우 무조건 하나로만 세서 반환

-- 전체 사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- 부서배치가 된 사원(DEPT_CODE 값이 있는 사원) 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 보너스를 받는 사원 수
SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- 사수가 있는 사원 수 
SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

-- 현재 사원들이 속해있는 부서의 수
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;






































 





































