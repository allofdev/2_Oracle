-- �Լ� ���� ����
-- 1. ������� �ֹι�ȣ�� ��ȸ
--    ��, �ֹι�ȣ 9��° �ڸ����� �������� '*' �� ä��
--    EX) 771120-1******
SELECT EMP_NAME "������", 
       SUBSTR(EMP_NO, 1, 8) || '******' "�ֹι�ȣ"
  FROM EMPLOYEE;


-- 2. ������, �����ڵ�, ���ʽ����Կ���(��) ��ȸ
--    ��, ���ʽ����Կ������� ���� NULL�� ���ͼ��� �ȵ�
--    �Ӹ��ƴ϶� ������ \57,000,000�� �������� ��ȸ�ǰ� ��
SELECT EMP_NAME "������", 
       JOB_CODE "�����ڵ�", 
       TO_CHAR((SALARY+(SALARY * NVL(BONUS, 0)))*12, 'L999,999,999') || '��' "���ʽ����Կ���(��)"
  FROM EMPLOYEE;

-- 3. �μ��ڵ尡 D5, D9�� ������ �� 2004�⿡ �Ի��� �������� 
--    ���, �����, �μ��ڵ�, �Ի��� ��ȸ
SELECT EMP_ID "���", 
       EMP_NAME "�����", 
       DEPT_CODE "�μ��ڵ�", 
       HIRE_DATE "�Ի���"
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D5', 'D9')
   AND EXTRACT(YEAR FROM HIRE_DATE)=2004;

-- �Ʒ�ó���� ����
SELECT EMP_ID "���", 
       EMP_NAME "�����", 
       DEPT_CODE "�μ��ڵ�", 
       HIRE_DATE "�Ի���"
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D5', 'D9')
   AND SUBSTR(HIRE_DATE, 1, 2)='04';  -- DATE���ĵ� SUBSTR�Լ� ��밡��������


-- 4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--    ��, �ٹ��ϼ��� �ָ��� �����ؼ�
SELECT EMP_NAME "������", 
       HIRE_DATE "�Ի���", 
       LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 "�Ի��� ���� �ٹ��ϼ�"
  FROM EMPLOYEE;
-- �Ի糯�� �ٹ��ϼ��� �����ϰ� ������ +1, �ƴϸ� ���ص���


-- 5. ������, �μ��ڵ�, ������� ��ȸ
--    ��, ��������� XX�� XX�� XX�� �������� ��ȸ�ǰ� ��
--    ��!!! ����� 200, 201, 214�� �ƴ� �����θ� ��ȸ�Ͻÿ�!!
--    (�ֳĸ�... 200, 201, 214�� ������� �ֹι�ȣ�� ������� ���� ��¥�� �̻���....�..)
SELECT EMP_NAME "������", 
       DEPT_CODE "�μ��ڵ�",
       SUBSTR(EMP_NO, 1, 2) || '�� ' ||
       SUBSTR(EMP_NO, 3, 2) || '�� ' || 
       SUBSTR(EMP_NO, 5, 2) || '�� ' "�������"      -- ���� SUBSTR�� �����Ѱ� ��������ִ� ���
  FROM EMPLOYEE
 WHERE EMP_ID NOT IN (200, 201, 214); -- �� ���� ������ ����� ��ȸ�ȵ�!!
 
-- �Ʒ������ ���� (������Ϻκи� ������ ���ڿ��� DATE�������� ��ȯ�� �ٽ� ���������ؼ� CHARACTER��������)
SELECT EMP_NAME "������", 
       DEPT_CODE "�μ��ڵ�",
       TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'), 'YY"��" MM"��" DD"��"') "�������"
  FROM EMPLOYEE
 WHERE EMP_ID NOT IN (200, 201, 214); -- �� ���� ������ ����� ��ȸ�ȵ�!!


-- 6. ������, �μ��ڵ�, �μ��� ��ȸ
--    (�μ����� �ش� �μ��ڵ尡 D5�� ��� �ѹ���, D6�� ��� ��ȹ��, D9�� ��� �����η� ��ȸ�ǰԲ�)
--    ��, �μ��ڵ尡 D5, D6, D9�� ����鸸 ��ȸ�Ͻÿ�.
--    => CASE WHEN�� ����غ���, DECODE�� ����غ���
SELECT EMP_NAME "������", 
       DEPT_CODE "�μ��ڵ�",
       CASE
            WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
            WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
            WHEN DEPT_CODE = 'D9' THEN '������'
        END "�μ���"
  FROM EMPLOYEE  
 WHERE DEPT_CODE IN('D5', 'D6', 'D9');

-- �Ʒ��� DECODE �Լ� ���
SELECT EMP_NAME "������", 
       DEPT_CODE "�μ��ڵ�",
       DECODE(DEPT_CODE, 'D5', '�ѹ���', 'D6', '��ȹ��', 'D9', '������') "�μ���"
  FROM EMPLOYEE  
 WHERE DEPT_CODE IN('D5', 'D6', 'D9');
