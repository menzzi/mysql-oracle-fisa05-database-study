-- 민지
-- Q1. 각 부서 별 월급 평균, 부서 번호 출력 (부서 번호 오름차순)
SELECT avg(sal) AS 평균월급, deptno AS 부서번호
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- 여명
-- Q2. 커미션이 null 이 아닌 직원을 가진 부서에 속한 사원 중 마지막 글자가 'N'인 데이터를(부서코드와 사원명) alias 써서 "부서 코드", "사원명"이라는 컬럼명으로 출력
SELECT deptno AS "부서 코드", ename AS 사원명
FROM emp
WHERE comm IS NOT NULL AND ename LIKE '%N';

-- 소영
-- Q3. hiredate가 1981년 5월 이후인 직원들의 COMM을 출력하기 단, NULL이면 0값으로 대체
SELECT NVL(comm, 0) AS comm
FROM emp
WHERE hiredate >= to_date('1981-05', 'YYYY-MM');

-- 태우
-- Q4. SAL + COMM 총합 평균보다 높은 사람, 직업 출력 null->0으로 대체 
SELECT ename, job
FROM emp
WHERE sal + NVL(comm,0) > (SELECT avg(sal + NVL(comm, 0)) FROM emp)
