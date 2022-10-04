SELECT ABS(-78),ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;

--Q. 고객별 평균 주문 금액을 구하세요.
SELECT * FROM orders;
SELECT ROUND(avg(O.saleprice))
FROM orders O,customer C
WHERE C.custid=O.custid
GROUP BY c.custid;

SELECT C.name ,ROUND(avg(O.saleprice))
FROM orders O,customer C
WHERE C.custid=O.custid
GROUP BY c.name;


--Q. 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서목록, 가격을 출력
SELECT * FROM book;
SELECT bookid, REPLACE(bookname,'야구','농구') bookname, publisher, price
FROM book;

SELECT bookname 제목, length(bookname) 글자수, lengthb(bookname) AS 바이트수
FROM book;

SELECT * FROM customer;
INSERT INTO customer VALUES(5,'박세리','대한민국 대전',NULL);

--과제_1004_4. customer 테이블에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하세요.

SELECT substr(name, 1, 1) "성", count(*) "인원수"
FROM customer
GROUP BY substr(name, 1, 1);


--Q. 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하세요.
SELECT orderid 주문번호, orderdate 주문일, orderdate+10 확정일자
FROM orders;

--과제_1004_5. 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 출력
--(단, 주문일은 '2020-07-07 화요일' 포맷)
SELECT SYSDATE FROM dual;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

SELECT orderid 주문번호, TO_CHAR(orderdate,'yyyy-mm-dd dy') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate=TO_Date('20200707', 'yyyymmdd');

--Q. 이름, 전화번호가 포함된 고객목록을 보이세요. 단, 전화번호가 없는 고객은 '연락처 없음'으로 표현하여 출력하세요.
--(NVL 함수 사용)
SELECT * FROM customer;

SELECT name 이름, NVL(phone,'연락처 없음') 전화번호 
FROM customer

--SELECT COALESCE(NULL,NULL, 'third value', 'forth value');
--세번째 값이 null이 아닌 첫번째 값이기 때문에 세번째 값을 반환
SELECT NAME 이름, PHONE, COALESCE(PHONE, '연락처없음')전화번호
FROM customer;

SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM <=3;

SELECT * FROM orders;
--Q. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 출력
SELECT orderid, saleprice FROM orders 
WHERE SALEPRICE < (SELECT AVG(SALEPRICE) FROM ORDERS o);

--Q. 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 출력
SELECT orderid, custid, saleprice
FROM orders o1
WHERE saleprice > (SELECT AVG(saleprice) FROM orders o2 
                    WHERE o1.custid = o2.custid );

--과제_1004_6. 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 출력
SELECT SUM(saleprice)
FROM customer c, orders o
WHERE c.custid=o.custid AND c.address LIKE '대한민국%';

--과제_1004_7. 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 출력
SELECT orderid, saleprice
FROM orders o
WHERE saleprice > ( SELECT MAX(o.saleprice)
    FROM customer c, orders o
    WHERE o.custid=c.custid AND c.custid='3');

SELECT * FROM orders;
--과제_1004_8. 고객번호가 2 이하인 고객의 판매액을 출력(단, 고객이름과 고객별 판매액 포함)
SELECT custid, name 
FROM customer
WHERE custid<=2;

SELECT cs.name, sum(o.saleprice)
FROM (SELECT custid, name
FROM customer
WHERE custid<=2) cs, orders o
WHERE cs.custid=o.custid
GROUP BY cs.name;

--과제_1004_9. lmembers 데이터를 고객별로 속성(성별,나이,거주지역) 구매합계(반기별), 평균구매(반기별), 구매빈도(반기별)를 출력
