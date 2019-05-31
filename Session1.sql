--create table student (
--sid int,
--name char(20) )
--create table class(
--cno char(10),
--code char(10),
--sid int)


--select sum(unit)
--from  teacher ,course, class
--where teacher.tid=course.tid and class.code = course.code 
--group by class.code


select TeacherName, sum(Total_unit)
from (select name, unit from 
teacher, (select course.tid, course.unit
from course, (select cno, code from class
group by cno, code) as A
where teacher.tid = B.tid) as Tab(TeacherName, Total_unit)
group by Tab.TeacherName
 
