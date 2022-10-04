SELECT ABS(-78),ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;

--Q. ���� ��� �ֹ� �ݾ��� ���ϼ���.
SELECT * FROM orders;
SELECT ROUND(avg(O.saleprice))
FROM orders O,customer C
WHERE C.custid=O.custid
GROUP BY c.custid;

SELECT C.name ,ROUND(avg(O.saleprice))
FROM orders O,customer C
WHERE C.custid=O.custid
GROUP BY c.name;


--Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� �������, ������ ���
SELECT * FROM book;
SELECT bookid, REPLACE(bookname,'�߱�','��') bookname, publisher, price
FROM book;

SELECT bookname ����, length(bookname) ���ڼ�, lengthb(bookname) AS ����Ʈ��
FROM book;

SELECT * FROM customer;
INSERT INTO customer VALUES(5,'�ڼ���','���ѹα� ����',NULL);

--����_1004_4. customer ���̺��� ���� ���� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���ϼ���.

SELECT substr(name, 1, 1) "��", count(*) "�ο���"
FROM customer
GROUP BY substr(name, 1, 1);


--Q. �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���ϼ���.
SELECT orderid �ֹ���ȣ, orderdate �ֹ���, orderdate+10 Ȯ������
FROM orders;

--����_1004_5. 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���
--(��, �ֹ����� '2020-07-07 ȭ����' ����)
SELECT SYSDATE FROM dual;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate,'yyyy-mm-dd dy') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate=TO_Date('20200707', 'yyyymmdd');

--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̼���. ��, ��ȭ��ȣ�� ���� ���� '����ó ����'���� ǥ���Ͽ� ����ϼ���.
--(NVL �Լ� ���)
SELECT * FROM customer;

SELECT name �̸�, NVL(phone,'����ó ����') ��ȭ��ȣ 
FROM customer

--SELECT COALESCE(NULL,NULL, 'third value', 'forth value');
--����° ���� null�� �ƴ� ù��° ���̱� ������ ����° ���� ��ȯ
SELECT NAME �̸�, PHONE, COALESCE(PHONE, '����ó����')��ȭ��ȣ
FROM customer;

SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <=3;

SELECT * FROM orders;
--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���
SELECT orderid, saleprice FROM orders 
WHERE SALEPRICE < (SELECT AVG(SALEPRICE) FROM ORDERS o);

--Q. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���
SELECT orderid, custid, saleprice
FROM orders o1
WHERE saleprice > (SELECT AVG(saleprice) FROM orders o2 
                    WHERE o1.custid = o2.custid );

--����_1004_6. ���ѹα��� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���
SELECT SUM(saleprice)
FROM customer c, orders o
WHERE c.custid=o.custid AND c.address LIKE '���ѹα�%';

--����_1004_7. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���
SELECT orderid, saleprice
FROM orders o
WHERE saleprice > ( SELECT MAX(o.saleprice)
    FROM customer c, orders o
    WHERE o.custid=c.custid AND c.custid='3');

SELECT * FROM orders;
--����_1004_8. ����ȣ�� 2 ������ ���� �Ǹž��� ���(��, ���̸��� ���� �Ǹž� ����)
SELECT custid, name 
FROM customer
WHERE custid<=2;

SELECT cs.name, sum(o.saleprice)
FROM (SELECT custid, name
FROM customer
WHERE custid<=2) cs, orders o
WHERE cs.custid=o.custid
GROUP BY cs.name;

--����_1004_9. lmembers �����͸� ������ �Ӽ�(����,����,��������) �����հ�(�ݱ⺰), ��ձ���(�ݱ⺰), ���ź�(�ݱ⺰)�� ���
