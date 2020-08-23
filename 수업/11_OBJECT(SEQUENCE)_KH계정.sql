/*
    < ������ SEQUENCE >
    �ڵ����� ��ȣ �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� ��������
*/

/*
    1. ��������ü ���� ����
    
    [ǥ����]
    CREATE SEQUENCE ��������
    [START WITH ����]        --> ó�� �߻���ų ���۰� ���� -> ������ 1
    [INCREMENT BY ����]      --> � ������ų ���� -> ������ 1�� ����
    [MAXVALUE ����]          --> �ִ밪 ���� -> ������ 9999999999999999.....
    [MINVALUE ����]          --> �ּҰ� ���� -> ������ 1
    [CYCLE | NOCYCLE]       --> �� ��ȯ ���� ����
    [CACHE ����Ʈũ�� | NOCACHE] --> ĳ�ø޸� �Ҵ�(�⺻�� 20����Ʈ)
    
    * ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����ص�
                  �Ź� ȣ���Ҷ����� ������ ��ȣ�� �����ϴ� �� ���� ĳ�ø޸� ������
                  �̸� ������ ������ ������ ���ԵǸ� �ξ� �ӵ��� �� ����
*/
-- ���̺�� : TB_
-- ���    : VW_
-- �������� : SEQ_
-- Ʈ���Ÿ� : TRG_



-- EMPLOYEE���̺� 300�� ����
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- [����] �� ������ �����ϰ� �ִ� �������鿡 ���� ����
SELECT * FROM USER_SEQUENCES;

-----------------------------------------------------------------

/*
    2. SEQUENCE ��� ����
    
    ��������.CURRVAL : ���� �������� �� (�������� NEXTVAL�� ��)
    ��������.NEXTVAL : ���������� ������Ű�� ������ �������� ��
                      ������������ ������ INCREMENT BY����ŭ ������ ��
                      == ��������.CURRVAL + INCREMENT BY��
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL�� �ѹ��̶� �������� �ʴ� �̻� CURRVAL�� �� �� ����!!
--> ��? : CURRVAL�� ��� ���������� ���������� ����� NEXTVAL�� ���� �����ؼ� �����ִ� �ӽð�

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> ������ MAXVALUE���� �ʰ��߱� ������ ���� �߻�

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 310

/*
    3. SEQUENCE ����
    
    [ǥ����]
    ALTER SEQUENCES ��������
    [INCRETMENT BY ����]
    [MAXVALUE ����]
    [MINVALUE ����]
    [CYCLE | NOCYCLE]
    [CACHE ����Ʈ�� | NOCACHE];
    
    * START WHIT�� ����Ұ�!!
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  -- 320

-- SEQUENCE �����ϱ�
DROP SEQUENCE SEQ_EMPNO;


----------------------------------------------------------------------------

--�Ź� ���ο� ����� �߻��ǰԲ� ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 300;

SELECT * FROM USER_SEQUENCES;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '891221-2184684', 'J1', SYSDATE);

-- ���� ���ϰ� �����ؼ� ��
INSERT INTO 
EMPLOYEE (
            EMP_ID
          , EMP_NAME
          , EMP_NO
          , JOB_CODE
          , HIRE_DATE
         )
   VALUES(
            SEQ_EID.NEXTVAL
          , '�踻��'
          , '1111-2222'
          , 'J4'
          , SYSDATE
          );

SELECT * FROM EMPLOYEE;












