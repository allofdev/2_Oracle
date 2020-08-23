/*
    
    < PL/SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    ������ ����, ����ó��(IF), �ݺ�ó��(LOOP,FOR,WHILE)���� �����Ͽ� SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���� ���� (BLOCK������)
    
    * PL/SQL ����
    - [�����(DECLARE SECTION)] : DECLARE���� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - �����(EXECUTABLE SECTION) : BEGIN���� ����, SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ����ϴ� �κ�
    - [����ó����(EXCEPTION SECTION)] : EXCEPTION���� ����, ���ܹ߻��� �ذ��ϱ� ���� ������ ����صδ� ����
*/
--********** ȯ�溯�� ���ִ� �ڵ�
SET SERVEROUTPUT ON;
--**********

------------------------------------------------------------------------------------

-- * �����ϰ� ȭ�鿡 HELLO ORACLE ���
BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

------------------------------------------------------------------------------------

-- 1. DECLARE �����
--    ���� �� ��� ������ ���� ����(����� ���ÿ� �ʱ�ȭ�� ����)
--    �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���

-- 1_1) �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
-- [ǥ����] ������ [CONSTANT] �ڷ��� [:= ��] ;

DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14; -- ���Կ����� :=      ������� CONSTANT 
BEGIN 
    EID := 800;
    ENAME := '���峲';
    
    -- System.out.println("eid : " + eid); --> eid : 8000\
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

------------------------------------------------------------------------------------

-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (����̺��� � �÷��� ������Ÿ���� �����ؼ� ��Ÿ������ ����)
--      [ǥ����] ������ ���̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    -- ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� ���� EID, ENAME, SAL ������ ���
    -- ������ �� (SELECT INTO�� �̿��ؼ� ��ȸ����� �� ������ ���Խ�Ű���� �Ѵٸ� �ݵ�� �Ѱ��� ������ ��ȸ)
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 200;
    --WHERE EMP_ID = &EMP_ID; -- ����ڰ� �Է��� ��ȣ ��ȸ
    WHERE EMP_NAME = '&�̸�'; -- ����ڰ� �Է��� �̸� ��ȸ
    --> & ��ȣ�� ��ü����(���� �Է�)�� �Է��ϱ� ���� â�� �߰� ���ִ� ����
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/


---------------- �ǽ����� ----------------

/*
    ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
    �� �ڷ����� EMPLOYEE���̺��� �� EMP_ID, EMP_NAME, JOB_CODE, SALARY �÷� Ÿ�� �����ϰ�
              DEPARTMENT���̺��� DEPT_TITLE�÷� Ÿ���� �����ϰԲ�

    ����ڰ� �Է��� ������ ��ġ�ϴ� ����� ��ȸ(���, �����, �����ڵ�, �޿�, �μ���)�� ��
    ��ȸ����� �� ������ ���� �� ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME = '&�����';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('���� : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
END;
/

------------------------------------------------------------------------------------

-- 1_3) ���̺��� �� �࿡ ���� Ÿ�� ���� ���� (���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� �� ���� �� �ִ� ����)
-- [ǥ����] ������ ���̺��%ROWTYPE;

DECLARE 
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�����';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('��ȭ��ȣ : ' || E.PHONE);
END;
/

------------------------------------------------------------------------------------

-- 2. BEGIN

-- < ���ǹ� >

-- 2_1) IF ���ǽ� THEN ���೻�� END IF; (���� IF��)
-- ��� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�' ���

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF (BONUS = 0) 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS*100 || '%');
END;
/
    
------------------------------------------------------------------------------------

-- 2_2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF; (IF-ELSE��)

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF (BONUS = 0) 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
    END IF;
END;
/


-- �˻��� �ش� ����� ���, �̸�, �μ���, �����ڵ�(NATIONAL_CODE) ��ȸ �� ������ ���
-- �ش� ����� ���, �̸�, �μ���, �Ҽ�(������/�ؿ���) ���
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10); -- ���������� �ؿ������� ���ڿ��� ������� ����
BEGIN
    SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.NATIONAL_CODE
      INTO EID, ENAME, DTITLE, NCODE
      FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
     WHERE E.DEPT_CODE = D.DEPT_ID
       AND D.LOCATION_ID = L.LOCAL_CODE
       AND EMP_ID = '&���';
    
    IF (NCODE = 'KO')
        THEN TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� :' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/

-- 2_3) IF���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ... END IF; (IF-ELSE IF ��)
--                            ELSEIF-�ƴ�

-- ����ڿ��� �Է¹��� �������� SCORE������ ������ ��
-- 90�� �̻��� 'A', 80�� �̻� 'B', 70�� �̻� 'C', 60�� �̻� 'D', 60�� �̸��� 'F'�� ó���� �� GRADE������ ����
-- '����� ������ XX���̰�, ������ X�����Դϴ�.'

DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := &����;
    
    IF (SCORE >= 90)
        THEN GRADE := 'A';
    ELSIF (SCORE >=80)
        THEN GRADE := 'B';
    ELSIF (SCORE >=70)
        THEN GRADE := 'C';
    ELSIF (SCORE >=60)
        THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ ' || GRADE || '�����Դϴ�.');
    
END;
/

------------------------------------------------------------------------------------

-- < �ݺ��� >

/*
    1) BASIC LOOP ��
    
    [ǥ����]
    LOOP
        �ݺ������� ������ ����
        
        �ݺ����� �������� ����
    END LOOP;
    
    --> �ݺ����� �������� ���� (2����)
        1) IF ���ǽ� THEN EXIT; END IF;
        2) EXIT WHEN ���ǽ�;
        
*/

