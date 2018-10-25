public with sharing class Graph 
{  
    public List<PieWedgeData> getPieData() 
    {  
        List<PieWedgeData> data = new List<PieWedgeData>();
         List<Summary_of_Transactions__c> sumObj=[select id,Average_Balance__c,Closing_Balance__c,Credits__c,Debits__c,Loan_Credits__c,Maximum_Bal__c,Minimum_Bal__c,Month__c,Number_of_Returns__c,Opening_Balance__c,Returns__c,Transactions_over_400__c,Verifiable_Sales__c from Summary_of_Transactions__c];
        for(Summary_of_Transactions__c s:sumObj){
            data.add(new PieWedgeData(s.Month__c,s.Maximum_Bal__c));
            
        }
        return data;
    }
     
    
    // Wrapper class  
    public class PieWedgeData 
    {  
        public String name { get; set; }  
        public Decimal data { get; set; }  
        
        public PieWedgeData(String name, Decimal data) 
        {  
            this.name = name;  
            this.data = data;  
        }  
    }  
}