SELECT * FROM USER_TABLES;

SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_BOOK_AUTHOR;

-- 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT BOOK_NO "å ��ȣ", BOOK_NM ������
  FROM TB_BOOK
 WHERE LENGTH(BOOK_NM) >= 25;

-- 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
--    �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT *
  FROM (SELECT WRITER_NM �۰��̸�
             , OFFICE_TELNO �繫����ȭ��ȣ
             , HOME_TELNO ����ȭ��ȣ
             , MOBILE_NO �޴�����ȭ��ȣ
          FROM TB_WRITER
         WHERE MOBILE_NO LIKE '019-%'
           AND WRITER_NM LIKE '��%'
         ORDER BY WRITER_NM)
 WHERE ROWNUM = 1;

-- 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
--    ���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT * FROM TB_WRITER;      -- WRITER_NO
SELECT * FROM TB_BOOK_AUTHOR; -- WRITER_NO

SELECT COUNT(DISTINCT WRITER_NM) "�۰�(��)"
FROM TB_WRITER
JOIN TB_BOOK_AUTHOR USING (WRITER_NO)
WHERE COMPOSE_TYPE = '�ű�';

-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(����
--    ���°� ��ϵ��� ���� ���� ������ ��)
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300;

-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT *
  FROM (SELECT BOOK_NM å�̸�
             , ISSUE_DATE ��������
             , PUBLISHER_NM ���ǻ��̸� 
          FROM TB_BOOK
         ORDER BY ISSUE_DATE DESC)
 WHERE ROWNUM = 1;

-- 8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--    ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)
SELECT * FROM TB_BOOK;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_AUTHOR;

SELECT *
  FROM (
        SELECT W.WRITER_NM "�۰� �̸�", COUNT(*) "�� ��"
        FROM TB_WRITER W
        JOIN TB_BOOK_AUTHOR BA USING (WRITER_NO)
        GROUP BY W.WRITER_NM
        ORDER BY 2 DESC
       )
WHERE ROWNUM <= 3;


-- 9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
--    ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_BOOK;

UPDATE TB_WRITER W
SET W.REGIST_DATE = (SELECT MIN(B.ISSUE_DATE)
                     FROM TB_BOOK B
                     JOIN TB_BOOK_AUTHOR BA USING (BOOK_NO)
                     WHERE W.WRITER_NO = BA.WRITER_NO);
COMMIT;

-- 10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
--     �� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--     (Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
--     ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)
SELECT * FROM TB_BOOK_AUTHOR;

CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10),
    WRITER_NO VARCHAR2(10),
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY (BOOK_NO, WRITER_NO),
    CONSTRAINT FK_BOOK_TRANSLATOR_01 FOREIGN KEY (BOOK_NO) REFERENCES TB_BOOK(BOOK_NO),
    CONSTRAINT FK_BOOK_TRANSLATOR_02 FOREIGN KEY (WRITER_NO) REFERENCES TB_WRITER(WRITER_NO)
);
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '�۰���ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '�������';

--11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
--���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
--������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
--�̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
INSERT
INTO TB_BOOK_TRANSLATOR(BOOK_NO, WRITER_NO)
    SELECT BOOK_NO, WRITER_NO
      FROM TB_BOOK_AUTHOR
     WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

DELETE
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

COMMIT;

--12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_WRITER;          -- WRITER_NO
SELECT * FROM TB_BOOK_TRANSLATOR; -- WRITER_NO  BOOK_NO
SELECT * FROM TB_BOOK;            --            BOOK_NO

SELECT B.BOOK_NM, W.WRITER_NM
FROM TB_WRITER W
JOIN TB_BOOK_TRANSLATOR BT USING (WRITER_NO)
JOIN TB_BOOK B USING (BOOK_NO)
WHERE EXTRACT(YEAR FROM B.ISSUE_DATE) = 2007;

--13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
--������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, ��������
--ǥ�õǵ��� �� ��)

--**�並 ����� ���ؼ��� �����ڰ������� ���Ѻο� �ؾߵ�!!! GRANT CREATE VIEW TO FINALWORK;**
CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS SELECT B.BOOK_NM, W.WRITER_NM, B.ISSUE_DATE
   FROM TB_WRITER W
   JOIN TB_BOOK_TRANSLATOR BT USING (WRITER_NO)
   JOIN TB_BOOK B USING (BOOK_NO)
   WHERE EXTRACT(YEAR FROM B.ISSUE_DATE) = 2007    
WITH CHECK OPTION;


--14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
--������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
--   ���ǻ�         �繫�� ��ȭ��ȣ         �ŷ�����
--  �� ���ǻ�        02-6710-3737      Default �� ���
INSERT INTO TB_PUBLISHER VALUES('�� ���ǻ�', '02-6710-3737', DEFAULT);

COMMIT;

--15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�.
SELECT WRITER_NM
     , COUNT(*)
  FROM TB_WRITER
 GROUP BY WRITER_NM
HAVING COUNT(*) > 1;


--16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
--NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
SELECT * FROM TB_BOOK_AUTHOR;
UPDATE TB_BOOK_AUTHOR
   SET COMPOSE_TYPE = '����'
 WHERE COMPOSE_TYPE IS NULL;

COMMIT;

--17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰���
--�̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT OFFICE_TELNO
  FROM TB_WRITER
 WHERE OFFICE_TELNO LIKE '02-___-%';

--18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * 
  FROM TB_WRITER
 WHERE ADD_MONTHS(REGIST_DATE, 12*31) <= TO_DATE(20060101, 'YYMMDD');

--19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
--���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
--�������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. 
SELECT BOOK_NM, PRICE, STOCK_QTY,
       CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�'
       ELSE '�ҷ�����'
       END
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
AND STOCK_QTY < 10;


--20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
--��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT * FROM TB_BOOK;             -- BOOK_NO
SELECT * FROM TB_BOOK_AUTHOR;      -- BOOK_NO   WRITER_NO   ����
SELECT * FROM TB_BOOK_TRANSLATOR;  -- BOOK_NO   WRITER_NO   ��  
SELECT * FROM TB_WRITER;           --           WRITER_NO

SELECT B.BOOK_NM
     , BAW.WRITER_NM
     , BTW.WRITER_NM
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR BA USING (BOOK_NO)
JOIN TB_BOOK_TRANSLATOR BT USING (BOOK_NO)
JOIN TB_WRITER BAW ON (BA.WRITER_NO = BAW.WRITER_NO)
JOIN TB_WRITER BTW ON (BT.WRITER_NO = BTW.WRITER_NO)
WHERE B.BOOK_NM = '��ŸƮ��';


--21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
--����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
--������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������
--������ ǥ�õǵ��� �� ��)

SELECT BOOK_NM "������"
     , STOCK_QTY "������"
     , PRICE "����(Org)"
     , PRICE*0.8 "����(New)"
  FROM TB_BOOk
 WHERE ADD_MONTHS(ISSUE_DATE, 12*30) <= SYSDATE
   AND STOCK_QTY >= 90
 ORDER BY 2 DESC
        , 4 DESC
        , 1;