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

--������ �Ӽ�(����, ����, ��������)
SELECT custno ����ȣ, gender ����, age ����, area ��������
FROM demo
ORDER BY custno;


--����+���� �׷�, ī��Ʈ
SELECT gender ����, age ����, COUNT(age) ī��Ʈ
FROM demo
GROUP BY gender, age
ORDER BY gender;


--�����հ�(�⵵��), ��ձ���(�⵵��), ���ź�(�⵵��)
SELECT SUBSTR(purdate,1,4) �⵵��, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,4)
ORDER BY SUBSTR(purdate,1,4);


--�����հ�(����), ��ձ���(����), ���ź�(����)
SELECT SUBSTR(purdate,1,6) ����, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);


--�����հ�(�б⺰), ��ձ���(�б⺰), ���ź�(�б⺰)
SELECT SUBSTR(purdate,1,4) �⵵, CEIL(SUBSTR(purdate,5,2)/3) �б�, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3);


--�����հ�(�ݱ⺰), ��ձ���(�ݱ⺰), ���ź�(�ݱ⺰)
SELECT SUBSTR(purdate,1,4) �⵵, CEIL(SUBSTR(purdate,5,2)/6) �б�, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6);


--ä��+�̿�Ƚ��
SELECT asso ���޻�, SUM(freq) "�̿�Ƚ�� ��"
FROM channel
GROUP BY asso
ORDER BY SUM(freq) DESC;


--���δ�Ʈ : ���� ���� �̿��� ���޻� ��ȸ
SELECT asso, COUNT(*)
FROM prodcl
GROUP BY asso
ORDER BY COUNT(*) DESC;


--����� : ���Լ��� ���� �� ������ ����
SELECT mname,joinmonth,  COUNT(*)
FROM member
GROUP BY mname,joinmonth
ORDER BY COUNT(*) DESC;

--����� : ���Լ��� ���� �� ������ ����
SELECT mname,  COUNT(*)
FROM member
GROUP BY mname
ORDER BY mname,COUNT(*) DESC; 

--�����հ�(����), ��ձ���(����), ���ź�(����)
SELECT SUBSTR(purdate,1,6) ����, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);

--
select substr(purdate,1,6) ����, sum(purmat) �����հ�, round(avg(purmat),0) ��ձ���, count(purmat) ���ź�
from purprd p, member m, demo de
where p.custno = m.custno and de.gender = 'F' and p.purdate
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);

select D.custno ����ȣ, d.age ����, d.gender ����, d.area ��������,
sum(CASE WHEN P.purdate between '20150701' and '20151231' then P.puramt end) "�����հ�(2015�ı�)",
count(CASE WHEN P.purdate between '20150701' and;

--Q. lmembers purprd ���̺�κ��� �ѱ��ž�, 2014 ���ž�, 2015 ���ž��� �ѹ��� ���
select sum(puramt) �ѱ��ž�, 
sum(case when purdate <= '20141231' then puramt end) "2014 ���ž�", 
sum(case when purdate > '20141231' and purdate <= '20151231' then puramt end) "2015 ���ž�"
from purprd;

--Q. lmembers �����Ϳ��� ���� ���űݾ��� �հ踦 ���� cuspur ���̺��� ������ �� demo ���̺�� ����ȣ(custno)�� �������� �����Ͽ� ���
CREATE TABLE cuspur
AS select custno, sum(puramt) puramt_sum
FROM purprd
GROUP BY custno
ORDER BY custno;

SELECT D.*, C.purmat_sum
FROM demo D, cuspur C
WHERE D.custno = c.custno
order by d.custno;

--�¶��� ä�κ�(����� �α��� Ƚ��, PC ���� Ƚ��)
select * from channel;

select * from purprd;
--[����_1006_1] purprd �����ͷ� ���� �Ʒ� ������ �����ϼ���.
--2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ����(��³���:����ȣ,���޻�,SUM(���űݾ�))
create table AMT14 
as select custno, asso, sum(case when purdate like '2014%' then puramt end) as AMT2014,.
from purprd;

create table AMT15
select custno, asso, sum(case when purdate like '2015%' then puramt end)
from purprd;

--AMT14�� AMT15 2�� ���̺��� ����ȣ�� ���޻縦 �������� FULL OUTER JOIN �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
CREATE TABLE AMT_YEAR_FOJ
AS select *
from AMT14 14 FULL OUTER JOIN AMT15 15
ON (14.CUSTNO=15.CUSTNO AND 14.ASSO=15.ASSO);

--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ���(��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)
ALTER TABLE AMT_YEAR_FOJ
add AMT1415 varchar2(25);

update AMT_YEAR_FOJ
SET AMT1415


