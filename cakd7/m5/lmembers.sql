--lmembers
SELECT * FROM channel;
SELECT * FROM competitor;
SELECT * FROM demo;
SELECT * FROM member;
SELECT * FROM prodcl;
SELECT * FROM purprd;

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
count(CASE WHEN P.purdate between '20150701' and


