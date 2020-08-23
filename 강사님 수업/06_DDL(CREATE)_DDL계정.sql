/*

    DML (MANIPULATION 조작) : SELECT, INSERT, UPDATE, DELETE
    DDL (DEFINITION 정의) : CREATE, ALTER, DROP 
    DCL (CONTROL 제어) : GRANT, REVOKE, COMMIT, ROLLBACK
    
    DQL (QUERY 질의) : SELECT
    DML             : INSERT, UPDATE, DELETE
    DDL             : CREATE, ALTER, DROP
    DCL             : GRANT, REVOKE
    TCL (TRANSACTION) : COMMIT, ROLLBACK
    
    
    * DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    오라클에서 제공하는 객체(OBJCECT)들을 
    새로이 만들고(CREATE), 구조를 변경(ALTER)하고, 구조 자체를 삭제(DROP)하는 구문
    
    주로 DB관리자, 설계자가 사용하는 구문
    
    오라클에서의 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
                          인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
                          프로시져(PROCEDURE), 함수(FUNCTION), 
                          동의어(SYNONYM), 사용자(USER)
                          
    
    < CREATE >
    다양한 객체(구조)들 생성하는 구문
    
    1. 테이블 생성
    - 테이블? : 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
               데이터들을 보관하기 위한 제일 핵심적인 객체
    
    [표현법]
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기), 
        컬럼명 자료형,
        ....
    );
    
    * 자료형(DATA TYPE)
    
    - 문자 (CHAR(크기) / VARCHAR2(크기))
      > CHAR(크기) : 최대 2000BYTE 까지 저장 가능 / 고정길이 (아무리 적은 값이 들어와도 처음 할당한 크기 그대로)
      > VARCHAR2(크기) : 최대 4000BYTE 까지 저장 가능 / 가변길이 (담긴 값에 따라서 공간의 크기 맞춰짐)
    
    - 숫자 (NUMBER)
    
    - 날짜 (DATE)
    
*/

--> 회원에 대한 데이터를 담기위한 테이블 MEMBER 생성하기
CREATE TABLE MEMBER(
    MEM_NO NUMBER,      -- 회원 번호 
    MEM_ID VARCHAR2(20),-- 회원 아이디
    MEM_PWD VARCHAR2(20), -- 회원 비밀번호
    MEM_NAME VARCHAR2(20), -- 회원명
    GENDER CHAR(3),        -- 성별
    PHONE CHAR(13),        -- 전화번호
    EMAIL VARCHAR2(50),    -- 이메일
    MEM_DATE DATE          -- 회원가입일
);

SELECT * FROM MEMBER;

------------------------------------------------------------------------------

/*
    2. 컬럼에 주석 달기 (컬럼에 대한 설명같은거)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';


-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블(이미 있음) --
-- [참고] USER_TABLES : 이 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- [참고] USER_TAB_COLUMNS : 테이블상에 정의되어있는 모든 컬럼과 전반적인 구조를 확인할 수 있는 시스템 테이블
SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;

-- 데이터 추가할수 있는 구문
-- INSERT INTO 테이블명 VALUES(컬럼값, 컬럼값, 컬럼값, ...);

INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', null, SYSDATE);
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES('2', 'user02', 'pass02', '홍길녀', '여', '010-1111-2222', null, '19/07/21');
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

SELECT * FROM MEMBER;

/*
    < 제약조건 CONSTRAINTS >
    - 원하는 데이터값(유효한 값)만 유지하기 위해서 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다.
    - 들어올 데이터값에 문제가 없는지 자동으로 검사할 목적
    
    * 종류 : NOT NULL, UNIQUE, CHECK(조건), PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL 제약조건
      해당 컬럼에 반드시 값이 있어야만 하는 경우 사용 (해당 컬럼에 NULL값이 들어와서는 안되는 경우)
      삽입/수정시 NULL값을 허용하지 않도록 제한
*/

-- 제약조건을 부여하는 방식이 크게 2가지 있음 (컬럼레벨방식 / 테이블레벨방식)
-- NOT NULL제약조건 부여시 오로지 컬럼레벨 방식밖에 안됨 ㅠㅠ
-- 컬럼레벨 방식 : 컬럼명 자료형[(크기)] 제약조건
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', '홍길동', '남', null, NULL);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02', '김말순', NULL, NULL, NULL);
--> NOT NULL 제약조건에 위배되어 오류 발생함!! (내가 의도했던 대로)


