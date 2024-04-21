select * from sgroup;

SELECT SGROUP_ID, SGROUP_NAME, SGROUP_IMG_PATH,
		SGROUP_IMG_NAME FROM SGROUP
		WHERE SGROUP_ID IN
		(SELECT SGROUP_ID
		FROM
		SGROUP_MEMBER
		WHERE
		SGROUP_MEM_ID ='b');
        
select s.*, count(*) OVER(PARTITION BY 1) from         
(SELECT *  FROM SGROUP
    JOIN SGROUP_MEMBER USING (SGROUP_ID)
		WHERE SGROUP_ID = '53') s;
        
SELECT S.SGROUP_ID, S.SGROUP_NAME, S.SGROUP_OPEN,
		S.SGROUP_PWD, S.SGROUP_EXPLAIN, S.SGROUP_IMG_PATH, S.SGROUP_IMG_NAME, S.SGROUP_MEM_ID,
		COUNT(*) OVER(PARTITION BY 1) MEM_COUNT FROM
		(SELECT * FROM SGROUP
		JOIN
		SGROUP_MEMBER USING (SGROUP_ID)
		WHERE SGROUP_ID = '53') S;


    
select * from sgroup_member;
insert into SGROUP_MEMBER(sgroup_id, sgroup_mem_id) VALUES (53, 'song');
insert into SGROUP_MEMBER(sgroup_id, sgroup_mem_id) VALUES (53, 'won');
commit;


select *from member;

select * from record  where record_mem_id = 'oh';




--원본 기록 있는 사용자만 나옴
SELECT
    round(SUM(to_number(to_char(record_end, 'HH24MISS')) - to_number(to_char(record_start, 'HH24MISS'))) / 100) AS "SUM_MIN", record_mem_id AS "MEMID"
FROM
    record
WHERE record_start >= ( sysdate - 7 ) AND  record_mem_id IN (SELECT SGROUP_MEM_ID FROM SGROUP_MEMBER WHERE SGROUP_ID = '53')
GROUP BY record_mem_id;

--원본 기록 있는 사용자만 나옴
SELECT
    round(SUM(to_number(to_char(record_end, 'HH24MISS')) - to_number(to_char(record_start, 'HH24MISS'))) / 100) 
FROM
    record
WHERE record_start >= ( sysdate - 7 ) AND  record_mem_id = 'b';



select sum(to_number(TO_DATE(record_end, 'HH24MISS') - TO_DATE(record_start, 'HH24MISS')))
from record where record_mem_id = 'song'
and record_start >=(SYSDATE-14) ;

SELECT TO_CHAR((record_end - record_start),'HH24MISS')from record where record_mem_id = 'song'
and record_start >=(SYSDATE-7) ;



select record_end - record_start, record_mem_id
from record where record_mem_id = 'song'
and record_start >=(SYSDATE-7) ;

SELECT to_number(TO_CHAR(record_end, 'HH24MISS')), to_number(TO_CHAR(record_start, 'HH24MISS')) FROM record;

select TO_CHAR(ROUND(sum(to_number(TO_CHAR(record_end, 'HH24MISS')) - to_number(TO_CHAR(record_start, 'HH24MISS')))/24/60/60),'hh24:mi:ss')
from record where record_mem_id = 'song'
and record_start >=(SYSDATE-7) ;


SELECT      TO_CHAR(TRUNC(SYSDATE) + NUMTODSINTERVAL(1425, 'second'),'hh24:mi:ss') "hh24:mi:ss 로 변환_1번째 방법",
            TO_CHAR(TO_DATE(1425,'sssss'),'hh24:mi:ss') "hh24:mi:ss 로 변환_2번째 방법",       
            TO_CHAR(TRUNC(1425/3600),'FM9900') || ':' ||
            TO_CHAR(TRUNC(MOD(1425,3600)/60),'FM00') || ':' ||
            TO_CHAR(MOD(1425,60),'FM00') "hh24:mi:ss 로 변환_3번째 방법"
FROM        DUAL;

SELECT
    SYSDATE + 1, -- 현재시간 + 1일
    SYSDATE + 1/24, -- 현재시간 + 1시간
    SYSDATE + 1/24/60,  -- 현재시간 + 1분
    SYSDATE + 1/24/60/60,  -- 현재시간 + 1초
    (SYSDATE - (SYSDATE -1)) *24, -- 오늘날짜 - 어제날짜 경과한 시간 시간단위 환산
    (SYSDATE - (SYSDATE -1)) *24*60, -- 오늘날짜 - 어제날짜 경과한 시간 분단위 환산
    (SYSDATE - (SYSDATE -1)) *24*60*60 -- 오늘날짜 - 어제날짜 경과한 시간 초단위 환산
FROM DUAL;

SELECT    DECODE (TRUNC (2000 / 60), 0, '', TRUNC (2000 / 60) || '시간 ')
       || LPAD ((MOD (2000, 60)), 2, '0')
       || '분'
  FROM DUAL;
  
  
select sum(to_number(TO_CHAR((record_end- record_start), 'HH24MISS')))
from record where record_mem_id = 'song'
and record_start >=(SYSDATE-7) ;

SELECT      TO_CHAR(TRUNC(171425/(3600*24)),'FM00') || ':' ||
            MOD(TRUNC(171425/3600),24) || ':' || 
            TO_CHAR(TRUNC(MOD(171425,3600)/60),'FM00') || ':' ||
            TO_CHAR(MOD(171425,60),'FM00') "dd:hh:mm:ss 로 변경"
FROM        DUAL;

select * from sgroup;

update sgroup set sgroup_explain= '수정중'
where sgroup_id = 52;



select * from (
    select * from sgroup order by DBMS_RANDOM.RANDOM
)
where rownum <= 20;