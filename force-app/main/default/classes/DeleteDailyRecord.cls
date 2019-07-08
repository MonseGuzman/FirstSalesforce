global class DeleteDailyRecord implements Schedulable {
    global void execute(SchedulableContext context){
        List <School__c> listSchool = [SELECT Number_Teachers__c, Number_Students__c FROM School__c];
        for(School__c s : listSchool){
            if(s.Number_Students__c == 0 && s.Number_Teachers__c == 0){
                delete s;
            }
        }
    }

}