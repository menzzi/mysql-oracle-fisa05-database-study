/* 주의 사항
 * 단일 line 주석 작성시 -- 와 내용 사이에 blank 필수
 * 
 * step01 - 기본 검색
 * select 절
 * from 절
 * : select엔 검색 컬럼, from절 table명
 * 
 * step02 - 정렬 검색
 * select 절
 * from 절
 * order by절 
 * : order by 절엔 어떤 컬럼을 내림(desc)?오름(asc)? 정렬값 설정
 * 
 * step03 - 조건 검색
 * 	select 절
 * 	from 절
 * 	where 절
 * 
 * step04 - 조건 & 정렬 검색
 * 	select 절
 * 	from 절
 * 	where 절
 * 	order by 절
 * 
 * *** mysql만의 특징
 * 	- 데이터 값의 대소문자 구분을 기본으로 하지 않음
 * 	- 데이터는 대소문자 수분은 필수로 해야 함
 *  - mysql db 선택 시
 * 		해결책1 : table 생성 후 alter로 대소문자 구분하게 설정
 * 		해결책2 : select 시 binary() 사용해서 처리
 * 
 * 
 */
use fisa;

show tables;

select * from emp;
select * from dept;
desc emp;
desc dept;

-- 1. 해당 계정이 사용 가능한 모든 table 검색
show tables;

-- 2. emp table의 모든 내용(모든 사원(row), 속성(컬럼)) 검색
select * from emp;

-- 3. emp의 구조 검색
desc emp;

-- 4. emp의 사번(empno)만 검색
-- 정렬 미 적용된 문장
select empno from emp;

-- 오름차순 정렬
-- 오름차순 : asc / 내림차순 : desc
select empno from emp order by empno;
select empno from emp order by empno desc;


-- 5. emp의 사번(empno), 이름(ename)만 검색
-- 하나 이상의 컬럼 검색시 , 표기가 구분
select empno, ename from emp;


-- 6. emp의 사번(empno), 이름(ename)만 검색(별칭 적용)
-- "as 별칭" 문법 적용
select empno as 사번, ename as 사원명 from emp;
-- 여백이 포함된 별칭 사용시 "" 표기로 하나의 문자열 의미
select empno as 사번, ename as '사원 명' from emp;


-- 7. 부서 번호(deptno) 검색
select deptno from emp;
select deptno from dept;

-- 8. 중복 제거된 부서 번호 검색 / distinct
select deptno distinct from emp; -- 에러
select distinct deptno from emp;

-- 9. 8 + 오름차순 정렬(order by)해서 검색
-- 오름 차순 : asc  / 내림차순 : desc
select distinct deptno from emp order by deptno;
select distinct deptno from emp order by deptno desc;

-- 10. ? 사번(empno)과 이름(ename) 검색 단 사번은 내림차순(order by desc) 정렬
select empno, ename from emp order by empno desc;

-- 11. ? dept table의 deptno 값만 검색 단 오름차순(asc)으로 검색
-- 정렬시 반드시 order by절로 처리
select deptno from dept; -- 정렬이 보장되지 않은 검색결과
select deptno from dept order by deptno asc;

-- 12. ? 입사일(hiredate) 검색, 
-- 입사일이 오래된 직원부터 검색되게 해 주세요 (오름차순 의미)
-- 고려사항 : date 타입도 정렬(order by) 가능 여부 확인
select hiredate from emp order by hiredate asc;

-- 13. ?모든 사원의 이름과 월 급여(sal)와 연봉 검색
select ename, sal, (sal * 12) as 연봉 from emp;

-- 14. ?모든 사원의 이름과 월급여(sal)와 연봉(sal*12) 검색
-- 단 comm 도 고려(+comm) = 연봉(sal*12) + comm
-- 모든 사원의 이름과 월급여(sal)와 연봉(sal*12)+comm 검색

-- comm이 null인 사원들 연산 불가
select ename, sal, (sal * 12) as 연봉, sal*12 + comm from emp;

-- 대안책 : null은 연산불가, 대체해서 연산, 대체값 0으로 치환
select ename, comm, ifnull(comm, 0) from emp;

select ename, sal, (sal * 12) as 연봉, sal*12 + ifnull(comm, 0) from emp;
-- *** 조건식 ***
-- 15. comm이 null인 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
select ename, comm from emp where comm is null;


-- 16. comm이 null이 아닌 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
-- 아니다 라는 부정 연산자 : not 
select ename, comm from emp where comm is not null;

-- ?모든 직원명, comm으로 내림 차순 정렬
select ename, comm from emp order by comm desc;


-- null값 보유컬럼 오름차순 정렬인 경우 null 부터 검색 
select ename, comm from emp order by comm asc;


-- 17. ? 사원명이 스미스인 사원의 이름과 사번만 검색
-- = : db에선 동등비교 연산자
-- 참고 : 자바에선  == 동등비교 연산자 / = 대입연산자
select ename, empno from emp where ename = 'SMITH';

