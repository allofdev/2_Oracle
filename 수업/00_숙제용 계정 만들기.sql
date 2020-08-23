
--1. 계정생성
CREATE USER HOMEWORK IDENTIFIED BY HOMEWORK;
--          아이디                 비밀번호


--2. 최소한의 권한부여
GRANT CONNECT, RESOURCE TO HOMEWORK;



--3. 왼쪽의 +버튼을눌러서 추가