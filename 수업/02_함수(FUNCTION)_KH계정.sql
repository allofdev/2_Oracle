/*
    < �Լ� FUNCTION >
    - �ڹٷ� ġ�� �޼ҵ尰�� ����
    - ���ް����� �о ����� ����� ��ȯ��
    
    > ������ �Լ� : N���� ���� �о N���� ����� ���� (�� �ึ�� �Լ� ���� ��� ��ȯ)
    > �׷� �Լ�  : N���� ���� �о 1���� ����� ���� (�ϳ��� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    * �������Լ��� �׷��Լ��� �Բ� ����� �� ����!! : ��� ���� ������ �ٸ��� ����
    
    * �Լ��� ����� �� �ִ� ��ġ : SELECT ��, WHERE ��, ORDER BY ��, GROUP BY ��, HAVING ��
*/

----------------------------------- < ������ �Լ� > -----------------------------------
/*
    < ���� ���� �Լ� >
    
    * LENGTH / LENGTHB
    [ǥ���]
    LENGTH(STRING) : �ش� ������ ���� �� ��ȯ
    LENGTHB(STRING) : �ش� ������ ����Ʈ �� ��ȯ
    
    => ����� NUMBER Ÿ������ ��ȯ
    
    > STRING : ���ڿ��ش��ϴ��÷�|'���ڰ�'
    
    '��', '��', '��' �ѱ� �� ���ڴ� 3BYTE�� ��� (2BYTE�ƴ�!)
    'A', 'a', '1', '!'  �� ���ڴ� 1BYTE�� ���
*/
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; --> DUAL �������̺� (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-------------------------------------------------------------------------------------
/*
    * INSTR
    ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    
    [ǥ���]
    INSTR(STRING, '����', [ã����ġ�ǽ��۰�, [����]])
    
    => ����� NUMBER Ÿ������ ��ȯ
    
    > ã����ġ�� ���۰�
     1 : �տ������� ã�ڴ�. (�⺻��) -> ã����ġ�ǽ��۰��� �����ϸ� �տ������� ã��
    -1 : �ڿ������� ã�ڴ�.
    
    > ���� ������ ù��°�� ������ ��
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ã����ġ�� ���۰�, ���� ������ �տ������� ù��°�� B�� ��ġ��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- �տ������� ù��° B�� ��ġ��
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- �ڿ������� ù��° B�� ��ġ��
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- �տ������� �ι�° B�� ������
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; -- �ڿ������� �ι�° B�� ��ġ��

SELECT EMAIL, INSTR(EMAIL, '@') "@��ġ"
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    * SUBSTR
    ���ڿ��κ��� Ư�� ���ڿ��� �����ؼ� ��ȯ
    (�ڹٷ� ġ�� ���ڿ�.substring()�޼ҵ�� ����)
    
    [ǥ���]
    SUBSTR(STRING, POSITION, [LENGTH])
    => ����� CHARACTER Ÿ������ ��ȯ
    
    > STRING : ����Ÿ�� �÷� �Ǵ� '���ڰ�'
    > POSITION : ���ڿ��� �߶� ������ġ��
    > LENGTH : ������ ���� ���� (������ ������ �ǹ�)
*/
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- ������ġ�� �������·� �����ϸ� �ڿ������� ��ġ�� ã��

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) ����
FROM EMPLOYEE;

-- ���ڻ���鸸 ��ȸ(�����, �޿�)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- ���ڻ���鸸 ��ȸ(����� �޿�)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4');

-------------------------------------------------------------------------------------


/*
    * LPAD / RPAD
    ���ڿ� ���� ���ϰ��ְ� �����ְ��� �� �� ���
    
    [ǥ���]
    LPAT/RPAD(STRING, ���������� ��ȯ�� �����Ǳ���(����Ʈ), [�����̰����ϴ� ����])
    
    => ����� CHARACTER Ÿ������ ��ȯ
    
    ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ� ���� N���̸�ŭ�� ���ڿ��� ��ȯ
    > �����̰����ϴ� ���� ������ �⺻���� �������� ó��
*/

SELECT EMAIL, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMAIL, RPAD(EMAIL, 20, '$')
FROM EMPLOYEE;

-- 891201-2****** �ֹι�ȣ ��ȸ
SELECT RPAD('891201-2', 14, '*') FROM DUAL;

-- �Լ� ��ø���ε� ��� ����
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    * LTRIM / RTRIM 
    
    [ǥ���]
    LTRIM/RTRIM(STRING, [�����ϰ����ϴ¹��ڵ�])
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
    
    --> [�����ϰ����ϴ¹��ڵ�] ������ ���� ����
*/

SELECT LTRIM('   K H') FROM DUAL;
SELECT LTRIM('00012345600', '0') FROM DUAL;
SELECT LTRIM('12312322KH123', '123') FROM DUAL; -- '123' �ܾ ����°��̾ƴ϶� ������ ���ڸ� ��� ã�Ƽ� ���ʺ��� ����
SELECT LTRIM('ACABACCKH', 'ABC') FROm DUAL; -- 'ABC' �ܾ ����°��̾ƴ϶� ������ ���ڸ� ��� ã�Ƽ� ���ʺ��� ����
SELECT LTRIM('5782KH123', '0123456789') FROM DUAL; -- ���ʺ��� ���ڸ� ��� ����� ����

SELECT RTRIM('00012345600', '0') FROM DUAL; -- �����ʺ��� '0'�� ��� ã�� ����


-------------------------------------------------------------------------------------

/*
    * TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
    
    [ǥ���]
    TRIM([[LEADING|TRAILING|BOTH] '�����ϰ����ϴ¹���' FROM] STRING)
    
    => ����� CHARACTERŸ��
*/
-- �⺻������ ���ʿ� �ִ� ���� ����
SELECT TRIM('   K H  ') FROM DUAL; -- �����ϰ��� �ϴ� ���� ������ �⺻���� ����

SELECT TRIM('Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- ����

SELECT TRIM(BOTH 'z' FROM 'ZZZKHZZZ') FROM DUAL; -- BOTH : ���� ������(�⺻��)

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : ��
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : ��


-------------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER : �� �ҹ��ڷ�
    UPPER : �� �빮�ڷ�
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ�(���� ����)
    
    => ����� CHARACTER Ÿ��
    
    [ǥ���]
    LOWER/UPPER/INITCAP(STRING) 
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to my world') FROM DUAL;

-------------------------------------------------------------------------------------

/*
    * CONCAT
    ���޵� �ΰ��� ���ڿ� �ϳ��� ��ģ �� ��� ��ȯ
    
    [ǥ���]
    CONCAT(STRING, STRING)
    => ����� HARACTER Ÿ��
    
    - CONCAT�� �ΰ��� ���ڿ��ۿ� �ȵ�
*/
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL; -- 01_DML ���� ����� ���� ������
SELECT '�����ٶ�' || 'ABCD' || '123' FROM DUAL; -- �������� ���ڿ��� ��ġ���� || ���

-------------------------------------------------------------------------------------

/*
    * REPLACE
    
    STRING���� ���� STR1 ã�Ƽ� STR2�� �ٲ� ���ڿ��� ��ȯ
    
    [ǥ���]
    REPLACE(STRING, STR1, STR2)
 
    => ����� CHARACTER Ÿ��
*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com') "�̸��� ����"
FROM EMPLOYEE;


-------------------------------------------------------------------------------------
--����
-------------------------------------------------------------------------------------

/*
    < ���ڰ��� �Լ� >
    
    * ABS
    ���� �����ִ� �Լ�
    
    [ǥ���]
    ABS(NUMBER)
    
    > NUMBER : ����Ÿ���� �÷� / ���ڰ�
*/
SELECT ABS(-10) FROM DUAL; -- ' '�� ���ڸ� ������ �˾Ƽ� ���ڷ� ����ȯ ��
SELECT ABS(-10.9) FROM DUAL;

SELECT ABS('-10') FROM DUAL; -- ' '�� ���ڸ� ������ �˾Ƽ� ���ڷ� ����ȯ ��

-------------------------------------------------------------------------------------

/*
    * MOD
    �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
    
    [ǥ���]
    MOD(NUMBER, NUMBER)   
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3)FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

-------------------------------------------------------------------------------------


/*
    * ROUND
    �ݿø� ó�����ִ� �Լ�
    
    [ǥ����]
    ROUND(NUMBER)
    ROUNT(NUMBER, ��ġ)
*/
SELECT ROUND(123.456) FROM DUAL; -- ��ġ ������ �⺻�� 0
--         -2-10 123 -> ��ġ
SELECT ROUND(123.456, 0) FROM DUAL; -- ���� ����
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 4) FROM DUAL; -- ���� ��ġ�� �ϸ� �׳� �ݿø� ���� �״�� ����
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-------------------------------------------------------------------------------------

/*
    * CEIL
    ������ �ø�ó�����ִ� �Լ�
    
    [ǥ���]
    CEIL(NUMBER)   
    
    -- �ݿø��� �޸� ��ġ���� �Ұ���
*/
SELECT CEIL(123.156) FROM DUAL;

