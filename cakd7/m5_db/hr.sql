SELECT * FROM employees;
select last_name, 'is a' job_id from employees;
select last_name||' is a '||job_id as EXPLAIN from employees;

--distinct - unique�� �� ����
select distinct job_id from employees;

select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--Q. employees ���̺��� commission_pct�� null�� ������ ���
SELECT count(*) 
FROM EMPLOYEES
WHERE commission_pct IS NULL;

--Q. employees ���̺��� employee_id�� Ȧ���� �͸� ���
select * from employees where mod(employee_id, 2) = 1;

select round(355.95555,2) from dual;
select round(355.95555,-2) from dual;

select trunc(45.55551,1) from dual;

select last_name, trunc(salary/12,2) ���� from employees;

--width_bucket(������,�ּҰ�,�ִ밪,bucket����)
select width_bucket(92,0,100,10) from dual;
select width_bucket(38,0,100,50) from dual;

select upper('Hello World') from dual;
select lower('Hello World') from dual;

select last_name, salary from employees where last_name='king';
select last_name, salary from employees where lower(last_name)='king';

select job_id, length(job_id) from employees;
select substr('Hello World',3,3) from dual;
select substr('Hello World'-3,3) from dual;

select lpad('Hello World',20,'#') from dual;
select rpad('Hello World',20,'#') from dual;

select last_name, trim('A' from last_name) A���� from employees;
select ltrim('aaaHello Worldaaa','a') from dual;
select rtrim('aaaHello Worldaaa','a') from dual;
select trim('     Hello World     ') from dual;
select ltrim('     Hello World     ') from dual;
select rtrim('     Hello World     ') from dual;

select sysdate from dual;

select * from employees;
select last_name, trunc((sysdate-hire date)/365,0) �ټӿ���;


--����_1005_1. employees ���̺��� ä���Ͽ� 6������ �߰��� ��¥�� last_name�� ���� ���
--add_months(��¥,����)
select last_name, hire_date, add_months(hire_date,6)
from employees;

--����_1005_2. �̹����� ������ ��ȯ�ϴ� �Լ��� ����Ͽ� ������ ���
select LAST_DAY(SYSDATE)
FROM dual;

--����_1005_3. employees ���̺��� ä���ϰ� ����������� �ټӿ����� ���
--months_between �Լ��� �� ��¥ ���� �� ���� ��ȯ�Ѵ�.
select last_name, hire_date, trunc(months_between (sysdate, hire_date)) �ټӿ���
from employees;

--����_1005_4. �Ի��� 6���� �� ù��° �������� last_name���� ���
select last_name, hire_date, next_day(add_months(hire_date,6),'������') "�Ի��� 6���� �� ù��° ������"
from employees;

--����_1005_5. job_id���� �����հ� ������� �ְ��� �������� ���
    -- ��, ��տ����� 5000 �̻��� ��츸 �����Ͽ� ������������ ����
select job_id,
sum(salary) �����հ�,
avg(salary) �������,
max(salary) �ְ���,
min(salary) ��������
from employees
group by job_id
having avg(salary) >=5000--��� �޿� 5000�̻� ǥ��
order by avg(salary) desc;--������� ���� ������������ ����

--����_1005_6. �����ȣ�� 110�� ����� �μ����� ���
select * from employees;

SELECT DEPARTMENT_NAME
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id = departments.department_id(+)
AND employees.employee_id=110;


--����_1005_7. ����� 120���� ������ ���, �̸�, ����(job_id), ������(job_title)�� ���
select * from employees;
select * from jobs;

select e.employee_id ���, e.first_name �̸�, j.job_id ����, j.job_title ������
from employees e, jobs j
where employee_id =120;

--����_1005_8. ���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
    --salary > 20000 then '��ǥ�̻�'
    --salary > 15000 then '�̻�' 
    --salary > 10000 then '����' 
    --salary > 5000 then '����'   
    --salary > 3000 then '�븮'
    --������ '���'


select employee_id ���, last_name �̸�,
    case when e.salary > 20000 then '��ǥ�̻�'
        when e.salary > 15000 then '�̻�'
        when e.salary > 10000 then '����'
        when e.salary > 5000 then '����'
        when e.salary > 3000 then '�븮'
        else '���'
    end as ����
from employees e;

SELECT employee_id, last_name, CASE WHEN SALARY > 20000 THEN '��ǥ�̻�'
    WHEN SALARY > 15000 THEN '�̻�'
    WHEN SALARY > 10000 THEN '����'
    WHEN SALARY > 5000 THEN '����'
    WHEN SALARY > 3000  THEN '�븮'
    ELSE '���' END ���� 
FROM employees;


--����_1005_9. employees ���̺��� employee_id�� salary�� �����ؼ� employee_salary ���̺��� �����Ͽ� ���
create table employee_salary
as select employee_id, salary
from employees;

select * from employee_salary;
select * from employees;

--����_1005_10. employee_salary ���̺� first_name, last_name �÷��� �߰��� �� name���� �����Ͽ� ���
alter table employee_salary
add first_name varchar2(20)
add last_name varchar2(20);

--alter table employee_salary drop column first_name;
--alter table employee_salary drop column last_name;

update employee_salary es
set first_name=
(select first_name from employees e where es.employee_id=e.employee_id),
last_name = (select last_name from employees e where es.employee_id = e.employee_id);

select * from employee_salary;

select employee_id,salary,first_name||' '||last_name name from employee_salary;

--drop table employee_salary;

--select first_name||' '||last_name as name from employee_salary;

--create or replace view employee_salary
--as select first_name||' '||last_name as name
--from employees;

--����_1005_11. employee_salary ���̺��� employee_id�� �⺻Ű�� �����ϰ� constraint_name�� ES_PK�� ���� �� ���
ALTER TABLE EMPLOYEE_SALARY 
ADD CONSTRAINT ES_PK
PRIMARY KEY (EMPLOYEE_ID);

--����_1005_12. employee_salary ���̺��� employee_id���� contraint_name�� ���� �� ���� ���θ� Ȯ��
ALTER TABLE EMPLOYEE_SALARY
DROP CONSTRAINT ES_PK;

select * from all_constraints where table_name = 'employee_salary';