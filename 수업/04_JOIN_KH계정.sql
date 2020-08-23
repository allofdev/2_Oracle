/*
    < JOIN >
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� �������(�ߺ��� �ּ�ȭ�ϱ� ���ؼ�)
    => ��, JOIN������ ������ �����ͺ��̽����� �������� ���̺� "����"�� �δ� ���
    
    ������ JOIN�� �ؼ� ���� ��ȸ�� �ϴ°� �ƴ϶�
    ���̺� "�����"�� �÷� �����͸� "��Ī"���Ѽ� ��ȸ�ؾߵ�!!\
    
                                          [JOIN ��� ����]
                               
                       JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI(�̱� ����ǥ����ȸ) ����"
           
                   (����Ŭ DBSM������)                           (����Ŭ + �ٸ� DBMS������)
                       ����Ŭ ����                  |                    ANSI����
              -------------------------------------------------------------------------------
                  � ����(EQUAL JOIN)             |   ���� ���� (INNER JOIN) --> JOIN USING/ON 
                                                   |   �ڿ� ���� (NATURAL JOIN) --> JOIN USING(���ǾȾ�)
              -------------------------------------------------------------------------------
                       ���� ����                    |      ���� �ܺ� ���� (LEFT OUTER JOIN),
                     (LEFT OUTER)                  |    ������ �ܺ� ���� (RIGHT OUTER JOIN),
                     (RIGHT OUTER)                 | ��ü �ܺ� ���� (FULL OUTER JOIN, ����Ŭ �������� ��� �Ұ�)
              -------------------------------------------------------------------------------
                  ī�׽þ� �� (CARTESIAN PRODUCT)   |          ���� ���� (CROSS JOIN)
              -------------------------------------------------------------------------------
    ��ü ���� (SELF JOIN), ������(NON EQUAL JOIN)|            JOIN ON
              -------------------------------------------------------------------------------
*/

-- JOIN�� �� �� ���ε��� ȣ���ϸ� ���ؾߵ�..
-- �� ������� ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE
  FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
  FROM DEPARTMENT;

-- �� ������� ���, �����, �����ڵ�, ���޸��� ��ȸ�ϰ��� �� �� ?
SELECT EMP_ID, EMP_NAME, JOB_CODE
  FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
  FROM JOB;


-- ������ ���ؼ� ������� �ش��ϴ� �÷����� ����� ��Ī�� ���ָ� ���� �ϳ��� ������� ��ȸ����!!!
/*
    1. � ���� (EQUAL JOIN)  /  �������� (INNER JOIN)
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ(== ��ġ�ϴ� ���� ���� ���� ��ȸX)
    
    "=" ���� ���� �ϱ⶧���� ������̶�� �Ҹ�
*/


-->> ���� Ŭ���� ���� 
--   � ���� (EQUAL JOIN)
--   FROM ���� ��ȸ�ϰ��� �ϴ� ���̺���� ���� (, �����ڷ�)
--   WHERE ���� ��Ī��ų �÷���(�����)�� ���� ������ ������

-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE : DEPT_CODE   /   DEPARTMENT : DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
--> ��ü ������� 23�������� 21�� ��ȸ��
--> ��ġ���� �ʴ� ���� ��ȸ���� ���ܵ� �� Ȯ�� ����
-- (DEPT_CODE���� �μ��� ���� ���(NULL) 2���� ������ ��ȸ�ȵ�, ����� �ο����� ���� �μ��� D3,D4,D7�� �μ� ������ ��ȸ �ȵ�)
    --> NULL�̾ ��ȸ�� �ȵȰ� �ƴ϶� DEPT_ID�� ��ġ�ϴ� �������� NULL�� ���� ����

-- ���, �����, �����ڵ�, ���޸�
-- 1) ������ �� �÷����� ���� ��� (EMPLOYEE : JOB_CODE   /   JOB : JOB_CODE

--  ���1. ���̺���� �̿��Ѵ� ���
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
  FROM EMPLOYEE, JOB 
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
--> ������ ��Ȯ�ϰ� � ���̺��� ��þ��Ҷ� ���� 
--  ambiguouly : �ָ��ϴ�, ��ȣ�ϴ�

--  ���2. ��Ī �̿��ϴ� ��� (�� ���̺��� ��Ī �ο� ����)
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE;


-->> ANSI ����
-- FROM���� ���� ���̺��� �ϳ� ��� �� ��
-- �� �ڿ� JOIN������ ���� ��ȸ�ϰ����ϴ� ���̺� ��� (���� ��Ī��ų �÷��� ���� ����) => USING ����, ON ����

-- ���, �����, �μ��ڵ�, �μ���
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE : DEPT_CODE   /   DEPARTMENT : DEPT_ID)
--    => JOIN  ON ������ ��밡��!!!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
  FROM EMPLOYEE
--INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- INNER ���� ����
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ��ġ�ϴ� ��� (EMPLOYEE : JOB_CODE   / JOB : JOB_CODE)
--    => JOIN  USING ����, JOIN  ON ���� ��밡��!!!
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
  FROM EMPLOYEE  E
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE); -- ON ���� : ambiguously �߻�(���� ��Ī ������ߵ�)

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE); -- USING ���� : ambiguously �߻� X


-- [����] ���� ������ NATURAL JOIN(�ڿ�����)���ε� ���� (��� ���� �平) --
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE
NATURAL JOIN JOB; --> �˾Ƽ� �������� �÷��� ã�Ƽ� JOIN����


-- �߰����� ���ǵ� ���� ����!!!
-- ������ �븮�� ������ ���, �����, �޿�, ����

-->> ����Ŭ ���� (FROM���� ��ȸ�����̺�� ���, WHERE���� ��Ī��Ű�� ���Ǳ��)
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
  FROM EMPLOYEE E, JOB B
 WHERE E.JOB_CODE = B.JOB_CODE 
   AND JOB_NAME = '�븮';

-->> ANSI ���� (FROM���� ���̺��ϳ��� ���, JOIN���� �߰���ȸ�ϰ����ϴ� ���̺� �� ����(ON/USING))
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
  FROM EMPLOYEE E
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
 WHERE JOB_NAME = '�븮';

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '�븮';

---------------------------------< �ǽ� ���� >---------------------------------------
-- 1. �μ��� �λ�������� ������� ���, �����, ���ʽ��� ��ȸ
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, BONUS
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '�λ������';
-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE DEPT_TITLE = '�λ������';

-- 2. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �Ի��� ��ȸ
-->> ����Ŭ ����
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE != '�ѹ���';
-->> ANSI ����
SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE DEPT_TITLE != '�ѹ���';

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ����� ��ȸ
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;
-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE BONUS IS NOT NULL;

-- 4. �Ʒ��� �� ���̺� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME)�� ��ȸ
SELECT * FROM DEPARTMENT; -- LOCATION_ID
SELECT * FROM LOCATION;   -- LOCAL_CODE
-->> ����Ŭ ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
  FROM DEPARTMENT, LOCATION
 WHERE LOCATION_ID = LOCAL_CODE;
--> ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
  FROM DEPARTMENT
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);


-- ���, �����, �μ���, ���޸�
SELECT * FROM EMPLOYEE;   -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;        --            JOB_CODE

-->> ����Ŭ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE E, DEPARTMENT, JOB J
 WHERE DEPT_CODE = DEPT_ID 
   AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN JOB USING (JOB_CODE);

----------------------------------------------------------------------

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    
    ���̺��� JOIN�� ��ġ���� ���� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT/RIGHT�� �����ؾ߸� ��!! (������ �Ǵ� ���̺� ����)
*/

-- �����, �μ���, �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- EX) �޿��� �ֱ����� ��ȸ �Ͽ��µ� ��23���� 21�� ��ȸ��
-- �μ� ��ġ�� ���� ���� (DEPT_CODE���� NULL) 2���� ��������� ��ȸX
-- �μ��� ������ ����� ���� �μ�(D3, D4, D7) ���� ��쵵 ��ȸX

--> ���������� ����ߵ�
-- 1) LEFT [OUTER] JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); --OUTER�� INNER ó�� ���� ����
--> �μ��ڵ尡 ���� ���(�ϵ���, �̿���)�� �����͵� ��ȸ��!!
-- >> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- �������� ���� ���̺�(EMPLOYEE : DEPT_CODE)�� �ݴ� ���̺� �÷��� + ǥ��


-- 2) RIGHT [OUTER] JOIN
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- >> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; -- ���� �������� ���̺�(DEPARTMENT : DEPT_ID)�� �ݴ� ���̺� �÷��� + ǥ��


-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ���� (��, ����Ŭ�������� �ȵ�)
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- >> ����Ŭ ���� (������) --> ANSI���������� ��밡��!!!
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);


-----------------------------------------------------------------------------

/*             ����Ŭ                         ANSI
    3. ī�׽þ� �� (CARTESIAN PRODUCT) / �������� (CROSS JOIN)
    ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ (������)
    
    �� ���̺��� ����� ��� ������ ����� ������ ��� --> ����� ������ ��� --> ����ȭ�� ����
*/
-- �����, �μ���
-->> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; --> 23�� * 9�� => 207��

-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-----------------------------------------------------------------------------