-------------------------------------------------------------------------------------

/*
    * FLOOR
    �Ҽ��� �Ʒ� ������ ���������� �Լ�
    
    [ǥ���]
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.123123) FROM DUAL;

SELECT EMP_NAME �̸�, FLOOR(SYSDATE - HIRE_DATE) || '��' �ٹ��ϼ�
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    * TRUNC
    ��ġ ���� ������ ����ó�����ִ� �Լ�
    
    [ǥ���]
    TRUNC(NUMBER)
    TRUNC(NUMBER, ��ġ)
    
    -- ��ġ�� ������ �⺻�� 0 ��, �Ҽ��� �Ʒ� ��� ������
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-------------------------------------------------------------------------------------
--��¥ ���� �Լ�
-------------------------------------------------------------------------------------

/*
    < ��¥ ���� �Լ�>

-- DATE Ÿ���� ���� : ��/��/��, �ú���
  
  > DATE : DATE�� �ش��ϴ� �÷� / DATE
*/

-- * SYSDATE : ���ó�¥(�ý��� ��¥) ��ȯ   --> SYSDATE�� �Լ��ƴ�
SELECT SYSDATE FROM DUAL;


-- * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� ��ȯ
-- => ����� NUMBER Ÿ��
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) �ٹ��ϼ�,FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) �ٹ�������
FROM EMPLOYEE;


-- * ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥ ��ȯ
-- => ����� DATE Ÿ��
-- ���ó�¥�κ��� 5���� ��
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
-- �� ����鸶�� ������, �Ի���, �Ի��� 6������ �� ��¥
SELECT EMP_NAME ������, HIRE_DATE �Ի���, ADD_MONTHS(HIRE_DATE, 6) "�Ի��� 6���� ��"
FROM EMPLOYEE;


-- * NEXT_DAY(DATE, ����(����|����)) : Ư�� ��¥���� ���� ����� ���� �ش� ������ ã�� �� ��¥ ��ȯ
-- => ����� DATE Ÿ��
SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 1:�Ͽ���, 2:������, ... 6:�ݿ���, 7:�����
SELECT NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- ���� (����� KOREAN���� �Ǿ��ֱ� ������)

-- ���� �ؼ� �����غ���
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL; -- ���� (AMERCAN���� �����߱� ������ '�����' ����)

-- �ٽ� ��� ����
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE) : �ش� Ư�� ��¥ ���� ������ ��¥�� ���ؼ� ��ȯ
-- => ����� DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ������, �Ի���, �Ի���� ��������¥ ��ȸ
SELECT EMP_NAME ������, HIRE_DATE �Ի���, LAST_DAY(HIRE_DATE) "�Ի���� ��������¥"
FROM EMPLOYEE;

/*
    * EXTRACT : �⵵, ��, �� ������ �����ؼ� ��ȯ
    
    [ǥ���]
    EXTRACT(YEAR FROM DATE)  : Ư�� ��¥�κ��� �⵵�� ����
    EXTRACT(MONTH FROM DATE) : Ư�� ��¥�κ��� ���� ����
    EXTRACT(DAY FROM DATE)   : Ư�� ��¥�κ��� �ϸ� ����
    
    => ����� NUMBER Ÿ��
*/
-- ������, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME , 
       EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵, 
       EXTRACT(MONTH FROM HIRE_DATE) �Ի��, 
       EXTRACT(DAY FROM HIRE_DATE) �Ի���
  FROM EMPLOYEE
 ORDER BY �Ի�⵵ ASC ,�Ի�� ASC, �Ի��� ASC; -- ASC �������� ������ (�⺻������ ��������)


-------------------------------------------------------------------------------------

/*
    < ����ȯ �Լ� >
    
    * NUMBER|DATE   =>   CHARACTER ���� ��ȯ��Ű�� �Լ�
    
    ������ �Ǵ� ��¥�� �����͸� ������Ÿ������ ��ȯ
    
    [ǥ���]
    TO_CHAR(NUMBER|DATE)
    TO_CHAR(NUMBER|DATE, ����)
   
    => ����� CHARACTER Ÿ�� 
*/
-- NUMBER => CHARACTER
SELECT TO_CHAR(1234) FROM DUAL; -- 1234 => '1234'
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 1234 => '01234' => ��ĭ�� 0���� ä��
-- System.out.printf("%5d", 1234); �� ����
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 1234 => ' 1234' => ��ĭ�� �������� ä��

SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- 1234 => ' \1234' => ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1234, '$99999') FROM DUAL; -- 1234 => ' $1234' => �޷� ȭ�����

SELECT TO_CHAR(1234, 'L99,99') FROM DUAL; -- 1234 => '\12,34'

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;


-- DATE(����Ͻú���) => CHARACTER
SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DAY, YYYY') FROM DUAL;


-- �⵵�ν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ���ν� �����ִ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM') -- �θ�����
FROM DUAL;

-- �Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'D'),  -- 1�ֱ��� ����°
       TO_CHAR(SYSDATE, 'DD'), -- 1�ޱ��� ����°
       TO_CHAR(SYSDATE, 'DDD') -- 1����� (2020���� �ǰ���) ����°
FROM DUAL;

-- ���Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'DY'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- 2020��08��04�� (ȭ)
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" (DY)') -- ����� �� ���� Ư�� ���ڷ� �Ϸ��� �ֵ���ǥ("")�� ���´�.
FROM DUAL;

-- ������, �Ի���(���� ���� ����)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)')
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    * NUMBER / CHARACTER => DATE �� ��ȯ��Ű�� �Լ�
    
    ������ �Ǵ� ������ �����͸� ��¥Ÿ������ ��ȯ
    
    [ǥ���]
    TO_DATE(NUMBER|CHARACTER)
    TO_DATE(NUMBER|CHARACTER, ����)
    
    => ����� DATE Ÿ��
*/

SELECT TO_DATE(20100101) FROM DUAL; -- ��¹����� ����Ŭ��-����Ŭ�� ������ �޷��� �߸� DATE�����̶�°� �˼�����
SELECT TO_DATE('20100101') FROM DUAL;
SELECT TO_DATE('100101')FROM DUAL; -- �޷�Ȯ�ν� 2010�⵵�� �Ǿ�����

SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('100101 143021', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- TO_DATE �Լ��� ���� DATE�������� ��ȯ��
                                              -- YY ���� : ������ ���缼�� (2098)
SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL; -- RR ���� : �ش� ���ڸ� ���ڰ��� 50�̸��̸� ���缼�� (2014)
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAl; --                            50�̻��̸� �������� (1998)
                                              
-- 1998�� 1�� 1�� ���Ŀ� �Ի��� ����� ��ȸ (���, �̸�, �Ի��� ��ȸ)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20980101', 'YYMMDD'); -- Ȯ���ϰ� '20980101', 'YYMMDD' �� �ϸ� ��
                                                 -- '980101', 'YYMMDD' �� �ϰԵǸ� 2098�⵵

/*
    * CHARACTER  =>  NUMBER
    
    ������ �����͸� ����Ÿ������ ��ȯ
    
    [ǥ���]
    TO_NUMBER(CHARACTER)
    TO_NUMBER(CHARACTER, ����)
    
    => ����� NUMBER Ÿ��
*/
--123123
SELECT '123' + '123' FROM DUAL; -- ''�� �����־ ���ڸ� ������ �ڵ����� ���ڷ� ����ȯ �� �� ���������� ����

SELECT '10,000,000' + '550,000' FROM DUAL; --> ���ڰ� ���ԵǾ��ֱ� ������ �ڵ�����ȯ �ȵ�

SELECT TO_NUMBER('0123') FROM DUAL;
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL; -- 9�� ���� ���Ŀ� �°� ���� ����ߵ�


-------------------------------------------------------------------------------------

/*
    < NULL ó�� �Լ� >
*/

-- * NVL(�÷���, �ش� �÷����� NULL�� ��� ��ȯ�� �����)
-- �÷����� ������ �����ǰ�, NULL�̸� ��ȯ�� �����

SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ���ʽ� ���� ���� ��ȸ     -- NVL������� �ʾ����� ���ʽ��� ������ ������ NULL��
SELECT EMP_NAME, (SALARY + NVL(BONUS, 0)*SALARY) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '����')
FROM EMPLOYEE;


-- * NVL2(�÷���, �����1, �����2)
-- �ش� �÷����� �����ϸ� �����1����
-- �ش� �÷����� NULL�̸� �����2����

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0)
FROM EMPLOYEE;

-- Ư���� �Լ�(���� �Ⱦ�)
-- * NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� �����ϸ� NULL�� ��ȯ
-- �� ���� ���� �������� ������ �񱳴��1 ��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('456', '123') FROM DUAL;

-------------------------------------------------------------------------------------

