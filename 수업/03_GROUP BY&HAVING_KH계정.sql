/*
    < GROUP BY �� >
    �׷������ ������ �� �ִ� ���� (�ش� �׷���غ��� �׷��� ������ �� �ִ�.)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/

SELECT SUM(SALARY)
  FROM EMPLOYEE; --> ��ü ������� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)  -- 3
  FROM EMPLOYEE                -- 1
 GROUP BY DEPT_CODE;           -- 2
-- GROUP BY �� DEPT_CODE�� �׷�ȭ �߱� ������ SELECT���� �׷��Լ��� �Բ� DEPT_CODE��� ����


SELECT COUNT(*)
  FROM EMPLOYEE; --> ��ü ��� ��

-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿����� �μ��� �������� �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) -- 4. SELECT��
  FROM EMPLOYEE               -- 1. FROM��
--WHERE                       -- 2. WHERE��
 GROUP BY DEPT_CODE           -- 3. GROUP BY ��
 ORDER BY DEPT_CODE ASC;      -- 5. ORDER BY ��


-- �� ���޺� �� �޿���, ���޺� �����, ���޺� ���ʽ��� �޴� �����, ��� �޿�(�Ҽ��� ������), �ְ�޿�, �ּұ޿�
SELECT JOB_CODE, SUM(SALARY), COUNT(*), COUNT(BONUS),
       FLOOR(AVG(SALARY)), MAX(SALARY), MIN(SALARY)
  FROM EMPLOYEE
 GROUP By JOB_CODE
 ORDER BY 1;

-- �� �μ��� �ѻ����, ���ʽ��޴»����, �޿� ��, ��ձ޿�(�ݿø� ó��), �ְ�޿�, �����޿�
SELECT DEPT_CODE �μ�,
       COUNT(*) �ѻ����, 
       COUNT(BONUS) ���ʽ��޴»����, 
       SUM(SALARY) �޿���, 
       ROUND(AVG(SALARY), 0) ��ձ޿�,
       MAX(SALARY) �ְ�޿�,
       MIN(SALARY) �����޿�
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

-- * ���� �÷��� �׷�������� ���� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), COUNT(*)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE, JOB_CODE
 ORDER BY 1; -- ù��° ���� �������� ��������


---------------------------------------------------------------------------------------

/*
    < HAVING �� >
    
    �׷쿡 ���� ������ ������ �� ���Ǵ� ����(�ַ� �׷��Լ��� ����� ������ �� ����)
    
    
*/

-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
  FROM EMPLOYEE
--WHERE AVG(SALARY) >= 3000000
 GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000
 ORDER BY 1;

-- �� ���޺� �ѱ޿����� 1000���� �̻��� ����, �޿����� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000
 ORDER BY 1;

-- �� �μ��� ���ʽ��� �޴� ����� ���� �μ��鸸 ��ȸ
SELECT DEPT_CODE
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;


SELECT j.JOB_NAME, e.JOB_CODE, COUNT(*), SUM(SALARY)
  FROM EMPLOYEE e, JOB j
 WHERE e.JOB_CODE = j.JOB_CODE
 GROUP BY e.JOB_CODE, j.JOB_NAME
 ORDER BY 2;


--------------------------------------------------------------------------------
/*
    <���� ����>
    5 : SELECT *|��ȸ�ϰ����ϴ��÷���|��������|�Լ���  [AS]  "��Ī"
    1 :   FROM ��ȸ�ϰ����ϴ����̺��
    2 :  WHERE ���ǽ�
    3 :  GROUP BY �׷���ؿ� �ش��ϴ� �÷���, �÷���, ...
    4 : HAVING �׷��Լ��Ŀ� ���� ���ǽ�
    6 : ORDER BY �÷���|��Ī|�÷�����  [ASC|DESE] [NULLS LAST|NULLS FIRST];
*/
--------------------------------------------------------------------------------

/*
    < ���� �Լ� > - �� �Ⱦ�!!!! (�ڰ��� ������ �ʿ�)
    
    �׷캰 ������ ������� �߰�����(����)�� ������ִ� �Լ�
    
    ROLLUP, CUBE  (GROUP BY���� ��� �Ǵ� �Լ�)
*/
-- ROLLUP   �� ���޺� �޿� �� 
SELECT JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(JOB_CODE)
 ORDER BY JOB_CODE;

-- CUBE
SELECT JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY CUBE(JOB_CODE)
 ORDER BY JOB_CODE;
-- �׷�������� �ϳ��� �÷��� �����ϰ� �Ǹ� ROOLUP�̵� CUBE�� �� ���� ����
-- ������ �࿡ ��ü �ѱ޿��ձ��� ���� ����


----- ROLLUP�� CUBE�� ������ (�׷������ ��� �ΰ��̻��� �÷��̿��ߵ�) -----

-- �μ��ڵ嵵 ���� �����ڵ嵵 ���� ������� �׷����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE, JOB_CODE
 ORDER BY DEPT_CODE; -- >13���� �׷�

-- ROLLUP(�÷�1, �÷�2) => �÷�1�� ������ �ٽ� �߰����踦 ���ִ� �Լ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
 ORDER BY DEPT_CODE;

-- CUBE(�÷�1, �÷�2) => �÷�1�� ������ �߰����賻��, �÷�2�� ������ �߰����踦 ��
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), COUNT(*)
  FROM EMPLOYEE
 GROUP BY CUBE(DEPT_CODE, JOB_CODE)
 ORDER BY 2;
 
 
--------------------------------------------------------------------------------
 
 
 /*
    < ���� ������(SET OPERATION) >
    
    �������� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION     : ������ (�� ������ ������ ������� ���� �� �ߺ��Ǵ� �κ� �ѹ� ����) = OR
    - INTERSECT : ������ (�� ������ ������ ������� �ߺ��� �����) = AND
    - UNION ALL : ������ ����� + ������ �����(UNION + INTERSECT) (�� ������ ������ ������� ������ ����) => �ߺ��� ���� �ι� �� �� ����
    - MINUS     : ������ (���� ������ ����� - ���� ������ �����)
 */
 
-- 1. UNION
-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ(���, �̸�, �μ��ڵ�, �޿�)
-- �μ��ڵ尡 5D�� ����鸸 ��ȸ
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       SALARY �޿�
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5';

-- �޿��� 300���� �ʰ��� ����鸸 ��ȸ
SELECT EMP_ID �����ȣ,
       EMP_NAME ����̸�,
       DEPT_CODE �μ��ڵ�,
       SALARY �޿�
  FROM EMPLOYEE
 WHERE SALARY > 3000000;

-- UNION
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       SALARY �޿�
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'      --> 6��
 UNION                     --> UNION�� �ϸ� �ߺ��� 2�� �����Ͽ� 12��
SELECT EMP_ID �����ȣ,
       EMP_NAME ����̸�,
       DEPT_CODE �μ��ڵ�,
       SALARY �޿�
  FROM EMPLOYEE
 WHERE SALARY > 3000000;  --> 8��

-- ���� ������ ��� �Ʒ�ó�� WHERE ���� ���ؼ��� �ذᰡ��
SELECT EMP_ID �����ȣ,
       EMP_NAME ����̸�,
       DEPT_CODE �μ��ڵ�,
       SALARY �޿�
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5' OR SALARY > 3000000;

---------------------------------------------------------------------------

-- �� �μ��� �޿��� (GROUP BY�� �̿�)
SELECT SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

-- �� �μ��� �޿��� (UNION)
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE='D1'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE='D2'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE='D9';


---------------------------------------------------------------------------

-- 2. UNION ALL : �������� ���� ����� ������ ���ϴ� ������ (�ߺ����� ������ �� �� ����) -- �÷��� ���� ���ƾ� �Ѵ�
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       BONUS "���ʽ� �Ǵ� �޿�"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'      --> 6��
 UNION ALL                 --> UNION ALL�� �ϸ� �ߺ��� 2�� ���� 14��
SELECT EMP_ID,
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;  --> 8��


-- 3. INTERSECT (������)
-- �μ��ڵ尡 D5�̸鼭 �׸��� �޿������� 300���� �ʰ��� ���
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       BONUS "���ʽ� �Ǵ� �޿�"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'
INTERSECT
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       BONUS "���ʽ� �Ǵ� �޿�"
  FROM EMPLOYEE
 WHERE SALARY > 3000000;

-- AND�ε� ���� (�̹� �ڹٿ��� ���� �߱⶧���� AND OR��  UNION���� ����)
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       BONUS "���ʽ� �Ǵ� �޿�"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5' AND SALARY > 3000000;


-- 4. MINUS
-- �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ����� �����ؼ� ��ȸ
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       SALARY "�޿�"
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5'
MINUS
SELECT EMP_ID, 
       EMP_NAME, 
       DEPT_CODE,
       SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;

-- �Ʒ��Ͱ��� �ٲ� �� ����
SELECT EMP_ID �����ȣ, 
       EMP_NAME ����̸�, 
       DEPT_CODE �μ��ڵ�, 
       SALARY �޿�
  FROM EMPLOYEE
 WHERE DEPT_CODE='D5' AND SALARY <= 3000000;
