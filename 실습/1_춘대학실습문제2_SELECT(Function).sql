--�� ���б� ��ũ�� ����
--SQL02_SELECT(Function)

-- 1��
-- ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL������ �ۼ��Ͻÿ�.
-- (��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� �Ѵ�.)
SELECT STUDENT_NO �й�, STUDENT_NAME �̸�, ENTRANCE_DATE ���г⵵
  FROM TB_STUDENT
 WHERE DEPARTMENT_NO = 002
 ORDER BY ENTRANCE_DATE;


-- 2��
-- �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL������ �ۼ��غ���.
-- (*�̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��) 
SELECT PROFESSOR_NAME, PROFESSOR_SSN
  FROM TB_PROFESSOR
 WHERE PROFESSOR_NAME NOT LIKE '___';


-- 3��
-- �� ������б��� ���� �������� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. �� �̶� ���̰� ���� ������� ���� ��� ����
-- (���̰� ���ٸ� �̸��� ������ ����)�� ȭ�鿡 ��µǵ��� ����ÿ�.
-- (��, ���� �� 2000�� ���� ����ڴ� ������ ��� ����� "�����̸�"���� �Ѵ�. ���̴� '��'���� ����Ѵ�.)
SELECT PROFESSOR_NAME �����̸�, 
       FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(PROFESSOR_SSN, 1, 2), 'YYYY')) /12) ����
  FROM TB_PROFESSOR
 WHERE SUBSTR(PROFESSOR_SSN, '8', '1') = '1'
 ORDER BY 2 ;


-- 4��
-- �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� ����� "�̸�"�� �������� �Ѵ�.
-- (���� 2���� ����� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME, 2, 2)
  FROM TB_PROFESSOR
 WHERE PROFESSOR_NAME LIKE'___';


-- 5��
-- �� ������б��� ����� ������ �й��� �̸��� ǥ���Ͻÿ�.(�̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ ����)
-- �������� �䱸�ϴ� ������ ������ ������� ��� ������ ������� �߷����� �� (������� ������ ����� 245��)
-- 0301���� ������ �л��� ���ܽ�Ű�� ���� 19 �ʰ� 20 ���϶�� ���ǽ� ���
SELECT * FROM TB_STUDENT;
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD'))/12 > 19
  AND MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD'))/12 <= 20;


-- 6��
-- 2020�� ũ���������� ���� �����ΰ�?
--'DAY': �ݿ��� 'DY': �� 'D': 6
SELECT TO_CHAR(TO_DATE('20/12/25', 'YY/MM/DD'), 'DAY') 
FROM DUAL;


-- 7��
-- TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')�� ���� �� �� �� �� �� ���� �ǹ��ұ�?
-- �� TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')�� ���� �� �� �� �� �� ���� �ǹ��ұ�?
-- YY�� ��� 2000���
-- RR�� 49���ϴ� 2000��� 50�̻��� 1900���
SELECT TO_DATE('99/10/11', 'YY/MM/DD'), -- 2099��
       TO_DATE('49/10/11', 'YY/MM/DD'), -- 2049��
       TO_DATE('99/10/11', 'RR/MM/DD'), -- 1999��
       TO_DATE('49/10/11', 'YY/MM/DD')  -- 2049��
  FROM DUAL;

-- 8��
-- �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�. 
-- 2000�⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO �й�, STUDENT_NAME �̸�
  FROM TB_STUDENT
 WHERE TO_CHAR(ENTRANCE_DATE, 'RRRR') < '2000';


-- 9��
-- �й��� A517178�� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ��, �̶� ��� ȭ���� ����� "����"�̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ���ڸ������� ǥ���Ѵ�.
SELECT ROUND(AVG(POINT),1) ����
  FROM TB_GRADE
 GROUP BY STUDENT_NO
HAVING STUDENT_NO = 'A517178';


-- 10��
-- �а��� �л� ���� ���Ͽ� "�а���ȣ", "�л���(��)"�� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO, COUNT(*)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;


-- 11��
-- ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ��� �˾Ƴ��� SQL���� �ۼ��Ͻÿ�
SELECT COACH_PROFESSOR_NO, COUNT(*)
FROM TB_STUDENT
GROUP BY COACH_PROFESSOR_NO
HAVING COACH_PROFESSOR_NO IS NULL;


-- 12��
-- �й��� A112113�� ���� �л��� �⵵ �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ��, �̶� ���ȭ���� ����� "�⵵", "�⵵ �� ����"�̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ���ڸ������� ǥ���Ѵ�.
SELECT SUBSTR(TERM_NO, 1, 4) �⵵, ROUND(AVG(POINT), 1) "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4);


-- 13��
-- �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL������ �ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO �а��ڵ��, COUNT(DECODE(ABSENCE_YN , 'Y', 1, NULL)) "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;
-- COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) �� �ο�����
-- ���� ABSENCE_YN�� ���� 'Y'���� ��� COUNT(1)�� �Ǿ� ������ ���� �ǰ�
--     ABSENCE_YN�� ���� 'Y'�� �ƴϿ��� ��� COUNT(NULL)�� �Ǿ� ������ ���� �ʰԵǴ� ����!!


-- 14��
-- �� ���б��� �ٴϴ� �������� �л����� �̸��� ã���� �Ѵ�.
-- � SQL ������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME "���� �̸�", COUNT(*) "�������� ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;

-- 15��
-- �й��� A112113�� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ����, �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT SUBSTR(TERM_NO, 1, 4) �⵵,
       SUBSTR(TERM_NO, 6, 1) �б�, 
       ROUND(AVG(POINT), 1) ����
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 6, 1))
ORDER BY �⵵;





