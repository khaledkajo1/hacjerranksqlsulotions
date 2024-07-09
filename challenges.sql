WITH count_challenges AS (
                                       SELECT h.hacker_id , name , count(c.challenge_id) as challenges_created
                                      from hackers as h
                                       left join challenges as c
                                       on c.hacker_id = h.hacker_id
                                       group by h.hacker_id ,name),
max_counts as (select max(challenges_created) as max_challenges from count_challenges) ,
exclude_challenges as (select challenges_created 
                      from count_challenges
                      where challenges_created < (select max_challenges from max_counts)
                                                 group by challenges_created
                                                 having count(hacker_id) >1)
 select cc.hacker_id,
                       cc.name,
                       cc.challenges_created
                       from count_challenges as cc
                       where challenges_created > (select max_challenges from max_counts)
                       or challenges_created not in (select challenges_created from exclude_challenges)
                       order by challenges_created desc,hacker_id
