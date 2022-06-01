trigger OppTotalAmount on Opportunity (before insert, before update) {
Opp_trigger_Class.Opp_trigger_method(trigger.new);
}