INSERT INTO MEM_NOTNULL 
VALUES(3, 'user01', 'pass03', '홍길녀', '여', '010-2222-3333', 'aaa@naver.com');
--> 아이디가 중복됐음에도 불구하고 성공적으로 삽입됨!!
SELECT * FROM MEM_NOTNULL;

----------------------------------------------------------------------------

/*
    * UNIQUE 제약조건 
      컬럼값에 중복값을 제한하는 제약조건
      삽입/수정시 기존에 있는 데이터값 중에 중복값이 있을 경우 오류 발생
      
      컬럼레벨 방식/ 테이블레벨 방식 둘 다 사용 가능
*/

DROP TABLE MEM_UNIQUE;
/*
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --> 컬럼레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13), 
    EMAIL VARCHAR2(50)
);
*/
-- 테이블레벨 방식 : 제약조건(컬럼명)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13), 
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)  --> 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', '남', null, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '김말순', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user01', 'pass03', '홍길녀', null, null, null);
--> UNIQUE 제약조건에 위배되었으므로 INSERT 실패!!
--> 오류 구문을 제약조건명으로 알려줌!! (특정 컬럼에 어떤 제약조건이 위배되었는지 상세히 알려주지않음..)
--> 쉽게 파악하기 어려움.. (제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명을 부여해버림..)

/*
    * 제약조건명까지 이름지어주면서 제약조건을 부여하는 표현식
    
    > 컬럼 레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건,
        컬럼명 자료형
    );
    
    > 테이블 레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
    
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEM_NO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEM_ID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEM_PWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13), 
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID)  --> 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', '남', null, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '김말순', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user01', 'pass03', '홍길녀', null, null, null);


INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '홍길녀', '강', null, null);
--> 성별에 유효한 값이 아닌게 있어도 잘 INSERT 되버림! ㅠㅠ
SELECT * FROM MEM_UNIQUE;

--------------------------------------------------------------------

/*
    * CHECK(조건) 제약조건
      컬럼에 들어올 값에 대한 조건을 제시해둘 수 잇음
      해당 조건에 만족하는 데이터값만 담길 수 있음
    
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT GENDER_CK CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
    -- ,CONSTRAINT GENDER_CK CHECK(GENDER IN ('남', '여'))
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '홍길동', '남', null, NULL);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '김말순', NULL, NULL, NULL);
INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', '홍길녀', '여', null, null);
--> GENDER 컬럼에 값이 들어온다면 '남' 또는 '여'만 가능 
--> 뿐만 아니라 NULL값도 INSERT가능!!
--> 만약에 NULL값도 못들어오게끔 하고자 한다면 NOT NULL제약조건도 같이 부여하면됨!!

INSERT INTO MEM_CHECK VALUES(3, 'user04', 'pass04', '김말똥', '남', '010-1111-2222', 'bbb@naver.com');
--> 회원번호가 동일해도 성공적으로 insert됨... 

SELECT * FROM MEM_CHECK;

------------------------------------------------------------------------------------

/*
    * PRIMARY KEY (기본키) 제약조건
      테이블에서 각 행의 정보를 식별하기 위해 사용할 컬럼에 부여하는 제약조건 (식별자의 역할)
      EX) 학번, 회원번호, 사원번호, 부서코드, 직급코드, 주문번호, 예약번호, 운송장 번호, ...
      
      PRIMARY KEY 제약조건을 부여하게 되면
      해당 그 컬럼에 NOT NULL + UNIQUE 제약조건을 의미
      
      주의할점 : 한 테이블당 한개만 설정 가능
      
*/

CREATE TABLE MEM_PRIMARYKEY(
    MEM_NO NUMBER CONSTRAINT MEM_NO_PK PRIMARY KEY, --> 컬럼레벨 방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,    --> 회원번호가 아니라 아이디를 통해 식별자 역할 가능하긴함(대체키)
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN ('남', '여')) 
    -- , CONSTRAINT MEM_NO_PK PRIMARY KEY(MEM_NO) --> 테이블레벨 방식
);

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user01', 'pass01', '홍길동', '남', null, null);

INSERT INTO MEM_PRIMARYKEY
VALUES(NULL, 'user02', 'pass02', '이순신', NULL, NULL, NULL);
--> 기본키에 NULL값 담으려고 할 때 문제생김

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '이순신', NULL, NULL, NULL);
--> 기본키에 중복값을 담으려고 할 때 문제생김

