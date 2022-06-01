global class ScheduleSendLeadDetail implements schedulable{
    global void execute(SchedulableContext sc){
        SendEmailFromLead objLead = new SendEmailFromLead();
        Database.executeBatch(objLead) ;
    }
}