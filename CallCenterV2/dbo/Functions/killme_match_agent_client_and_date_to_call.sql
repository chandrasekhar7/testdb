-- =============================================
-- Author:		THIS IS OF NO USE AND CAN BE DELETED
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION killme_match_agent_client_and_date_to_call
(
	@date datetime, 
	@agent uniqueidentifier
)
RETURNS 
@tbl TABLE 
(
	teller varchar(3)
	, Firstname varchar(50)
	, Lastname varchar(50)
	, callstart datetime
	, [length] time
	, direction varchar(1)
	, [From] varchar(11)
	, [To] varchar(11)
	, power_id int
)
AS
BEGIN

	insert into @tbl 
	select top 1
	a.Agent
	, a.FirstName
	, a.LastName
	, ac.CallStart
	, convert(time, ac.CallEnd - ac.CallStart)
	, c.CallDirection
	, c.FromNumber
	, c.ToNumber
	, c.CustomerID
	from Agents a with(nolock) 
	inner join AgentCalls ac with(nolock) on ac.AgentID = a.AgentID and ac.CallStart between dateadd(second, -100, @date) and dateadd(second, 10, @date)
	left join Calls c with(nolock) on c.CallID = ac.CallID
	where a.AgentUI = @agent
	order by ac.CallStart desc
	
	RETURN 
END
