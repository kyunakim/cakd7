--lmembers
SELECT * FROM channel;
SELECT * FROM competitor;
SELECT * FROM demo;
SELECT * FROM member;
SELECT * FROM prodcl;
SELECT * FROM purprd;

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
count(CASE WHEN P.purdate between '20150701' and


