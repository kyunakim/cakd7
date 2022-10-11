SELECT * FROM employees;
select last_name, 'is a' job_id from employees;
select last_name||' is a '||job_id as EXPLAIN from employees;

--distinct - unique한 값 보기
select distinct job_id from employees;

select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--Q. employees 테이블에서 commission_pct의 null값 갯수를 출력
SELECT count(*) 
FROM EMPLOYEES
WHERE commission_pct IS NULL;

--Q. employees 테이블에서 employee_id가 홀수인 것만 출력
select * from employees where mod(employee_id, 2) = 1;

select round(355.95555,2) from dual;
select round(355.95555,-2) from dual;

select trunc(45.55551,1) from dual;

select last_name, trunc(salary/12,2) 월급 from employees;

--width_bucket(지정값,최소값,최대값,bucket갯수)
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

select last_name, trim('A' from last_name) A삭제 from employees;
select ltrim('aaaHello Worldaaa','a') from dual;
select rtrim('aaaHello Worldaaa','a') from dual;
select trim('     Hello World     ') from dual;
select ltrim('     Hello World     ') from dual;
select rtrim('     Hello World     ') from dual;

select sysdate from dual;

select * from employees;
select last_name, trunc((sysdate-hire date)/365,0) 근속연수;


--과제_1005_1. employees 테이블에서 채용일에 6개월을 추가한 날짜를 last_name과 같이 출력
--add_months(날짜,숫자)
select last_name, hire_date, add_months(hire_date,6)
from employees;

--과제_1005_2. 이번달의 말일을 반환하는 함수를 사용하여 말일을 출력
select LAST_DAY(SYSDATE)
FROM dual;

--과제_1005_3. employees 테이블에서 채용일과 현재시점간의 근속월수를 출력
--months_between 함수는 두 날짜 간의 월 수를 반환한다.
select last_name, hire_date, trunc(months_between (sysdate, hire_date)) 근속월수
from employees;

--과제_1005_4. 입사일 6개월 후 첫번째 월요일을 last_name별로 출력
select last_name, hire_date, next_day(add_months(hire_date,6),'월요일') "입사일 6개월 후 첫번째 월요일"
from employees;

--과제_1005_5. job_id별로 연봉합계 연봉평균 최고연봉 최저연봉 출력
    -- 단, 평균연봉이 5000 이상인 경우만 포함하여 내림차순으로 정렬
select job_id,
sum(salary) 연봉합계,
avg(salary) 연봉평균,
max(salary) 최고연봉,
min(salary) 최저연봉
from employees
group by job_id
having avg(salary) >=5000--평균 급여 5000이상만 표시
order by avg(salary) desc;--연봉평균 기준 내림차순으로 정렬

--과제_1005_6. 사원번호가 110인 사원의 부서명을 출력
select * from employees;

SELECT DEPARTMENT_NAME
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id = departments.department_id(+)
AND employees.employee_id=110;


--과제_1005_7. 사번이 120번인 직원의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력
select * from employees;
select * from jobs;

select e.employee_id 사번, e.first_name 이름, j.job_id 업무, j.job_title 업무명
from employees e, jobs j
where employee_id =120;

--과제_1005_8. 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
    --salary > 20000 then '대표이사'
    --salary > 15000 then '이사' 
    --salary > 10000 then '부장' 
    --salary > 5000 then '과장'   
    --salary > 3000 then '대리'
    --나머지 '사원'


select employee_id 사번, last_name 이름,
    case when e.salary > 20000 then '대표이사'
        when e.salary > 15000 then '이사'
        when e.salary > 10000 then '부장'
        when e.salary > 5000 then '과장'
        when e.salary > 3000 then '대리'
        else '사원'
    end as 직급
from employees e;

SELECT employee_id, last_name, CASE WHEN SALARY > 20000 THEN '대표이사'
    WHEN SALARY > 15000 THEN '이사'
    WHEN SALARY > 10000 THEN '부장'
    WHEN SALARY > 5000 THEN '과장'
    WHEN SALARY > 3000  THEN '대리'
    ELSE '사원' END 직급 
FROM employees;


--과제_1005_9. employees 테이블에서 employee_id와 salary만 추출해서 employee_salary 테이블을 생성하여 출력
create table employee_salary
as select employee_id, salary
from employees;

select * from employee_salary;
select * from employees;

--과제_1005_10. employee_salary 테이블에 first_name, last_name 컬럼을 추가한 후 name으로 변경하여 출력
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

--과제_1005_11. employee_salary 테이블의 employee_id에 기본키를 적용하고 constraint_name을 ES_PK로 지정 후 출력
ALTER TABLE EMPLOYEE_SALARY 
ADD CONSTRAINT ES_PK
PRIMARY KEY (EMPLOYEE_ID);

--과제_1005_12. employee_salary 테이블의 employee_id에서 contraint_name을 삭제 후 삭제 여부를 확인
ALTER TABLE EMPLOYEE_SALARY
DROP CONSTRAINT ES_PK;

select * from all_constraints where table_name = 'employee_salary';