빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 22.10.07
- 성명 : 김영선
- 점수 : 80


※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A.
select last_name, salary, salary*1.1
from employees;

--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
select * from employees
where hire_date between '05/01/01' and '05/06/30';  

--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
select * from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');

--Q4. manager_id 가 101에서 103인 사람만 출력
--A.   	
select * from employees
where manager_id between 101 and 103;

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
select last_name, hire_date, next_day(add_months(hire_date,6),'월요일') "입사일 6개월 후 첫번째 월요일"
from employees;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date, trunc((months_between(sysdate, hire_date))) w_month
from employees
order by w_month desc;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date, trunc((sysdate-hire_date)/365) w_year 
from employees order by w_year desc;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A.
select employee_id, last_name
from employees
where mod(employee_id,2)=1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
select employee_id, last_name, round(salary/12,2) m_salary
from employees;

--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의  근속년수에 따라 30 등급으로 나누어  등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.
select employee_id, last_name, salary, hire_date, trunc((sysdate-hire_date)/365) 근속년수
from employees;

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
select count(*) from employees
where commission_pct is null;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A.
select last_name, department_id, nvl(to_char(department_id),'신입') position
from employees where department_id is null;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A.
select e.employee_id 사번, e.last_name 이름, j.job_id 업무, j. job_title 업무명
from employees e, jobs j
where e.job_id=j.job_id and employee_id = 120;

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A.
select first_name||' '||last_name name
from employees;

--Q15. lmembers purprod 테이블로 부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력하세요.
--A.
select sum(puramt) 총구매액, 
sum(case when purdate <= '20141231' then puramt end) "2014 구매액", 
sum(case when purdate > '20141231' and purdate <= '20151231' then puramt end) "2015 구매액"
from purprd;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A.

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
select salary, last_name
from employees
order by salary asc, last_name asc;
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.
select department_name
from departments 
where department_id=(select department_id from employees where last_name='Seo');     

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUSTDEMO 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.
--A.
drop table cuspur;

create table cuspur
as select custno, sum(puramt) puramt_sum
from purprd
group by custno
order by custno;

--Q20.PURPROD 테이블로 부터 아래 사항을 수행하세요.
-- 2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성 (출력내용 : 고객번호, 제휴사, SUM(구매금액) 구매금액)
--AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
--A.

--Q(BONUS). HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.