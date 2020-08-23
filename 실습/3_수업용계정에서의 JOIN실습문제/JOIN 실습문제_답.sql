------------------------------------- JOIN ���� �ǽ� ���� -------------------------------------

-- 1. ������ �븮�̸鼭 ASIA������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME �����, 
       JOB_NAME ���޸�, DEPT_TITLE �μ���, 
       LOCAL_NAME �ٹ�������, SALARY �޿�
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND J.JOB_NAME = '�븮'
  AND LOCAL_NAME LIKE 'ASIA%';
  
-- >> ANSI ����
SELECT EMP_ID ���, EMP_NAME �����, 
       JOB_NAME ���޸�, DEPT_TITLE �μ���, 
       LOCAL_NAME �ٹ�������, SALARY �޿�
FROM EMPLOYEE E
JOIN JOB J ON(J.JOB_CODE = E.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE JOB_NAME = '�븮' 
  AND LOCAL_NAME LIKE 'ASIA%';
  

-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--    �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE
  AND SUBSTR(E.EMP_NO, 1, 1) = 7
  AND SUBSTR(E.EMP_NO, 8, 1) = 2
  AND E.EMP_NAME LIKE '��%';
  
-- >> ANSI ����
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(E.EMP_NO, 1, 1) = 7
  AND SUBSTR(E.EMP_NO, 8, 1) = 2
  AND E.EMP_NAME LIKE '��%';

-- 3. �̸��� '��'�ڰ� ����ִ� ��������
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
  AND EMP_NAME LIKE '%��%';

-- >> ANSI ����
SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_NAME �����, JOB_NAME ���޸�, DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE
  AND DEPT_TITLE LIKE '�ؿܿ���%';

-- >> ANSI ����
SELECT EMP_NAME �����, JOB_NAME ���޸�, DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_NAME �����, BONUS ���ʽ�, SALARY*12 ����, 
       DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND BONUS IS NOT NULL;

-- >> ANSI ����
SELECT EMP_NAME �����, BONUS ���ʽ�, SALARY*12 ����, 
       DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;


-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_NAME �����, JOB_NAME ���޸�, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE;

-- >> ANSI ����
SELECT EMP_NAME �����, JOB_NAME ���޸�, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);


-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� 
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_NAME �����, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������, NATIONAL_NAME �ٹ�������
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND L.NATIONAL_CODE = N.NATIONAL_CODE
  AND N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

-- >> ANSI ����
SELECT EMP_NAME �����, DEPT_TITLE �μ���, LOCAL_NAME �ٹ�������, NATIONAL_NAME �ٹ�������
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');


-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT EMP_NAME �����, JOB_NAME ���޸�, SALARY �޿�
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.BONUS IS NULL
  AND E.JOB_CODE IN ('J4', 'J7');

-- >> ANSI ����
SELECT EMP_NAME �����, JOB_NAME ���޸�, SALARY �޿�
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE)
WHERE E.BONUS IS NULL
  AND E.JOB_CODE IN ('J4', 'J7');

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �̶� ���п� �ش��ϴ� ����
--    �޿������ S1, S2�� ��� '���'
--    �޿������ S3, S4�� ��� '�߱�'
--    �޿������ S5, S6�� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�.
-- >> ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�, SAL_LEVEL �޿����,
       CASE WHEN SAL_LEVEL IN ('S1', 'S2') THEN '���'
            WHEN SAL_LEVEL IN ('S3', 'S4') THEN '�߱�'
            WHEN SAL_LEVEL IN ('S5', 'S6') THEN '�ʱ�'
        END ����
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;

-- >> ANSI ����
SELECT EMP_ID ���, EMP_NAME �����, JOB_NAME ���޸�, SAL_LEVEL �޿����,
       CASE WHEN SAL_LEVEL IN ('S1', 'S2') THEN '���'
            WHEN SAL_LEVEL IN ('S3', 'S4') THEN '�߱�'
            WHEN SAL_LEVEL IN ('S5', 'S6') THEN '�ʱ�'
        END ����
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �̶�, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
-- >> ����Ŭ ����
SELECT DEPT_TITLE �μ���, SUM(SALARY) �޿���
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- >> ANSI ����
SELECT DEPT_TITLE �μ���, SUM(SALARY) �޿���
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��)�� ��ȸ�Ͻÿ�.
--      ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�.
-- >> ����Ŭ ����
SELECT DEPT_TITLE �μ���, FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE;

-- >> ANSI ����
SELECT DEPT_TITLE �μ���, FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE;