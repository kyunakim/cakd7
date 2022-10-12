--lmembers
SELECT * FROM channel;
SELECT * FROM competitor;
SELECT * FROM demo;
SELECT * FROM member;
SELECT * FROM prodcl;
SELECT * FROM purprd;

select count(*) from purprd;
select sum(puramt) from purprd;
select avg(puramt) from purprd;

--고객별로 속성(성별, 나이, 거주지역)
SELECT custno 고객번호, gender 성별, age 나이, area 거주지역
FROM demo
ORDER BY custno;


--성별+나이 그룹, 카운트
SELECT gender 성별, age 나이, COUNT(age) 카운트
FROM demo
GROUP BY gender, age
ORDER BY gender;


--구매합계(년도별), 평균구매(년도별), 구매빈도(년도별)
SELECT SUBSTR(purdate,1,4) 년도별, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,4)
ORDER BY SUBSTR(purdate,1,4);


--구매합계(월별), 평균구매(월별), 구매빈도(월별)
SELECT SUBSTR(purdate,1,6) 월별, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);


--구매합계(분기별), 평균구매(분기별), 구매빈도(분기별)
SELECT SUBSTR(purdate,1,4) 년도, CEIL(SUBSTR(purdate,5,2)/3) 분기, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3);


--구매합계(반기별), 평균구매(반기별), 구매빈도(반기별)
SELECT SUBSTR(purdate,1,4) 년도, CEIL(SUBSTR(purdate,5,2)/6) 분기, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6);


--채널+이용횟수
SELECT asso 제휴사, SUM(freq) "이용횟수 합"
FROM channel
GROUP BY asso
ORDER BY SUM(freq) DESC;


--프로덕트 : 제일 많이 이용한 제휴사 조회
SELECT asso, COUNT(*)
FROM prodcl
GROUP BY asso
ORDER BY COUNT(*) DESC;


--멤버십 : 가입수가 많은 달 순서로 정렬
SELECT mname,joinmonth,  COUNT(*)
FROM member
GROUP BY mname,joinmonth
ORDER BY COUNT(*) DESC;

--멤버십 : 가입수가 많은 달 순서로 정렬
SELECT mname,  COUNT(*)
FROM member
GROUP BY mname
ORDER BY mname,COUNT(*) DESC; 

--구매합계(월별), 평균구매(월별), 구매빈도(월별)
SELECT SUBSTR(purdate,1,6) 월별, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);

--
select substr(purdate,1,6) 월별, sum(purmat) 구매합계, round(avg(purmat),0) 평균구매, count(purmat) 구매빈도
from purprd p, member m, demo de
where p.custno = m.custno and de.gender = 'F' and p.purdate
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);

select D.custno 고객번호, d.age 나이, d.gender 성별, d.area 거주지역,
sum(CASE WHEN P.purdate between '20150701' and '20151231' then P.puramt end) "구매합계(2015후기)",
count(CASE WHEN P.purdate between '20150701' and;

--Q. lmembers purprd 테이블로부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력
select sum(puramt) 총구매액, 
sum(case when purdate <= '20141231' then puramt end) "2014 구매액", 
sum(case when purdate > '20141231' and purdate <= '20151231' then puramt end) "2015 구매액"
from purprd;

--Q. lmembers 데이터에서 고객별 구매금액의 합계를 구한 cuspur 테이블을 생성한 후 demo 테이블과 고객번호(custno)을 기준으로 결합하여 출력
CREATE TABLE cuspur
AS select custno, sum(puramt) puramt_sum
FROM purprd
GROUP BY custno
ORDER BY custno;

SELECT D.*, C.purmat_sum
FROM demo D, cuspur C
WHERE D.custno = c.custno
order by d.custno;

--온라인 채널별(모바일 로그인 횟수, PC 구매 횟수)
select * from channel;

select * from purprd;
--[과제_1006_1] purprd 데이터로 부터 아래 사항을 수행하세요.
--2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성(출력내용:고객번호,제휴사,SUM(구매금액))
create table AMT14 
as select custno, asso, sum(case when purdate like '2014%' then puramt end) as AMT2014,.
from purprd;

create table AMT15
select custno, asso, sum(case when purdate like '2015%' then puramt end)
from purprd;

--AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
CREATE TABLE AMT_YEAR_FOJ
AS select *
from AMT14 14 FULL OUTER JOIN AMT15 15
ON (14.CUSTNO=15.CUSTNO AND 14.ASSO=15.ASSO);

--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
ALTER TABLE AMT_YEAR_FOJ
add AMT1415 varchar2(25);

update AMT_YEAR_FOJ
SET AMT1415