-- 18. 부서번호가 10번 부서의 직원들 이름, 사번, 부서번호 검색
-- 단, 사번은 내림차순 검색

-- 실행 순서 : from -> where -> select -> order by
select ename, empno, deptno 
from emp 
where deptno = 10 
order by empno desc;

-- 두문제 만들고 보내고 승인받고 대화 나누고 문제 풀이
-- 19. ? 기본 syntax를 기반으로 
-- emp  table 사용하면서 문제 만들기

-- ?연봉이 가장 높은 사원 이름, 사번 출력
-- 동일한 연봉이면 사번 기준으로 오름차순

-- ?월금 가장 높은 사원과 낮은 사원 출력



-- ?부서 번호(deptno)는 오름 차순(asc) 
-- 단 해당부서(deptno)에 속한 직원번호(empno)도 오름차순(asc) 정렬
select deptno, empno 
from emp 
order by deptno, empno;

-- 결과가 맞는 문장인지의 여부 확인을 위한 추가 문장 개발해 보기 


-- 20. 급여(sal)가 900(>=)이상인 사원들 이름, 사번, 급여 검색 
select ename, empno, sal 
from emp 
where sal >= 900

-- 이름으로 오름차순 정렬 추가
select ename, empno, sal 
from emp 
where sal >= 900
order by ename asc;

-- ?20번 + sal 오름차순 정렬
select ename, empno, sal 
from emp 
where sal >= 900
order by sal asc;

-- ?20번 + sal 오름차순 + 이름 내림차순
select ename, empno, sal 
from emp 
where sal >= 900
order by sal asc, ename desc;

-- 21. deptno 10, job 은 manager(대문자로) 이름, 사번, deptno, job 검색

-- ename은 대소문자 구분 설정을 alter 명령어로 사전 셋팅
-- 대소문자 구분
select job from emp;

-- 검색 성공
select job from emp where job = 'manager';

-- 대소문자 비교 하면서 검색 : 검색 불가
select job from emp where job = binary('manager');

-- 검색 성공
select job from emp where job = binary('MANAGER');

-- 무조건 데이터를 대문자로 변경 후 검색
-- upper : 대문자 의미하는 용어 / lower : 소문자
select job from emp where job = upper('MANAGER');


-- 대문자 : upper / 소문자 : lower   / uppercase (대문자의미)
-- smith 소문자를 대문자로 변경해서 비교
select ename from emp where ename = upper('smith');


-- 22.? deptno가 10 아닌 직원들 사번, 부서번호만 검색
-- 부정연산자 not / != / <>
select empno, deptno 
from emp 
where deptno != 10;

select empno, deptno 
from emp 
where deptno <> 10;

select empno, deptno 
from emp 
where not deptno = 10;

-- 23. sal이 2000이하(sal <= 2000) 이거나(or) 3000이상(sal >= 3000)인 사원명, 급여 검색
select ename, sal 
from emp 
where sal <= 2000 or sal >= 3000;

-- 24.  comm이 300 or 500 or 1400인
select ename, sal, comm
from emp 
where comm = 300 or comm = 500 or comm = 1400;

-- in 연산식 사용해서 좀더 개선된 코드
select ename, sal, comm
from emp 
where comm in (300, 500, 1400);

-- 25. ?  comm이 300 or 500 or 1400이 아닌 사원명 검색
-- null값 미포함!!!
select ename, sal, comm
from emp 
where comm not in (300, 500, 1400) and comm is not null;

-- 26. 81/09/28 날 입사한 사원 이름.사번 검색
-- date 타입 비교 학습
-- date 타입은 '' 표현식 가능 
-- yy/mm/dd 포멧은 차후에 변경 예정(함수)
select ename, empno
from emp
where hiredate = '81/09/28';

select ename, empno
from emp
where hiredate = '1981/09/28';

select ename, empno
from emp
where hiredate = '1981-09-28';

select ename, empno
from emp
where hiredate = '81-09-28';


-- 27. 날짜 타입의 범위를 기준으로 검색
-- 범위비교시 연산자 : between~and 1980-12-17~1981-09-28
select hiredate
from emp
where hiredate between '1980-12-17' and '1981-09-28';


-- 28. 검색시 포함된 모든 데이터 검색하는 기술
-- 참고 : 실행속도 낮음
-- 빠른 검색이 중요할 경우 검색 기능은 검색 엔진이 내장된 sw들 사용을 권장

-- 순수 sql 문장으로 검색
-- like 연산자 사용
-- % : 철자 개수 무관하게 검색 / _ : 철자 개수 하나를 의미

-- 29. 두번째 음절의 단어가 M(_M)인 모든 사원명 검색 
select ename
from emp
where ename Like '_M%';

-- 두개의 글자, 단 두번째는 M이어야함.
select ename
from emp
where ename Like '_M';

-- 30. 단어가 M을 포함한 모든 사원명 검색
select ename
from emp
where ename Like '%M%';
