--排名表 as 临时表
select *,
        row_number() over (order by 访问量 desc) as 排名
from 用户访问次数表;

--找出20%
select max(排名)
from 临时表



select *
from 临时表
where 排名 <= (select max(排名) from 临时表) * 0.2 ;

---剔除前20%
select *
from (select *,
        row_number() over (order by 访问量 desc) as 排名
from 用户访问次数表)
where 排名 > (select max(排名) from 临时表) * 0.2 ;


--每类用户的平均访问次数
select 用户类型,avg(访问量) as 平均访问次数
from (select *
from (select *,
        row_number() over (order by 访问量 desc) as 排名
from 用户访问次数表)
where 排名 > (select max(排名) from 临时表) * 0.2 )
group by 用户类型;