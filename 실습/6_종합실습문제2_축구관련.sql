SELECT * FROM USER_TABLES;
SELECT * FROM PLAYER;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;
SELECT * FROM SCHEDULE;


--1. PLAYER ���̺��� K02, K05 ���� �ش��ϴ� �������� �̸��� ������, ���ȣ, Ű�� ��ȸ�Ͻÿ�.
SELECT PLAYER_NAME �̸�, POSITION ������, BACK_NO ���ȣ, HEIGHT Ű
  FROM PLAYER
 WHERE TEAM_ID IN ('K02', 'K05');

--2. PLAYER ���̺��� ������ ��õ� �������� �̸��� ������ ��ȸ�Ͻÿ�.
SELECT PLAYER_NAME �̸�, NATION ����
  FROM PLAYER
 WHERE NATION IS NOT NULL;

--3. PLAYER ���̺��� ��ID�� K02�̰ų� K07�� �������� �̸��� ������, ���ȣ, ��ID, Ű�� ��ȸ�Ͻÿ�.
SELECT PLAYER_NAME �̸�, POSITION ������, BACK_NO ���ȣ, TEAM_ID ��ID, HEIGHT Ű
  FROM PLAYER
 WHERE TEAM_ID IN ('K02', 'K07');

--4. TEAM ���̺��� �� ���� �����ȣ �� ���� '-' �����ڷ� ���Ͽ� ��ID�� �����ȣ ������ ��ȸ�Ͻÿ�.
SELECT TEAM_ID ��ID, ZIP_CODE1 || '-' ||ZIP_CODE2 �����ȣ 
  FROM TEAM;

--5. PLAYER ���̺��� ��� �������� �ο� ���� ���� ũ�Ⱑ ��ϵ� ������ ��, �ִ� ����� �ּ� ����, ��� ������
--   ������ ��ȸ�Ͻÿ�.
SELECT COUNT(HEIGHT) "��ϵ� ������ ��", MAX(HEIGHT) "�ִ� ����", MIN(HEIGHT) "�ּ� ����", ROUND(AVG(HEIGHT), 1) "��� ����"
  FROM PLAYER
 WHERE HEIGHT IS NOT NULL;

--6. PLAYER ���̺��� Ȱ���Ͽ� �� �� �� �ο����� ��ȸ�ϴ� SQL�� �ۼ��ϵ� ������
--   �ο� �� �������� �������� �����Ͽ� ��ȸ �Ͻÿ�.
SELECT TEAM_ID ��ID, COUNT(*) "�� �� �ο���"
  FROM PLAYER
  GROUP BY TEAM_ID
  ORDER BY 2 DESC;

--7. PLAYER�� TEAM ���̺��� Ȱ���Ͽ� �� ������ �̸��� �Ҽ������� ��ȸ �Ͻÿ�.
SELECT * FROM PLAYER; -- TEAM_ID
SELECT * FROM TEAM;   -- TEAM_ID
-- >> ����Ŭ ����
SELECT P.PLAYER_NAME "���� �̸�", T.REGION_NAME || ' ' || T.TEAM_NAME "�Ҽ�����"
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID;
-- >> ANSI ����
SELECT P.PLAYER_NAME "���� �̸�", T.REGION_NAME || ' ' || T.TEAM_NAME "�Ҽ�����"
FROM PLAYER P
JOIN TEAM T USING (TEAM_ID);

--8. PLAYER, TEAM, STADIUM ���̺��� Ȱ���Ͽ� �� �������� ���� ��
--   ������, ������, �����, ����, Ȩ����� ���� ��ȸ�Ͻÿ�.
SELECT * FROM PLAYER;  -- TEAM_ID
SELECT * FROM TEAM;    -- TEAM_ID
SELECT * FROM STADIUM; -- HOMETEAM_ID
-- >> ����Ŭ ����
SELECT P.PLAYER_NAME ������, P.POSITION ������, P.NATION �����, T.TEAM_NAME, S.STADIUM_NAME Ȩ�����
  FROM PLAYER P, TEAM T, STADIUM S
 WHERE P.TEAM_ID = T.TEAM_ID
   AND T.TEAM_ID = S.HOMETEAM_ID;
-- >> ANSI ����
SELECT P.PLAYER_NAME ������, P.POSITION ������, P.NATION �����, T.TEAM_NAME, S.STADIUM_NAME Ȩ�����
  FROM PLAYER P
  JOIN TEAM T USING (TEAM_ID)
  JOIN STADIUM S ON (TEAM_ID = S.HOMETEAM_ID);

--9. TEAM, STADIUM ���̺��� Ȱ���Ͽ� �� ���� �̸��� �����ID, �������� ��ȸ�ϵ�
--   �����ID�� �����ϴ� ���� ��ȸ �ϰ� ����� ����� ���� �������� ������ �ǵ��� ��ȸ�Ͻÿ�.
SELECT * FROM TEAM;    -- TEAM_ID
SELECT * FROM STADIUM; -- HOMETEAM_ID
-- >> ����Ŭ ����
SELECT T.TEAM_NAME ���̸�
     , S.STADIUM_ID �����ID
     , S.STADIUM_NAME ������
  FROM TEAM T, STADIUM S
 WHERE T.TEAM_ID = S.HOMETEAM_ID
 ORDER BY 1;
-- >> ANSI ����
SELECT T.TEAM_NAME ���̸�
     , S.STADIUM_ID �����ID
     , S.STADIUM_NAME ������
  FROM TEAM T
  JOIN STADIUM S ON (T.TEAM_ID = S.HOMETEAM_ID);

