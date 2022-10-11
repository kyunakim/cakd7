select * from employees;

select count(*) from employees;

-- 사원번호, 이름, 연봉
select employee_id, last_name, salary from employees;
select employee_id "사원번호", last_name "이름", salary "연봉" from employees;
select first_name||' '||last_name "이름" from employees;

--Q. HR employees 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력
select last_name, salary, salary*1.1
from employees;

--Q. hr employees 테이블에서 commission_pct의 null값 갯수를 출력
SELECT COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

--[과제_1006_2] HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요(예: 부서별 평균 salary 순위)

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

--사용자 암호 변경
alter user c##user01
identified by passuser;

--삭제
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
