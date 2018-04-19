----------------------------------------------------------------------------------------------
-- Name: 	login.sql
-- Purpose: configure login
-- Run As: 	DBA
-- Syntax:  @login
----------------------------------------------------------------------------------------------
-- History: 20180416 (ewelvang)  Created
----------------------------------------------------------------------------------------------

@H:\Oracle\sqlprompt.sql
host cls

set		pagesize 		0
set		linesize 		250
set		feedback 		off
set		verify			off
set		timing			off
set		serveroutput	on size 100000


select	* 
  from 	v$version;
  
select ' 	' from dual;

declare	
  lv_where		v$database.name%TYPE;
  lv_svr		v$instance.host_name%TYPE;
  lv_log		v$database.log_mode%TYPE;
  lv_sid		v$thread.instance%TYPE;
  
begin  
  select	name into lv_where
    from 	v$database;
  select	log_mode into lv_log
    from	v$database;
  select	host_name into lv_svr
    from	v$instance;
  select	instance into lv_sid
    from	v$thread;
			dbms_output.put_line('Database '||lv_where||' on server '||lv_svr||' is in '||lv_log||' - SID: '||lv_sid||';');
			dbms_output.put_line(' 	');
				
end;
/

------------------------------------------------------------------------------------------------------------------
-- Start Scripts
------------------------------------------------------------------------------------------------------------------
col		statement01		for a30
col		statement02		for a120

-- RMAN last backup
select	' 	', object_type||' '||operation||' '||status statement01
		,'started - '||to_char(start_time,'mm/dd/yyyy:hh:mi:ss')||'  ended - '||
		to_char(end_time,'mm/dd/yyyy:hh:mi:ss') as statement02  
  from 	v$rman_status  
 where 	operation = 'BACKUP'  
   and 	object_type = 'DB FULL' 
   and 	end_time in 
		(select 	max(end_time)
 		   from 	v$rman_status
 		  where operation = 'BACKUP' and object_type = 'DB FULL')   
 order 	by start_time asc; 

select '	' from dual;

-- archivelog backup for past 3 hours 
select	' 	', object_type||' '||operation||' '||status statement01
		,'started - '||to_char(start_time,'mm/dd/yyyy:hh:mi:ss')||'  ended - '||
		to_char(end_time,'mm/dd/yyyy:hh:mi:ss') as statement02  
  from	v$rman_status  
 where	operation = 'BACKUP'  
   and	object_type = 'ARCHIVELOG'
   and	start_time > sysdate-3/24
 order 	by start_time asc; 
 
select '	' from dual;

			
set	pagesize 	50000
set feedback 	on
set heading 	on
set	linesize 	200
set	echo     	off
set	verify 		off
set timing 		on

col audit_option 	for a30
col audit_trail 	for a20
col check_name      for a50
col client_name 	for a35
col comment$        for a100 wrap on
col db_link         for a30
col default_ts		for a15
col default_value	for a20
col description     for a80
col dest_name 		for a30
col destination 	for a30
col	directory_path	for a45
col	file_name 		for a80
col global_name 	for a20
col host 			for a60 word_wrap on
col host_name		for a20
col job_action 		for a80 word_wrap on
col job_creator 	for a18
col job_name 		for a21
col	name			for a40
col next_run_date	for a35
col	owner			for a18
col parameter_name 	for a30
col parameter_value	for a15
col proxy_name 		for a30
col repeat_interval for a70
col segment_name	for a10
col start_date 		for a10
col	tablespace_name	for a15
col temp_ts 		for a8
col type 			for a15
col user_name 		for a22
col username 		for a22
col	value			for a70
