-- 관리자계정으로는 작업을 할 수 없음
-- 관리자계정에서 사용자계정 만들 수 있음


-- 새로운 사용자계정 생성하는 구문 (수업용 계정 새로만들자!!) == 관리자만 할 수 있는 권한
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH;
-- 왼쪽에 +를 해서 아이디 비번 KH로 해도 안만들어짐 --> 권한을 부여해야하기 때문

-- 새로이 생성된 사용자 계정에게 최소한의 권한(CONNECT, RESOURCE) 부여하기
-- [표현법] GRANT 권한, 권한, ... TO 계정명;
GRANT CONNECT, RESOURCE TO KH;
-- CONNECT와 RESOURCE는 권한들의 집합. 안에 많은 권한을 가지고 있음