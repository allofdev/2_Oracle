SELECT * FROM USER_TABLES;
SELECT * FROM PLAYER;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;
SELECT * FROM SCHEDULE;


--1. PLAYER 테이블에서 K02, K05 팀에 해당하는 선수들의 이름과 포지션, 등번호, 키를 조회하시오.
SELECT PLAYER_NAME 이름, POSITION 포지션, BACK_NO 등번호, HEIGHT 키
  FROM PLAYER
 WHERE TEAM_ID IN ('K02', 'K05');

--2. PLAYER 테이블에서 국적이 명시된 선수들의 이름과 국적을 조회하시오.
SELECT PLAYER_NAME 이름, NATION 국적
  FROM PLAYER
 WHERE NATION IS NOT NULL;

--3. PLAYER 테이블에서 팀ID가 K02이거나 K07인 선수들의 이름과 포지션, 등번호, 팀ID, 키를 조회하시오.
SELECT PLAYER_NAME 이름, POSITION 포지션, BACK_NO 등번호, TEAM_ID 팀ID, HEIGHT 키
  FROM PLAYER
 WHERE TEAM_ID IN ('K02', 'K07');

--4. TEAM 테이블에서 각 팀의 우편번호 두 개를 '-' 구분자로 합하여 팀ID와 우편번호 조합을 조회하시오.
SELECT TEAM_ID 팀ID, ZIP_CODE1 || '-' ||ZIP_CODE2 우편번호 
  FROM TEAM;

--5. PLAYER 테이블에서 모든 선수들의 인원 수와 신장 크기가 등록된 선수의 수, 최대 신장과 최소 신장, 평균 신장의
--   정보를 조회하시오.
SELECT COUNT(HEIGHT) "등록된 선수의 수", MAX(HEIGHT) "최대 신장", MIN(HEIGHT) "최소 신장", ROUND(AVG(HEIGHT), 1) "평균 신장"
  FROM PLAYER
 WHERE HEIGHT IS NOT NULL;

--6. PLAYER 테이블을 활용하여 각 팀 별 인원수를 조회하는 SQL을 작성하되 정렬은
--   인원 수 기준으로 내림차순 정렬하여 조회 하시오.
SELECT TEAM_ID 팀ID, COUNT(*) "팀 별 인원수"
  FROM PLAYER
  GROUP BY TEAM_ID
  ORDER BY 2 DESC;

--7. PLAYER와 TEAM 테이블을 활용하여 각 선수의 이름과 소속팀명을 조회 하시오.
SELECT * FROM PLAYER; -- TEAM_ID
SELECT * FROM TEAM;   -- TEAM_ID
-- >> 오라클 구문
SELECT P.PLAYER_NAME "선수 이름", T.REGION_NAME || ' ' || T.TEAM_NAME "소속팀명"
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID;
-- >> ANSI 구문
SELECT P.PLAYER_NAME "선수 이름", T.REGION_NAME || ' ' || T.TEAM_NAME "소속팀명"
FROM PLAYER P
JOIN TEAM T USING (TEAM_ID);

--8. PLAYER, TEAM, STADIUM 테이블을 활용하여 각 선수들의 정보 중
--   선수명, 포지션, 출신지, 팀명, 홈경기장 명을 조회하시오.
SELECT * FROM PLAYER;  -- TEAM_ID
SELECT * FROM TEAM;    -- TEAM_ID
SELECT * FROM STADIUM; -- HOMETEAM_ID
-- >> 오라클 구문
SELECT P.PLAYER_NAME 선수명, P.POSITION 포지션, P.NATION 출신지, T.TEAM_NAME, S.STADIUM_NAME 홈경기장
  FROM PLAYER P, TEAM T, STADIUM S
 WHERE P.TEAM_ID = T.TEAM_ID
   AND T.TEAM_ID = S.HOMETEAM_ID;
-- >> ANSI 구문
SELECT P.PLAYER_NAME 선수명, P.POSITION 포지션, P.NATION 출신지, T.TEAM_NAME, S.STADIUM_NAME 홈경기장
  FROM PLAYER P
  JOIN TEAM T USING (TEAM_ID)
  JOIN STADIUM S ON (TEAM_ID = S.HOMETEAM_ID);

--9. TEAM, STADIUM 테이블을 활용하여 각 팀의 이름과 경기장ID, 경기장명을 조회하되
--   경기장ID가 존재하는 팀만 조회 하고 결과는 경기장 명이 오름차순 정렬이 되도록 조회하시오.
SELECT * FROM TEAM;    -- TEAM_ID
SELECT * FROM STADIUM; -- HOMETEAM_ID
-- >> 오라클 구문
SELECT T.TEAM_NAME 팀이름
     , S.STADIUM_ID 경기장ID
     , S.STADIUM_NAME 경기장명
  FROM TEAM T, STADIUM S
 WHERE T.TEAM_ID = S.HOMETEAM_ID
 ORDER BY 1;
-- >> ANSI 구문
SELECT T.TEAM_NAME 팀이름
     , S.STADIUM_ID 경기장ID
     , S.STADIUM_NAME 경기장명
  FROM TEAM T
  JOIN STADIUM S ON (T.TEAM_ID = S.HOMETEAM_ID);

