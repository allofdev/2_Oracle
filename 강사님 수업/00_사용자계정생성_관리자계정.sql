
-- 새로운 사용자계정 생성하는 구문 (수업용 계정 새로만들자!!) == 관리자만 할 수 있는 권한
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호
CREATE USER KH IDENTIFIED BY KH;

-- 새로이 생성된 사용자 계정에게 최소한의 권한(CONNECT, RESOURCE) 부여하기
-- [표현법] GRANT 권한, 권한, ... TO 계정명;
GRANT CONNECT, RESOURCE TO KH;
