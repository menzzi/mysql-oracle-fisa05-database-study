# 📘 SQL 검색 단계 정리
## 🔹 Step 01 - 기본 검색
``` sql
SELECT 컬럼명
FROM 테이블명;
```
SELECT: 가져올 컬럼명
FROM: 데이터를 조회할 테이블명  



## 🔹 Step 02 - 정렬 검색
``` sql
SELECT 컬럼명
FROM 테이블명
ORDER BY 컬럼명 ASC|DESC;
```
ORDER BY: 특정 컬럼 기준으로 정렬

ASC: 오름차순 (기본값)

DESC: 내림차순  



## 🔹 Step 03 - 조건 검색
``` sql
SELECT 컬럼명
FROM 테이블명
WHERE 조건;
```
WHERE: 조건에 맞는 행만 조회  



## 🔹 Step 04 - 조건 + 정렬 검색
``` sql
SELECT 컬럼명
FROM 테이블명
WHERE 조건
ORDER BY 컬럼명 ASC|DESC;
```

## 💡 MySQL만의 특징
✅ 기본적으로 데이터 값의 대소문자를 구분하지 않음

⚠️ 하지만 컬럼명/테이블명 등은 대소문자 구분이 필요할 수 있음  



## 🛠️ 대소문자 문제 해결 방법
1. ALTER 명령으로 테이블 설정 변경
``` sql
ALTER TABLE 테이블명 MODIFY 컬럼명 VARCHAR(100) BINARY;
```


2. SELECT 시 BINARY 키워드 사용
``` sql
SELECT * FROM 테이블명 WHERE BINARY 컬럼명 = '값';
```


## 🧠 SQL Practice Problems (Team Study)
각 팀원이 하나씩 출제한 SQL 연습 문제입니다.
직접 데이터를 다뤄보며 실전 감각을 키우기 위한 스터디용 문제입니다.

### 💡 Q1. 각 부서별 평균 월급 출력
📝 문제 출제: 민지

요구사항:

- emp 테이블에서 부서별 평균 월급(avg(sal))과 부서 번호(deptno)를 조회

- 부서 번호 기준 오름차순 정렬

```sql
SELECT avg(sal) AS 평균월급, deptno AS 부서번호
FROM emp
GROUP BY deptno
ORDER BY deptno;
```  


### 💡 Q2. 커미션이 있는 부서의, 이름이 'N'으로 끝나는 사원 조회
📝 문제 출제: 여명

요구사항:

- comm이 NULL이 아닌 직원이 있는 부서에 속한 사원 중

- 사원명(ename)의 마지막 글자가 'N'인 직원

- 컬럼명: "부서 코드", "사원명"

```sql
SELECT deptno AS "부서 코드", ename AS 사원명
FROM emp
WHERE comm IS NOT NULL AND ename LIKE '%N';
```  

### 💡 Q3. 1981년 5월 이후 입사자의 커미션 출력 (NULL → 0 대체)
📝 문제 출제: 소영

요구사항:

- hiredate가 1981년 5월 이후인 직원의 comm 값을 출력

- comm이 NULL이면 0으로 출력

```sql
SELECT NVL(comm, 0) AS comm
FROM emp
WHERE hiredate >= TO_DATE('1981-05', 'YYYY-MM');
```  

### 💡 Q4. SAL + COMM의 총합 평균보다 높은 직원 조회
📝 문제 출제: 태우

요구사항:

- sal + comm 값이 전체 평균보다 높은 사원의 이름(ename)과 직무(job) 출력

- comm이 NULL이면 0으로 대체

```sql
SELECT ename, job
FROM emp
WHERE sal + NVL(comm, 0) > (
  SELECT avg(sal + NVL(comm, 0)) FROM emp
);
```


| [고태우](https://github.com/kohtaewoo) | [박여명](https://github.com/yeomyeoung) | [서민지](https://github.com/menzzi) | [최소영](https://github.com/ottffss1005) |
| :------------------------------------: | :--------------------------------------: | :----------------------------------: | :----------------------------------------: |
| <img src="https://avatars.githubusercontent.com/kohtaewoo" width="100" /> | <img src="https://avatars.githubusercontent.com/yeomyeoung" width="100" /> | <img src="https://avatars.githubusercontent.com/menzzi" width="100" /> | <img src="https://avatars.githubusercontent.com/ottffss1005" width="100" /> |