/*
    4. ��ü ���� (SELF JOIN)
    
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
    �ڱ� �ڽŰ� ������ �δ� ��
*/
SELECT EMP_ID, EMP_NAME, SALARY, MANAGER_ID 
FROM EMPLOYEE;

-- ������ ����� ������, �����, ����μ��ڵ�, ������, �����
SELECT * FROM EMPLOYEE; -- ����� ���� ���̺� -- MANAGER_ID
SELECT * FROM EMPLOYEE; -- ����� ���� ���̺� -- EMP_ID


-->> ����Ŭ ����
SELECT E.EMP_ID �����ȣ, 
       E.EMP_NAME �����, 
       E.DEPT_CODE ����μ��ڵ�, 
       E.MANAGER_ID "����� ������", 
       M.EMP_NAME �����,
       M.DEPT_CODE ����μ��ڵ�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-->> ANSI����
SELECT E.EMP_ID ������, 
       E.EMP_NAME �����, 
       E.DEPT_CODE ����μ��ڵ�, 
       E.MANAGER_ID "����� ������", 
       M.EMP_NAME �����, 
       M.DEPT_CODE ����μ��ڵ�
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

------------------------------------------------------------------------

/*
    5. �� ���� (NON EQUAL JOIN)
    '='(��ȣ)�� ������� �ʴ� ���ι�
    
    ������ �÷����� ��ġ�ϴ� ��찡 �ƴ�, ���� "����"�� ���ԵǴ� ��� ��Ī
    
*/
-- �����, �޿�, ����
-- >> ����Ŭ ����
SELECT EMP_NAME �����, 
       SALARY �޿�, 
       SAL_LEVEL �޿����
  FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY < MAX_SAL AND SALARY > MIN_SAL;
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL; 

-- >> ANSI���� (�� ������ ON ������ ����!!)
SELECT EMP_NAME �����, 
       SALARY �޿�, 
       SAL_LEVEL �޿����
  FROM EMPLOYEE
  JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

------------------------------------------------------------------------
/*
    < ���� JOIN >
    
    N���� ���̺��� JOIN
*/

-- ���, �����, �μ���, �ٹ�������(LOCAL_NAME)
SELECT * FROM EMPLOYEE;   -- DEPT_CODE                JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID     LOCATION_ID
SELECT * FROM LOCATION;   --             LOCAL_CODE
SELECT * FROM JOB;        --                          JOB_CODE


-- >> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
  FROM EMPLOYEE, DEPARTMENT, LOCATION
 WHERE DEPT_CODE = DEPT_ID 
   AND LOCATION_ID = LOCAL_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, JOB_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN JOB USING (JOB_CODE);
--> ���� ������ ������ �߿�!!


-- ���, �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿����
SELECT * FROM EMPLOYEE;      DEPT_CODE               JOB_CODE                  SALARY
SELECT * FROM DEPARTMENT;    DEPT_ID   LOCATION_ID
SELECT * FROM JOB;                                   JOB_CODE
SELECT * FROM LOCATION;                LOCAL_CODE              NATIONAL_CODE
SELECT * FROM NATIONAL;                                        NATIONAL_CODE
SELECT * FROM SAL_GRADE;                                                      MIN_SAL, MAX_SAL

-- >> ����Ŭ ����
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       D.DEPT_TITLE �μ���,
       J.JOB_NAME ���޸�,
       L.LOCAL_NAME �ٹ�������,
       N.NATIONAL_NAME �ٹ�������,
       S.SAL_LEVEL �޿����
  FROM EMPLOYEE E, 
       DEPARTMENT D, 
       JOB J, 
       LOCATION L,
       NATIONAL N, 
       SAL_GRADE S
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND E.JOB_CODE = J.JOB_CODE
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND E.SALARY BETWEEN MIN_SAL AND MAX_SAL;


-- >> ANSI ����
-- ���, �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿����
SELECT * FROM EMPLOYEE;   DEPT_CODE  JOB_CODE                             SALARY
SELECT * FROM DEPARTMENT; DEPT_ID              LOCATION_ID
SELECT * FROM JOB;                   JOB_CODE
SELECT * FROM LOCATION;                        LOCAL_CODE  NATIONAL_CODE
SELECT * FROM NATIONAL;                                    NATIONAL_CODE
SELECT * FROM SAL_GRADE;                                                  MIN_SAL/MAX_SAL

SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       D.DEPT_TITLE �μ���,
       J.JOB_NAME ���޸�,
       L.LOCAL_NAME �ٹ�������,
       N.NATIONAL_NAME �ٹ�������,
       S.SAL_LEVEL �޿����
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J USING (JOB_CODE)
  JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATIONAL N USING (NATIONAL_CODE);