--10. PLAYER ���̺��� Ȱ���Ͽ� ���� ũ�Ⱑ ��� ������ ���� ������ ��� �̻���
--    �������� ������, ������, ���ȣ�� �����̸� ���� ������������ ��ȸ�Ͻÿ�.
SELECT PLAYER_NAME ������, POSITION ������, BACK_NO ���ȣ
  FROM PLAYER
 WHERE HEIGHT >= (SELECT AVG(HEIGHT)
                    FROM PLAYER);

--11. ���� �� '������'��� ���������� ���� ���� �ѱ� ��Ī�� ���� ��Ī, �Ҽ� ������ ��ȸ�Ͻÿ�.
-- >> ����Ŭ ����
SELECT * FROM PLAYER;
SELECT PLAYER_NAME ������
     , E_PLAYER_NAME "���� ������"
     , NATION, TEAM_ID ��ID --��ID�� ��ȸ��
  FROM PLAYER
 WHERE TEAM_ID IN (SELECT TEAM_ID
                     FROM PLAYER
                    WHERE PLAYER_NAME = '������');

-- ***********************************************************************
--12. PLAYER ���̺��� �� ���� ���� ������ �� �Ҽӵ� ���� ��� ���庸�� ���� ���̰� ����
--    �������� ����, ������, ������, ���ȣ, ���� ���̸� ��ȸ�Ͻÿ�.
SELECT TEAM_NAME ����, PLAYER_NAME ������, POSITION ������, BACK_NO ���ȣ, HEIGHT �������
FROM PLAYER
JOIN TEAM USING (TEAM_ID)
WHERE (TEAM_ID) IN (SELECT TEAM_ID
                    FROM PLAYER
                    GROUP BY TEAM_ID)
AND (HEIGHT) <= ANY (SELECT AVG(HEIGHT)
                     FROM PLAYER
                     GROUP BY TEAM_ID);

--13. ������ �̸��� ������, ���ȣ, ��ID, ������ ��ȸ�ϴ� ��(V_TEAM_PLAYER)�� �ϳ� ������ ��
--     ������ �並 Ȱ���Ͽ� 'Ȳ'������ ���� �������� ������ ��ȸ�Ͻÿ�.
-- (�����ڰ������� GRANT CREATE VIEW TO SOCCERWORK �� ���� �ο�����)
CREATE OR REPLACE VIEW V_TEAM_PLAYER
AS (SELECT PLAYER_NAME, POSITION, BACK_NO, TEAM_ID, TEAM_NAME
    FROM PLAYER
    JOIN TEAM USING (TEAM_ID));

SELECT *
FROM V_TEAM_PLAYER
WHERE PLAYER_NAME LIKE 'Ȳ%';

-- ***********************************************************************
--14. ��� ���� ���� '����ȣ' ������ ���� ���ԵǾ���.
--     �ش� ������ ���� �� �������� DF�̸� 1987�� 3�� 16�ϻ�, ����� �����԰� ���� 176cm, 75kg���� 
--     �����ٰ� ���� ��, ����ȣ ������ ����ID�� ���� ������ �� ���� ū ���ڸ� ���� �������� 
--     ���ڸ� �ϳ� �������� �߰��� �� �ִ� ������ �ۼ��Ͻÿ�.
INSERT INTO PLAYER 
VALUES((SELECT MAX(PLAYER_ID) + 1 FROM PLAYER)
      , '����ȣ'
      , 'K01'
      , NULL
      , NULL
      , NULL
      , 'DF'
      , NULL
      , NULL
      , '1987/03/16'
      , NULL
      , '176'
      , '75');

SELECT * FROM PLAYER ORDER BY 1 DESC;

--15. SCHEDULE�� ��ϵ� ������ �� ���� ���� ���� ��ϵ� ������ ��¥�� ����� ��, 
--     HOME���� AWAY���� �� ��� �� ���� ����� ���� ���� ��ȸ�Ͻÿ�.
SELECT * FROM SCHEDULE;
SELECT * FROM STADIUM;
SELECT * FROM TEAM;

SELECT SCH1.SCHE_DATE ��⳯¥
     , STA.STADIUM_NAME "����� ��"
     , T1.TEAM_NAME HOME��
     , T2.TEAM_NAME AWAY��
     , SCH1.HOME_SCORE "HOME�� ��"
     , SCH1.AWAY_SCORE "AWAY�� ��"
  FROM SCHEDULE SCH1
  JOIN STADIUM STA USING (STADIUM_ID)
  JOIN TEAM T1 ON (T1.TEAM_ID = SCH1.HOMETEAM_ID) --Ȩ��
  JOIN TEAM T2 ON (T2.TEAM_ID = SCH1.AWAYTEAM_ID)--��������
 WHERE SCH1.HOME_SCORE + SCH1.AWAY_SCORE = ANY (SELECT MAX(SCH2.HOME_SCORE + SCH2.AWAY_SCORE) ��
                                                  FROM SCHEDULE SCH2);

--16. �ֱ� �ѱ� ���������� ������Ȳ�� �� ������ �� ���� �� ���� ������ 3�� ������ ������
--    �����ϰ� �Ǿ���. TEAM ���̺��� Ȱ���Ͽ� ���� �Ҽӵ� ������ 3�� ������ ������ ã��
--    �ش� �����͸� �����ϴ� ������ �ۼ��Ͻÿ�.
DELETE FROM TEAM
WHERE TEAM_ID IN (SELECT TEAM_ID
                    FROM PLAYER
                   GROUP BY TEAM_ID
                   HAVING COUNT(*)<=3);
-- ��������
ALTER TABLE PLAYER
DISABLE CONSTRAINT PLAYER_FK CASCADE;

SELECT * FROM TEAM;

COMMIT;