with observation_params as     
(
    select  interval '%metric_interval' as metric_period,
    '%from_yyyy-mm-dd'::timestamp as obs_start,
    '%to_yyyy-mm-dd'::timestamp as obs_end
)
select m.account_id, o.observation_date, is_churn,
sum(case when metric_name_id=0 then metric_value else 0 end) as search,
sum(case when metric_name_id=1 then metric_value else 0 end) as create_search,
sum(case when metric_name_id=2 then metric_value else 0 end) as edit_search,
sum(case when metric_name_id=3 then metric_value else 0 end) as delete_search,
sum(case when metric_name_id=4 then metric_value else 0 end) as win_opportunity,
sum(case when metric_name_id=5 then metric_value else 0 end) as advance_stage,
sum(case when metric_name_id=6 then metric_value else 0 end) as add_competitor,
sum(case when metric_name_id=7 then metric_value else 0 end) as disqualify_opportunity,
sum(case when metric_name_id=8 then metric_value else 0 end) as lose_opportunity,
sum(case when metric_name_id=9 then metric_value else 0 end) as quote,
sum(case when metric_name_id=10 then metric_value else 0 end) as create_opportunity,
sum(case when metric_name_id=11 then metric_value else 0 end) as add_contact,
sum(case when metric_name_id=12 then metric_value else 0 end) as edit_contact,
sum(case when metric_name_id=13 then metric_value else 0 end) as add_lead,
sum(case when metric_name_id=14 then metric_value else 0 end) as unsub_lead,
sum(case when metric_name_id=15 then metric_value else 0 end) as edit_lead,
sum(case when metric_name_id=16 then metric_value else 0 end) as email_lead,
sum(case when metric_name_id=17 then metric_value else 0 end) as call_lead,
sum(case when metric_name_id=18 then metric_value else 0 end) as create_list,
sum(case when metric_name_id=19 then metric_value else 0 end) as delete_list,
sum(case when metric_name_id=20 then metric_value else 0 end) as email_list,
sum(case when metric_name_id=21 then metric_value else 0 end) as meeting,
sum(case when metric_name_id=22 then metric_value else 0 end) as schedule_meeting,
sum(case when metric_name_id=23 then metric_value else 0 end) as edit_meeting,
sum(case when metric_name_id=24 then metric_value else 0 end) as cancel_meeting,
sum(case when metric_name_id=25 then metric_value else 0 end) as mrr,
sum(case when metric_name_id=31 then metric_value else 0 end) as opp_value_won,
sum(case when metric_name_id=32 then metric_value else 0 end) as opp_value_lost,
sum(case when metric_name_id=33 then metric_value else 0 end) as opp_value_per_dollar,
sum(case when metric_name_id=47 then metric_value else 0 end) as mrr_per_dollar_closed
from metric m inner join observation_params
on metric_time between obs_start and obs_end    
inner join observation o on m.account_id = o.account_id
    and m.metric_time > (o.observation_date - metric_period)::timestamp    
    and m.metric_time <= o.observation_date::timestamp
group by m.account_id, metric_time, observation_date, is_churn    
order by observation_date,m.account_id
