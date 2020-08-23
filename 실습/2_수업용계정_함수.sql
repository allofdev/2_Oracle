/**/-- KH ���� (������ ����) ���� �Լ� �ǽ� --

-- 1. ������� �ֹι�ȣ�� ��ȸ
-- ��, �ֹι�ȣ 9��° �ڸ����� �������� '*' �� ä��
-- EX) 771120-1******
SELECT EMP_NAME ������, RPAD(SUBSTR(EMP_NO, 1, 8),14, '*') �ֹι�ȣ 
FROM EMPLOYEE;


-- 2. ������, �����ڵ�, ���ʽ����Կ���(��) ��ȸ
--    ��, ���ʽ����Կ������� ���� NULL�� ���ͼ��� �ȵ�
--    �Ӹ��ƴ϶� ������ \57,000,000�� �������� ��ȸ�ǰ� ��
SELECT EMP_NAME ������, 
       JOB_CODE �����ڵ�, 
       TO_CHAR((SALARY * NVL(BONUS, 0) + SALARY) * 12, 'L99,999,999,999')||'��' "���ʽ����Կ���(��)"
FROM EMPLOYEE;


-- 3. �μ��ڵ尡 D5, D9�� ������ �� 2004�⿡ �Ի��� �������� ���, �����, �μ��ڵ�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'RRRR') = 2004
  AND DEPT_CODE IN('D5', 'D9');


-- 4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--    ��, �ٹ��ϼ��� �ָ��� �����ؼ�
SELECT EMP_NAME ������, 
       HIRE_DATE �Ի���,
       TO_CHAR(LAST_DAY(HIRE_DATE), 'DD') - TO_CHAR(HIRE_DATE, 'DD') +1
FROM EMPLOYEE;
-- �Ի糯�� �ٹ��ϼ��� �����ϰ� ������ +1, �ƴϸ� ���ص���


-- 5. ������, �μ��ڵ�, ������� ��ȸ
--    ��, ��������� XX�� XX�� XX�� �������� ��ȸ�ǰ� ��
--    ��!!! ����� 200, 201, 214�� �ƴ� �����θ� ��ȸ�Ͻÿ�!!
--    (�ֳĸ�... 200, 201, 214�� ������� �ֹι�ȣ�� ������� ���� ��¥�� �̻���....�..)
SELECT EMP_NAME ������, 
       DEPT_CODE �μ��ڵ�,
       SUBSTR(EMP_NO, 1, 2) || '�� ' || SUBSTR(EMP_NO, 3, 2) || '�� ' || SUBSTR(EMP_NO, 5, 2) || '��'
FROM EMPLOYEE
WHERE EMP_ID NOT IN(200, 201, 204);


-- 6. ������, �μ��ڵ�, �μ��� ��ȸ
--    (�μ����� �ش� �μ��ڵ尡 D5�� ��� �ѹ���, D6�� ��� ��ȹ��, D9�� ��� �����η� ��ȸ�ǰԲ�)
--    ��, �μ��ڵ尡 D5, D6, D9�� ����鸸 ��ȸ�Ͻÿ�.
--   => CASE WHEN�� ����غ���, DECODE�� ����غ���
-->> 
SELECT EMP_NAME, DEPT_CODE, DECODE(DEPT_CODE, 'D5', '�ѹ���', 'D6', '��ȹ��', 'D9', '������')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');




