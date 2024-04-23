SELECT * FROM V_RECORD;
create OR REPLACE view v_record AS
SELECT RECORD_SUBJECT_ID
, (SELECT SUBJECT_NAME FROM SUBJECT WHERE RECORD_SUBJECT_ID = SUBJECT_ID) AS SUBJECT_NAME
, RECORD_MEM_ID
    , TRUNC(RECORD_START) RECORD_DATE
    , NUMTODSINTERVAL( SUM(RECORD_END - RECORD_START) ,'DAY') DIFFTIME
FROM RECORD 
GROUP BY RECORD_SUBJECT_ID, RECORD_MEM_ID, TRUNC(RECORD_START)
;


SELECT * FROM v_record_WO_SUBJECT;
create OR REPLACE view v_record_WO_SUBJECT AS
SELECT RECORD_MEM_ID
    , TRUNC(RECORD_START) RECORD_DATE
    , NUMTODSINTERVAL( SUM(RECORD_END - RECORD_START) ,'DAY') DIFFTIME
FROM RECORD 
GROUP BY RECORD_MEM_ID, TRUNC(RECORD_START)
;

SELECT * FROM v_record_WO_SUBJECT_W_GROUP;
create OR REPLACE view v_record_WO_SUBJECT_W_GROUP AS
SELECT SGROUP_ID, sgroup_mem_id, RECORD_DATE, DIFFTIME
FROM sgroup_member TS 
LEFT JOIN (SELECT RECORD_MEM_ID
        , TRUNC(RECORD_START) RECORD_DATE
        , NUMTODSINTERVAL( SUM(RECORD_END - RECORD_START) ,'DAY') DIFFTIME
        ---, 과목이름
    FROM RECORD 
    GROUP BY RECORD_MEM_ID, TRUNC(RECORD_START)) TR
ON sgroup_mem_id = RECORD_MEM_ID
;

SELECT * FROM v_record_WEEK;
create OR REPLACE view v_record_WEEK AS
SELECT RECORD_MEM_ID
    , NUMTODSINTERVAL( SUM(RECORD_END - RECORD_START) ,'DAY') DIFFTIME
    ---, 과목이름
FROM RECORD 
WHERE TRUNC(RECORD_START) BETWEEN TRUNC(SYSDATE-7) AND TRUNC(SYSDATE-1)
GROUP BY RECORD_MEM_ID
;

alter session set nls_date_format='YYYY/MM/DD HH24:MI:SS';