-- 1~5���� ���������� 1�� �����ϴ� ���� ���
DECLARE
    I NUMBER := 1;
BEGIN

    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        
        IF I = 6 THEN EXIT;
        END IF;
    END LOOP;
    
    
END;
/


/*
    2. FOR LOOP��
    
    [ǥ����]
    FOR ���� IN [REVERSE] �ʱⰪ..������
    LOOP
        �ݺ������� ������ ����
    END LOOP;
*/

-- 1 ~ 5
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);       
    END LOOP;
END;
/
    
-- ������ 5 ~ 1 (REVERSE)
BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);       
    END LOOP;
END;
/


-- �ݺ����� �̿��� ������ ����
CREATE TABLE TEST2(
    NUM NUMBER PRIMARY KEY,
    TODAY DATE
);

SELECT * FROM TEST2;


CREATE SEQUENCE SEQ_TEST
START WITH 200;

BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST2 VALUES(SEQ_TEST.NEXTVAL, SYSDATE);
    END LOOP;

END;
/

-- ��ø �ݺ���
-- ������ (2~9��) ����ϱ�
BEGIN
    FOR DAN IN 2..9
    LOOP
        
        DBMS_OUTPUT.PUT_LINE('===' || DAN || '��===');
        
        FOR SU IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || SU || ' = ' || DAN*SU);
            
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('');
        
    END LOOP;

END;
/

------------------------------------------------------------------------------------
/*
    3) WHILE LOOP

    [ǥ����]
    WHILE �ݺ����̼��������
    LOOP
        �ݺ������� ������ ����;
    END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
    END LOOP;

END;
/

------------------------------------------------------------------------------------

/*
    3. ����ó���� (EXCEPTION)
    
    ����(EXCEPTION) : ���� �� �߻��ϴ� ����

    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ...
        WHEN OTHERS THEN ����ó������N;  --> ��� ����ó�� �� �̰� �ϳ��� �� ó���� �� ����
    
    * �ý��� ���� (����Ŭ���� �̸����� �Ǿ��ִ� ����)
    - NO_DATA_FOUND : SELECT�� ����� �� �൵ ���� ���
    - TOO_MANY_LOWS : SELECT�� ����� �������� ���
    - ZERO_DIVIDE : 0���� ���� ��
    - DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ����Ǿ��� ���
     ....
*/

-- ����ڰ� �Է��� ���� ������ ������ ��� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� �����');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� �����');
END;
/

-- UNIQUE �������� �����

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&�����һ��'
    WHERE EMP_NAME = '���ö';
EXCEPTION
    --WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/

-- �� UPDATE ���� PL/SQL�� �ȿ� �ֱ� ������ ����ó��������
-- �׳� UPDATE ����Ҷ��� ����ó�� �� �� ����


DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
EXCEPTION
    --WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('��ȸ ����� �����ϴ�.');
    --WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('���� ���� ��ȸ�Ǿ����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��߽��ϴ�.');
END;
/
