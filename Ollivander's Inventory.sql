with wlist as (
select wp.age , min(w.coins_needed) as coins , w.power
from wands as w
inner join wands_property as wp
    on wp.code = w.code
where is_evil = 0
group by wp.age , w.power) 
select w.id , wp.age , w.coins_needed , w.power
from wands as w
inner join wands_property as wp
on wp.code = w.code
inner join wlist
on wlist.age = wp.age
and wlist.power = w.power
and wlist.coins = w.coins_needed
order by w.power desc,wp.age desc
