

-- 1. ������ �븮�̸鼭 ASIA������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;   -- JOB_CODE  DEPT_CODE
SELECT * FROM JOB;        -- JOB_CODE
SELECT * FROM DEPARTMENT; --           DEPT_ID  LOCATION_ID
SELECT * FROM LOCATION;   --                    LOCAL_CODE

-- >> ����Ŭ ����
SELECT E.EMP_ID ���, 
       E.EMP_NAME �����, 
       J.JOB_CODE ���޸�, 
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������,
       E.SALARY �޿�
  FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND J.JOB_NAME = '�븮'
   AND L.LOCAL_NAME LIKE 'ASIA_';

-- >> ANSI ����
SELECT E.EMP_ID ���, 
       E.EMP_NAME �����, 
       JOB_CODE ���޸�, 
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������,
       E.SALARY �޿�
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE J.JOB_NAME = '�븮' AND L.LOCAL_NAME LIKE 'ASIA%';

------------------------------------------------------------

-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--    �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;   -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;        --            JOB_CODE

-- >> ����Ŭ ����
SELECT EMP_NAME �����,
       EMP_NO �ֹι�ȣ,
       DEPT_TITLE �μ���,
       JOB_NAME ���޸�
  FROM EMPLOYEE E, DEPARTMENT D, JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND E.JOB_CODE = J.JOB_CODE
   AND E.EMP_NO LIKE '7%'
   AND SUBSTR(E.EMP_NO, 8, 1) = '2'
   AND E.EMP_NAME LIKE '��%'; 

-- >> ANSI ����
SELECT EMP_NAME �����,
       EMP_NO �ֹι�ȣ,
       DEPT_TITLE �μ���,
       JOB_NAME ���޸�
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J USING (JOB_CODE)
 WHERE E.EMP_NO LIKE '7%'
   AND SUBSTR(E.EMP_NO, 8 , 1) = '2'
   AND E.EMP_NAME LIKE '��%';

------------------------------------------------------------

-- 3. �̸��� '��'�ڰ� ����ִ� ��������
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE; -- JOB_CODE
SELECT * FROM JOB;      -- JOB_CODE

-- >> ����Ŭ ����
SELECT E.EMP_ID ���, 
       E.EMP_NAME �����, 
       J.JOB_NAME ���޸�
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND E.EMP_NAME LIKE '%��%';

-- >> ANSI ����
SELECT E.EMP_ID ���, 
       E.EMP_NAME �����, 
       J.JOB_NAME ���޸�
  FROM EMPLOYEE E
  JOIN JOB J USING(JOB_CODE)
 WHERE E.EMP_NAME LIKE '%��%';

------------------------------------------------------------

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;   -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB ;       --            JOB_CODE

-- >> ����Ŭ ����
SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       E.DEPT_CODE �μ��ڵ�,
       D.DEPT_TITLE �μ���
  FROM EMPLOYEE E, DEPARTMENT D, JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND E.JOB_CODE = J.JOB_CODE
   AND D.DEPT_TITLE LIKE '�ؿܿ���%��';

-- >> ANSI ����
SELECT E.EMP_NAME �����,
       J.JOB_NAME ���޸�,
       E.DEPT_CODE �μ��ڵ�,
       D.DEPT_TITLE �μ���
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J USING (JOB_CODE)
 WHERE D.DEPT_TITLE LIKE '�ؿܿ���%��';

------------------------------------------------------------

-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;    -- DEPT_CODE
SELECT * FROM DEPARTMENT;  -- DEPT_ID    LOCATION_ID
SELECT * FROM LOCATION;    --            LOCAL_CODE

-- >> ����Ŭ ����
SELECT E.EMP_NAME �����,
       E.BONUS ���ʽ�,
       E.SALARY * 12  ����,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������
  FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND E.BONUS IS NOT NULL;

-- >> ANSI ����
SELECT E.EMP_NAME �����,
       E.BONUS ���ʽ�,
       E.SALARY * 12  ����,
       D.DEPT_TITLE �μ���,
       L.LOCAL_NAME �ٹ�������
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE E.BONUS IS NOT NULL;

------------------------------------------------------------
-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�

-- >> ����Ŭ ����
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND E.DEPT_CODE IS NOT NULL;

-- >> ANSI ����
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE E.DEPT_CODE IS NOT NULL;

------------------------------------------------------------

-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� 
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
SELECT * FROM EMPLOYEE;   -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID    LOCATION_ID
SELECT * FROM LOCATION;   --            LOCAL_CODE   NATIONAL_CODE
SELECT * FROM NATIONAL;   --                         NATIONAL_CODE

-- >> ����Ŭ ����
SELECT E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
  FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
 WHERE E.DEPT_CODE = D.DEPT_ID 
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND (N.NATIONAL_NAME = '�ѱ�' OR N.NATIONAL_NAME = '�Ϻ�');

-- >> ANSI ����
SELECT E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATIONAL N USING (NATIONAL_CODE)
 WHERE N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

------------------------------------------------------------

-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�

-- >> ����Ŭ ����
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND BONUS IS NULL
   AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');

-- >> ANSI����
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
 WHERE BONUS IS NULL 
   AND JOB_CODE IN ('J4', 'J7');
   
------------------------------------------------------------

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �̶� ���п� �ش��ϴ� ����
--    �޿������ S1, S2�� ��� '���'
--    �޿������ S3, S4�� ��� '�߱�'
--    �޿������ S5, S6�� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�.
SELECT * FROM EMPLOYEE;  -- JOB_CODE  SALARY
SELECT * FROM JOB;       -- JOB_CODE  
SELECT * FROM SAL_GRADE; --           MIN_SAL/MAX_SEL

-- >> ����Ŭ ���� (DECODE ����غ���)
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       J.JOB_CODE ���޸�,
       S.SAL_LEVEL �޿����,
       DECODE(SAL_LEVEL, 'S1', '���', 'S2', '���', 'S3', '�߱�', 
                         'S4', '�߱�', 'S5', '�ʱ�', 'S6', '�ʱ�') ����
  FROM EMPLOYEE E, JOB J, SAL_GRADE S
 WHERE E.JOB_CODE = J.JOB_CODE 
   AND (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL); 

-- >> ANSI ���� (CASE ����غ���)
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       JOB_CODE ���޸�,
       S.SAL_LEVEL �޿����,
       CASE WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '���'
            WHEN S.SAL_LEVEL IN ('S3', 'S4') THEN '�߱�'
            WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '�ʱ�'
       END ����
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

------------------------------------------------------------

-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �̶�, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�

-- >> ����Ŭ ����
SELECT D.DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- >> ANSI ����
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

------------------------------------------------------------
-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��)�� ��ȸ�Ͻÿ�.
--      ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�.

-- >> ����Ŭ ����
SELECT DEPT_TITLE ,FLOOR(AVG(SALARY))
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+)
GROUP BY DEPT_TITLE;



-- >> ANSI ����
SELECT DEPT_TITLE, ROUND(AVG(SALARY), 0)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;