--> PRIMARY KEY == NOT NULL + UNIQUE
INSERT INTO MEM_PRIMARYKEY
VALUES(2, 'user02', 'pass02', '이순신', NULL, NULL, NULL);
SELECT * FROM MEM_PRIMARYKEY;


--- * 주의할 점 : 한 테이블당 한개의 PRIMARY KEY만 가능!!
CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),    
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN ('남', '여')),
    PRIMARY KEY(MEM_NO, MEM_ID) --> 묶어서 PRIMARY KEY 제약조건 부여가능 (복합키)
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '홍길동', '남', null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '홍길녀', '여', null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user02', 'pass03', '김말똥', NULL, null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(NULL, 'user03', 'pass04', '김말녀', NULL, null, null);
--> 기본키로 묶여있는 각 컬럼에는 절대 NULL값이 들어가서는 안됨!!


SELECT * FROM MEM_PRIMARYKEY2;



-- 회원등급에 대한 데이터를 따로 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

SELECT * FROM MEM_GRADE;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER     --> 회원등급번호 같이 보관할 컬럼
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '홍길동', null, null, null, null);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '김말똥', '남', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '이순신', null, null, null, 40);


SELECT * FROM MEM;

-------------------------------------------------------------------------------

/*
    * FOREIGN KEY (외래키) 제약조건
      다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약조건
      
      --> 다른 테이블을 참조한다고 표현
      --> FOREIGN KEY 제약조건에 의해 테이블 간의 관계가 형성됨!!
      
      > 컬럼레벨 방식
        컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(컬럼명)]
        
      > 테이블레벨 방식
        [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(컬럼명)]
*/

SELECT * FROM MEM_GRADE;

DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER, -- REFERENCES MEM_GRADE--(GRADE_CODE) --> 컬럼레벨 방식
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE--(GRADE_CODE)  --> 테이블레벨 방식
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL, 20);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '이순신', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '안중근', NULL, NULL, NULL, NULL);
--> 외래키 제약조건이 부여된 컬럼에 기본적으로 NULL값 담는거 가능 
INSERT INTO MEM VALUES(5, 'user05', 'pass05', '신사임당', NULL, NULL, NULL, 40);
--> parent key를 찾을 수 없다는 오류 발생
-- 40이라는 값은 mem_grade 테이블 grade_code 컬럼에서 제공되고 있는 값이 아님

-- 부모테이블(MEM_GRADE) -|------<- 자식테이블(MEM)

SELECT * FROM MEM_GRADE;    -- GRADE_CODE
SELECT * FROM MEM;          -- GRADE_ID

-- 회원번호, 회원아이디, 회원명, 등급명
-- 오라클
SELECT MEM_NO, MEM_ID, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE GRADE_ID = GRADE_CODE(+);

-- ANSI
SELECT MEM_NO, MEM_ID, MEM_NAME, GRADE_NAME
FROM MEM
FULL JOIN MEM_GRADE ON(GRADE_ID = GRADE_CODE);


--> 근데 문제는 부모테이블 (MEM_GRADE)에서 데이터값을 삭제할 때 문제 발생!!
SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

--> 10번등급을 없애겠다!! 데이터 삭제
--  DELETE FROM 테이블명 WHERE 조건식;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> 자식테이블(MEM) 중에 10을 사용하고 있기 때문에 삭제할 수 없음!!
--  자식테이블에 사용하고 있는 값이 있을 경우 부모테이블로부터 삭제가 안되는 "삭제 제한" 옵션이 걸려있음!!

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;

ROLLBACK;

-----------------------------------------------------------------------------

/*
    부모테이블의 데이터 삭제시 자식테이블의 값을 어떻게 처리할 건지를 옵션으로 정해둘수 있음!!
    언제 ? => 자식테이블 생성할 때 외래키 제약조건 부여시
    
    * FOREIGH KEY 삭제 옵션
    
    삭제옵션을 별도로 제시하지 않으면  ON DELETE RESTRICTED (삭제 제한) 으로 기본 지정이 되어있음!!
*/

-- 1) ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 사용하고 있는 자식데이터값을 NULL값으로 변경시키는
DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL, 20);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '이순신', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '안중근', NULL, NULL, NULL, NULL);

SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;  --> 잘 삭제됨!! (단, 10을 가져다가 쓰고있는 자식데이터값들이 다 NULL로 변경)

SELECT * FROM MEM_GRADE;

ROLLBACK;

-- 2) ON DELETE CASCADE : 부모데이터 삭제 시 해당 데이터를 가져다 쓰고 있는 자식데이터도 같이 삭제해버리는
DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL, 20);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '이순신', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '안중근', NULL, NULL, NULL, NULL);

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10; --> 잘 삭제됨(단, 해당 데이터를 사용하고 있던 자식데이터도 같이 DELETE되버림!!)


-------------------------------------------------------------------------------------------

/*
    < DEFAULT 기본값 >
    
    컬럼 지정하지 않고 INSERT 시 기본값을 INSERT하고자 할 때 세팅해둘 수 있는 값
    (제약조건아님!!!!)
*/
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20),
    MEM_AGE NUMBER DEFAULT 20,
    MEM_DATE DATE DEFAULT SYSDATE
);
SELECT * FROM MEMBER;
-- INSERT INTO 테이블명 VALUES(컬럼값, 컬럼값, 컬럼값, 컬럼값);
INSERT INTO MEMBER VALUES(1, '홍길동', 20, SYSDATE);

-- INSERT INTO 테이블명(컬럼명, 컬럼명) VALUES(컬럼값, 컬럼값);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(2, '김말순');
--> 지정이 안된 컬럼에는 기본적으로 NULL값이 들어가지만
-->  해당 그 컬럼에 DEFAULT값이 부여되어있을 경우 NULL값이 아닌 DEFAULT 값이 들어감!!


-- 상품에 대한 데이터를 보관할 테이블 (상품번호, 상품명, 브랜드명, 가격, 재고수량)
CREATE TABLE PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(20) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 10
);

INSERT INTO PRODUCT VALUES(1, '갤럭시', '삼성', 1300000, 100);
INSERT INTO PRODUCT(PRODUCT_NO, PRODUCT_NAME, BRAND) VALUES(2, '아이폰12PRO', '애플');
INSERT INTO PRODUCT VALUES(3, '아이패드', '애플', 2500000, DEFAULT);

SELECT * FROM PRODUCT;


-----------------------------------------------------------------------------------

/*
    !!!!!!!!!!!!!!!!!!!!!!!!!! KH계정에서 !!!!!!!!!!!!!!!!!!!!!!!!!!
    
    < SUBQUERY를 이용한 테이블 생성 (테이블 복사뜨는 개념) >
    
    [표현식]
    CREATE TABLE 테이블명
    AS 서브쿼리;
    
*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
   FROM EMPLOYEE;
--> 컬럼, 담겨있는 데이터값, 제약조건 같은 경우 NOT NULL만 복사됨

SELECT * FROM EMPLOYEE_COPY;


CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
   FROM EMPLOYEE
   WHERE 1 = 0; --> 구조만 복사되고 모든 행에 대해 매번 FALSE기 때문에 데이터값은 복사안됨
   
   
SELECT * FROM EMPLOYEE_COPY2;


CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 연봉
   FROM EMPLOYEE;
--> 서브쿼리 SELECT절에 산술연산식 또는 함수식 기술된 경우 반드시 별칭 지정해야됨!!

SELECT * FROM EMPLOYEE_COPY3;

----------------------------------------------------------------------

/*
    
    * 테이블 다 생성된 후 뒤늦게 제약조건 추가
    
    - PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(참조할컬럼명);
    - UNIQUE      : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    - CHECK       : ALTER TABLE 테이블명 ADD CHECK(컬럼에대한 조건);
    - NOT NULL    : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;
    
*/

-- EMPLOYEE_COPY 테이블에 없는 PRIMARY KEY 제약조건 추가 (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE 테이블에 DEPT_CODE에 외래키 제약조건 추가
-- 참조하는 테이블(부모테이블) : DEPARTMENT(DEPT_ID) 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;--(DEPT_ID)

-- EMPLOYEE 테이블에 JOB_CODE에 외래키 제약조건 추가
-- 참조하는 테이블(부모테이블) : JOB(JOB_CODE)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);

-- DEPARTMENT 테이블에 LOCATION_ID에 외래키 제약조건 추가
-- 참조하는 테이블(부모테이블) : LOCATION(LOCAL_CODE)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);










































