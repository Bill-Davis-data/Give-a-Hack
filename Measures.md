MEASURE '9 public needs_ticket_status'[TicketCount] = 
COUNT('9 public needs_ticket_status'[need_id])

MEASURE '4 public organizations'[TopOrg] = 
RANKX(
    ALLSELECTED('4 public organizations'[name]),
    [TicketCount],
    ,
    DESC,
    DENSE
)
