public class ScoreCardAPI {
    List<Summary_of_Transactions__c> sumObj=new List<Summary_of_Transactions__c>();
    List<ScoreCard__c> scoreCard=new List<ScoreCard__c>();
    public ScoreCardAPI(){
        this.sumObj.addAll([select id,name,Debits__c,Credits__c,Verifiable_Sales__c,Opening_Balance__c,Closing_Balance__c,Maximum_Bal__c,Minimum_Bal__c from Summary_of_Transactions__c]);
        this.scoreCard.addAll([select id,Average_Balance_last_3M__c,Average_Credits_6M__c,Average_Debit_6M__c,Average_Max_Balance_last_6M__c,Average_Min_Balance_last_6M__c,Average_monthly_verifiable_sales_3M__c from ScoreCard__c]);
        
    }
    public id computeScore(){
        Decimal avgCredit;
        Decimal avgDebit;
        Decimal avgMaxBal;
        Decimal avgMinBal;
        Decimal avgVerSales;
        Decimal count=0;
        for(Summary_of_Transactions__c sc:sumObj){
            if(count<6){
                avgCredit=+sc.Credits__c;
                avgDebit=+sc.debits__c;
                avgMaxBal=+sc.Maximum_Bal__c;
                avgMinBal=+sc.Minimum_Bal__c;
                avgVerSales=+sc.Verifiable_Sales__c;     
                
            }
            count++;
        }
        ScoreCard_Result__c scrObj=new ScoreCard_Result__c();
        if(scoreCard[0].Average_monthly_verifiable_sales_3M__c<avgVerSales)
        scrObj.avgVerSales__c=true;
        if(scoreCard[0].Average_Debit_6M__c<avgDebit)
        scrObj.avgDebit__c=true;
         if(scoreCard[0].Average_Credits_6M__c<avgCredit)
        scrObj.avgCredit__c=true;
        if(scoreCard[0].Average_Max_Balance_last_6M__c<avgMaxBal)
        scrObj.avgMaxBal__c=true;
        if(scoreCard[0].Average_Min_Balance_last_6M__c<avgMinBal)
        scrObj.avgMinBal__c=true;
        
        insert scrObj;        
        
        system.debug(avgVerSales);
        system.debug(avgCredit);
        system.debug(avgDebit);
        system.debug(avgMaxBal);
        system.debug(avgMinBal);
        return scrObj.id;
      
        
    }

}