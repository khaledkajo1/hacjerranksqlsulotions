
select n,
case when p is null then 'Root' 
       when p is not null and 
       n in (select distinct p from BST) then 'Inner'
       else 'Leaf' end
from BST  
order by n