/*
    < ���� �Լ� >
    
    [ǥ���]
    * DECODE( �񱳴��(�÷���|�������|�Լ�), ���ǰ�1, �����1, ���ǰ�2, �����2, ... �����)
    
    
    (�ڹ��� switch ���� ����)
    switch(�񱳴��){
    case ���ǰ�1: �����1;
    case ���ǰ�2: �����2;
    default: �����;
    }
*/

-- ���, �����, �ֹι�ȣ�κ��� �����ڸ� ����
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO, 8, 1), DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', null) ���� 
                                                   -- SUBSTR�� ���ڿ��� ��ȯ�ϱ⶧���� ���ǰ�1, 2 �� ''�� �Ѱ���
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- �����ڵ尡 J7�� ������� �޿��� 10% �λ��ؼ� ��ȸ
--          J6�� ������� �޿��� 15% �λ��ؼ� ��ȸ
--          J5�� ������� �޿��� 20% �λ��ؼ� ��ȸ
-- �� ���� ���� ������� �޿��� 5% �λ��ؼ� ��ȸ
SELECT EMP_ID, JOB_CODE, SALARY �����޿�, 
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                              SALARY * 1.05) �λ�޿�
FROM EMPLOYEE;

-------------------------------------------------------------------------------------


/*
    * CASE WHEN THEN ����   --> �Լ��� �ƴ�
    
    DECODE �����Լ��� ���ϸ� DECODE�� �ش� ���� �˻�� ����񱳸��� �����Ѵٸ�
    CASE WHEN THEN�������δ� Ư�� ���� ���ý� ������������
    
    [ǥ���]
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����
    END
         
    (�ڹ��� IF-ELSE IF ���� ����)
*/

SELECT EMP_ID, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', null) ����
FROM EMPLOYEE;

--> DECODE��  CASE WHEN THEN �������� �غ��� 
SELECT EMP_ID, EMP_NAME,
       CASE WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '��'
            WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '��'
       END ����
FROM EMPLOYEE; 



--> ������ �����Ҷ��� DECODE�δ� �� �� ����
-- �����, �޿�, �޿����(���, �߱�, �ʱ�)
-- SALARY���� 500���� �ʰ��� ��� '���'
-- SALARY���� 500���� ���� 350���� �ʰ��� ��� '�߱�'
-- SALARY���� 350���� ������ ��� '�ʱ�'
SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY > 5000000 THEN '���'
            WHEN SALARY > 3500000 THEN '�߱�'
            ELSE '�ʱ�'
       END �޿����
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

------------------------------------< �׷��Լ� >--------------------------------------

-- 1. SUM(����Ÿ���÷�) : �ش� �÷������� �� �հ踦 ��ȯ���ִ� �Լ�

-- SUM�Լ��� ������� �� ���̱� ������ SELECT���� �ٸ� ������� ���� ���� �� ���� 
-- ex) SELECT SUM(SALARY), EMP_NAME FROM EMPLOYEE --> �̸����� ������������ SUM(SALARY)�� �ϳ��� ���̱� ������ ����
--> �׷��Լ������� ���� SELECT ����


-- �� ����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- ���� ����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8 , 1) = '1';

-- �μ��ڵ尡 D5�� ������� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- 2. AVG(����Ÿ���÷�) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ �� �Ҽ��� �Ʒ��� �������ϱ⶧���� �ݿø�
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ANYŸ���÷�) : �ش� �÷����� �߿� ���� ���� �� ��ȯ
-- ���ڿ��� ���� ���� ex)�̸��߿� ���� ���� �̸� �� �� �� ��....
-- ��¥ Ÿ�Ե� ����
SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(ANYŸ���÷�) : �ش� �÷����� �߿� ���� ū �� ��ȯ
SELECT MAX(SALARY), MAX(EMP_NAME), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|�÷���|DISTINCT �÷���) : �� ������ ���� ��ȯ             (DISTINCT �ߺ�����)
--    COUNT(*) : ��ȸ����� �ش��ϴ� ��� �� ���� �� ���� ��ȯ
--    COUNT(�÷���) : ������ �÷����� NULL�� �ƴѰ͸� ���� ���� ��ȯ
--    COUNT(DISTINCT �÷���) : ������ �ش� �÷����� �ߺ��̾������ ������ �ϳ��θ� ���� ��ȯ
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- �μ���ġ�� �� ���(DEPT_CODE ���� �ִ� ���) ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- ���ʽ��� ���޴� �����
SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ������ ����鸶�� ����� �ִ� ���
SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

-- ���� ������� �����ִ� �μ��� ��
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;