--10. PLAYER 테이블을 활용하여 신장 크기가 모든 선수의 신장 길이의 평균 이상인
--    선수들의 선수명, 포지션, 등번호를 선수이름 기준 오름차순으로 조회하시오.
SELECT PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 등번호
  FROM PLAYER
 WHERE HEIGHT >= (SELECT AVG(HEIGHT)
                    FROM PLAYER);

--11. 선수 중 '정현수'라는 동명이인이 속한 팀의 한글 명칭과 영문 명칭, 소속 지역을 조회하시오.
-- >> 오라클 구문
SELECT * FROM PLAYER;
SELECT PLAYER_NAME 선수명
     , E_PLAYER_NAME "영문 선수명"
     , NATION, TEAM_ID 팀ID --팀ID도 조회함
  FROM PLAYER
 WHERE TEAM_ID IN (SELECT TEAM_ID
                     FROM PLAYER
                    WHERE PLAYER_NAME = '정현수');

-- ***********************************************************************
--12. PLAYER 테이블에서 각 팀에 속한 선수들 중 소속된 팀의 평균 신장보다 신장 길이가 작은
--    선수들의 팀명, 선수명, 포지션, 등번호, 신장 길이를 조회하시오.
SELECT TEAM_NAME 팀명, PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 등번호, HEIGHT 신장길이
FROM PLAYER
JOIN TEAM USING (TEAM_ID)
WHERE (TEAM_ID) IN (SELECT TEAM_ID
                    FROM PLAYER
                    GROUP BY TEAM_ID)
AND (HEIGHT) <= ANY (SELECT AVG(HEIGHT)
                     FROM PLAYER
                     GROUP BY TEAM_ID);

--13. 선수의 이름과 포지션, 등번호, 팀ID, 팀명을 조회하는 뷰(V_TEAM_PLAYER)를 하나 생성한 뒤
--     생성한 뷰를 활용하여 '황'씨성을 가진 선수들의 정보를 조회하시오.
-- (관리자계정에서 GRANT CREATE VIEW TO SOCCERWORK 로 권한 부여해줌)
CREATE OR REPLACE VIEW V_TEAM_PLAYER
AS (SELECT PLAYER_NAME, POSITION, BACK_NO, TEAM_ID, TEAM_NAME
    FROM PLAYER
    JOIN TEAM USING (TEAM_ID));

SELECT *
FROM V_TEAM_PLAYER
WHERE PLAYER_NAME LIKE '황%';

-- ***********************************************************************
--14. 울산 현대 팀에 '박주호' 선수가 새로 영입되었다.
--     해당 선수의 정보 중 포지션은 DF이며 1987년 3월 16일생, 신장과 몸무게가 각각 176cm, 75kg으로 
--     나간다고 했을 때, 박주호 선수의 선수ID를 기존 선수들 중 가장 큰 숫자를 지닌 선수에서 
--     숫자를 하나 증가시켜 추가할 수 있는 쿼리를 작성하시오.
INSERT INTO PLAYER 
VALUES((SELECT MAX(PLAYER_ID) + 1 FROM PLAYER)
      , '박주호'
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

--15. SCHEDULE에 기록된 정보들 중 가장 높은 골이 기록된 경기들의 날짜와 경기장 명, 
--     HOME팀과 AWAY팀의 팀 명과 각 팀이 기록한 골의 수를 조회하시오.
SELECT * FROM SCHEDULE;
SELECT * FROM STADIUM;
SELECT * FROM TEAM;

SELECT SCH1.SCHE_DATE 경기날짜
     , STA.STADIUM_NAME "경기장 명"
     , T1.TEAM_NAME HOME팀
     , T2.TEAM_NAME AWAY팀
     , SCH1.HOME_SCORE "HOME팀 골"
     , SCH1.AWAY_SCORE "AWAY팀 골"
  FROM SCHEDULE SCH1
  JOIN STADIUM STA USING (STADIUM_ID)
  JOIN TEAM T1 ON (T1.TEAM_ID = SCH1.HOMETEAM_ID) --홈팀
  JOIN TEAM T2 ON (T2.TEAM_ID = SCH1.AWAYTEAM_ID)--에웨이팀
 WHERE SCH1.HOME_SCORE + SCH1.AWAY_SCORE = ANY (SELECT MAX(SCH2.HOME_SCORE + SCH2.AWAY_SCORE) 골
                                                  FROM SCHEDULE SCH2);

--16. 최근 한국 스폰서들의 경제상황이 안 좋아져 팀 구단 중 현재 선수가 3명 이하인 구단을
--    정리하게 되었다. TEAM 테이블을 활용하여 현재 소속된 선수가 3명 이하인 구단을 찾아
--    해당 데이터를 삭제하는 쿼리를 작성하시오.
DELETE FROM TEAM
WHERE TEAM_ID IN (SELECT TEAM_ID
                    FROM PLAYER
                   GROUP BY TEAM_ID
                   HAVING COUNT(*)<=3);
-- 제약조건
ALTER TABLE PLAYER
DISABLE CONSTRAINT PLAYER_FK CASCADE;

SELECT * FROM TEAM;

COMMIT;