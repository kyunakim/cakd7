select * from employees;

select count(*) from employees;

-- �����ȣ, �̸�, ����
select employee_id, last_name, salary from employees;
select employee_id "�����ȣ", last_name "�̸�", salary "����" from employees;
select first_name||' '||last_name "�̸�" from employees;

--Q. HR employees ���̺��� �̸�, ����, 10% �λ�� ������ ���
select last_name, salary, salary*1.1
from employees;

--Q. hr employees ���̺��� commission_pct�� null�� ������ ���
SELECT COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

--[����_1006_2] HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���(��: �μ��� ��� salary ����)

--DCL

create user c##user01
identified by userpass;

select * from all_users;
drop user c##user01;

--grant, revoke
create user c##user01
identified by userpass;
grant create session, create table to c##user01;
revoke create session, create table from c##user01;

--����� ��ȣ ����
alter user c##user01
identified by passuser;

--����
drop user c##user01 cascade;

create table users(
id number,
name varchar2(20),
age number);

insert into users values(1,'hong gildong',30);
insert into users values(1,'hong gilsun',30);
select * from users;

delete from users where id=1;
select * from users;
rollback;
drop table users;
commit;
