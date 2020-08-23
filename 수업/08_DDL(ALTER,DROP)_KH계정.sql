/*
    * DDL (DATA DEFINETION LANGUAGE)
    ������ ���� ���
    
    < ALTER >
    ��ü���� �����ϴ� ����
    
    >> ���̺� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� �����ҳ���;
    
    - ������ ���� -
    1) �÷� �߰�/����/����
    2) �������� �߰�/���� => ������ �Ұ� (�����ϰ��� �Ѵٸ� ������ �� ������ �߰��ؾߵ�)
    3) ���̺��/�÷���/�������Ǹ�
*/

-- 1) Ŀ�� �߰�/����/����  ---> ���̺��� �ǵ�°Ŵ� ���� �ȵ�
-- 1_1) �÷� �߰�(ADD) : ADD �÷��� ������Ÿ�� [DDEFAULT �⺻��]
SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� �⺻������ NULL������ ä����

-- LNAME �÷� �߰� (�⺻�� ������ ç��)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
--> ���ο� �÷��� ��������� ���� ������ �⺻������ ä����


-- 1_2) �÷� ����(MODIFFY)
--      ������ Ÿ�� ���� : MODIFY �÷��� �ٲٰ����ϴµ�����Ÿ��
--      �⺻��     ���� : MODIFY �÷��� DEFAULT �ٲٰ����ϴ±⺻��
SELECT * FROM DEPT_COPY;

-- DEPT_ID �÷��� ������ Ÿ���� CHAR(3)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; �����Ͱ� ���ڿ��̱� ������ ���� �Ұ���(D1, D2 ...)
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10); �����Ͱ� 10byte�� �Ѵ� ���� �ֱ⶧���� 10byte�� ���ϼ� ����

-- DEPT_TITLE ���� ������ Ÿ���� VARCHAR2(40)��,
-- LOCATION_ID �÷��� ������ Ÿ���� VARCHAR2(2)��,
-- LNAME �÷��� �⺻���� '�̱�' ����
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�'; -- DEFFAULT�� �̱����� �ٲ� ���� �״�� ����
--> ���� ���� ����


-- 1_3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���
--      �������� : ���̺��� �ּ� �Ѱ��� �÷��� �����ؾߵ�!!!
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;


-- DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

-- DEPT_TITLE, CNAME, LNAME �÷��� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID; --> ���� - �ּ� �Ѱ��� �־�� ��

SELECT * FROM DEPT_COPY2;


--------------------------------------------------------------

-- 2) �������� �߰� / ����
-- 2_1) �������� �߰�
/*
  - PRIMARY KEY : ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] PRIMARY KEY(�÷���);
  - FOREIGN KEY : ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ���������̺��(�������÷���);
  - UNIQUE      : ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] UNIQUE(�÷���);
  - CHECK       : ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] CHECK(�÷������� ����);
  - NOT NULL    : ALTER TABLE ���̺�� MODIFY �÷��� [CONSTRAINT �������Ǹ�] NOT NULL;-- > MODIFY�� ������ ������ NULL��� �����̱� ������ NOT NULL�� �����Ѵٴ� �ǹ���
*/

-- DEPT_COPY ���̺�
-- DEPT_ID�� PRIMARY KEY �������� �߰� (ADD)
-- DEPT_TITLE�� UNIQUE �������� �߰�   (ADD)
-- LNAME�� NOT NULL �������� �߰�      (MODIFY)
ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_DTITLE_UQ UNIQUE(DEPT_TITLE) --> ������ �����ص���(���� �� ����)
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;


-- 2_2) �������� ����  : 
/*
    - DROP CONSTRAINT �������Ǹ�
    
    - NOT NULL -> NULL : MODIFY �÷��� NULL
*/
-- DCOPY_PK �������� ����
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DCOPY_DTITLE_UQ �����, LNAME �÷��� �ٽ� NULL�� ����
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DTITLE_UQ
MODIFY LNAME NULL;


--------------------------------------------------------------
-- 3) �÷��� / ���̺�� / �������Ǹ� ���� (RENAME)

-- 3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���
-- DEPT_TITLE --> DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- SYS_C007236 --> DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007236 TO DCOPY_LID_NN;

-- 3_3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
                               --> �̹� ALTER TABEL �� ���� ���̺��� ���õǾ��ֱ⋚���� ��������
-- DEPT_COPY --> DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

SELECT * FROM DEPT_TEST;



------------------------------------------------------------

-- ���̺� ���� : DROP TABLE ���̺��
-- ������ ��   : ��𼱰� �����ǰ��ִ� �θ����̺��� �Ժη� �����ȵ�!!
-- ���� ������ ���1. �ڽ����̺� ���� ������ �θ����̺��� �����ϴ� ���
-- ���� ������ ���2. �ƴϸ� �׳� �θ����̺� �����ϴµ� �ƽθ� �������ǵ� �Բ� �����ϴ� ���
   --> DROP TABLE ���̺�� CASCADE CONSTRAINT

DROP TABLE DEPT_TEST CASCADE CONSTRAINT;












