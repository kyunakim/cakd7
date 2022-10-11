빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 22.10.07
- 성명 :
- 점수 :

※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A.
SELECT FIRST_NAME, SALARY, SALARY*1.1 UPSALARY FROM EMPLOYEES;
    
--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '05/01/01' AND '05/06/30';  

--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
SELECT * FROM EMPLOYEES WHERE JOB_ID IN('SA_MAN','IT_PROG','ST_MAN');
   
--Q4. manager_id 가 101에서 103인 사람만 출력
--A.   	
select * from employees where manager_id between 101 and 103;

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
select last_name, hire_date, next_day( add_months( hire_date, 6 ), '월' ) "TARGET" from employees;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date, 
trunc((months_between(sysdate, hire_date))) 
w_month from employees order by w_month desc;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date,  
trunc( ( sysdate - hire_date ) / 365 ) w_year 
from employees order by w_year desc; 

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A. 
select employee_id, last_name from employees where mod( employee_id, 2 )= 1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
select employee_id, last_name, round( salary/12, 2 ) m_salary from employees;  

--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의  근속년수에 따라 30 등급으로 나누어  등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.
select employee_id, last_name, salary, hire_date,
trunc( ( ( to_date('20/12/31') - hire_date ) / 365)) 근속연수,
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30)) wb,
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30))  * 1000 bonus
from employees
order by bonus desc;  

--20개 보너스 등급 적용시
select employee_id, last_name, salary, hire_date, trunc( ( sysdate - hire_date ) / 365) 근속연수,
trunc(( sysdate - hire_date ) / 365) 등급,(width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20)) wb,
(width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20))  * 1000 bonus_wb,
trunc(( sysdate - hire_date ) / 365) * 1000 bonus_등급
from employees order by bonus_wb desc;



--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
SELECT count(*) FROM employees
WHERE commission_pct is null;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A.
select last_name, department_id, nvl(to_char(department_id),'신입') position
from employees where department_id is null;


--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A.
select e.employee_id, e.last_name, j.job_id, j.job_title from employees e
join jobs j on e.job_id=j.job_id where employee_id=120;

select  e.employee_id, e.last_name, j.job_id, j. job_title from employees e, jobs j
where e.job_id=j.job_id and employee_id = 120;

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. 
SELECT FIRST_NAME || ' ' || LAST_NAME NAME FROM EMPLOYEES;

--Q15. lmembers purprd 테이블로 부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력하세요.
select (select sum(p1.puramt) from purprd p1) as amt,
(select sum(p2.puramt) from purprd p2 where p2.purdate < 20150101) as amt_2014,
(select sum(p3.puramt) from purprd p3 where p3.purdate > 20141231) as amt_2015
from dual;

select sum(puramt) 총구매액, 
sum(case when purdate <= '20141231' then puramt end) "2014 구매액", 
sum(case when purdate > '20141231' and purdate <= '20151231' then puramt end) "2015 구매액"
from purprd;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A.
-- _을 와일드카드가 아닌 문자로 취급하고 싶을 때 escape 옵션을 사용한다. \다음에 값('_')을 특수문자로 필터링
select * from employees where job_id like '%\_A%' escape '\';

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
select SALARY, LAST_NAME from employees order by salary asc, last_name asc;

   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.
select department_name from departments 
where department_id=(select department_id from employees where last_name='Seo');     

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 DEMO 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.
drop table cuspur;
CREATE TABLE cuspur
AS select custno, sum(puramt) puramt_sum
FROM purprd 
GROUP BY custno
ORDER BY custno;

SELECT D.*, C.puramt_sum 
FROM demo D, cuspur C
WHERE D.custno = C.custno
ORDER BY D.custno;

--Q20.PURPRD 테이블로 부터 아래 사항을 수행하세요.
-- 2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성 (출력내용 : custno, asso, SUM(puramt) puramt)
--AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, custno, asso별로 puramt 및 증감이 구분되어야 함)

SELECT * FROM PURPRD
WHERE YEAR <2015;
DESC PURPRD;

CREATE TABLE AMT14
AS SELECT custno, asso, SUM(puramt) puramt 
FROM PURPRD
WHERE purdate < 20150101
GROUP BY custno, asso
ORDER BY custno;

select * from amt14;

CREATE TABLE AMT15
AS SELECT custno, asso, SUM(puramt) puramt 
FROM PURPRD
WHERE purdate > 20141231
GROUP BY custno, asso
ORDER BY custno;

select * from amt15;

CREATE TABLE AMT_YEAR_FOJ    
AS SELECT NVL(A.CUSTNO,B.CUSTNO) CUSTNO, NVL(A.ASSO,B.ASSO) ASSO, NVL(A.PURAMT,0) AMT14, NVL(B.PURAMT,0) AMT15
FROM AMT14 A FULL OUTER JOIN AMT15 B ON A.CUSTNO=B.CUSTNO AND A.ASSO=B.ASSO;
--FULL OUTER JOIN 테이블 생성
--CREATE TABLE AMT_YEAR_FOJ
--AS SELECT A4.custno, A4.asso, A4.puramt 구매14, A5.puramt 구매15
--FROM AMT14 A4 FULL OUTER JOIN AMT15 A5
--ON (A4.custno=A5.custno AND A4.asso=A5.asso);

--FULL OUTER JOIN 적용시 증감 출력
SELECT custno,asso, NVL(AMT14,0) 구매14, NVL(AMT15,0) 구매15,
(NVL(AMT15,0)-NVL(AMT14,0)) 증감
FROM AMT_YEAR_FOJ A;


DROP TABLE amt14;
DROP TABLE amt15;
DROP TABLE AMT_YEAR_FOJ;

--Q(BONUS). HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.
부서별 평균 SALARY 순위
SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;