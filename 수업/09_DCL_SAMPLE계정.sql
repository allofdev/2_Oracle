
-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�
-- 3_1. CREATE TABLE ���� �ο� ����
-- 3_2. TABLESPACE �Ҵ� ����
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- ������ �����ϰ� �ִ� ���̺���� �ٷ� ���� ����
INSERT INTO TEST VALUES(10);
SELECT * FROM TEST;

-- �� ��ü�� ������ �� �ִ� CREATE VIEW������ ���� ����
-- 4. CREATE VIEW ���� �ο�����
CREATE VIEW V_TEST
AS SELECT *
   FROM TEST;
   
SELECT * FROM V_TEST;


----------------------------------------------------------

-- �ٸ� ������ ���̺� ������ �� �ִ� ������ ���⶧���� �߻��� ����
-- 5. KH.EMPLOYEE�� SELECT ���� �ο�����
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.DEPARTMENT; --> DEPARTMENT���̺��� ���Ѻο����� �ʾ���

-- 6. KH.DEPARTMENT�� INSERT ���� �ο�����
INSERT INTO KH.DEPARTMENT
VALUES('D0', 'ȸ���', 'L2');

--ROLLBACK;












