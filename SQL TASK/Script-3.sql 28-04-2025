--SQL Task: Monthly Active Users and Retention

select * from users u 

select * from logins l

with MonthlyActiveUser as(
	select to_char(login_date,'YYYY-MM') as month,
	COUNT(distinct user_id) as mau
	from logins l 
	where login_date >= current_date - interval '12 months'
	group by to_char(login_date,'YYYY-MM')
),
userSignUp as(
	select to_char(signup_date,'YYYY-MM') as singup_month,
	COUNT(*) as signup_user
	from users u 
	group by to_char(signup_date,'YYYY-MM')
),
Retention as (
	select to_char(signup_date ,'YYYY-MM') as signup_date,
	COUNT(distinct u.user_id) as signup_user,
	count(
		distinct case
			when l.login_date between u.signup_date + interval '1 month' 
			and u.signup_date + interval '2 months'- interval '1 day'
			then l.user_id
			else null 
		end) as retained_users
	from users u 
	left join logins l on u.user_id = l.user_id
	group by to_char(signup_date ,'YYYY-MM')
)
select 
	r.signup_date as month,
	r.signup_user,
	r.retained_users,
	round((r.retained_users::numeric/r.signup_user * 100),2) as retention_rate
from Retention r
order by "month";

