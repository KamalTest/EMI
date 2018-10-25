public class RepaymentController {
    Id repId;
    public Blob csvFileBody{get;set;}
    Public string csvAsString{get;set;}
    Public String[] csvfilelines{get;set;}
    Public String[] inputvalues{get;set;}
    public Integer value {get;set;}
       Repayment_Test_Obj__c repObj{set;get;}
    List<Repayment_Unique__c> repObject2{set;get;}
    public RepaymentController(ApexPages.StandardController controller){
        this.repId=ApexPages.currentPage().getParameters().get('Id');
        repObj = (Repayment_Test_Obj__c)controller.getRecord();
    }
    Public void readcsvFile(){
        csvAsString = csvFileBody.toString();
        csvfilelines = csvAsString.split('\n');
        system.debug(csvfilelines[0]);
        List<string> fieldList = new List<STring>();
        inputvalues = new String[]{};
            for(string st:csvfilelines[0].split(',')) 
            fieldList.add(st);   
        List<Repayment_Test_Obj__c> sObjectList=new List<Repayment_Test_Obj__c>();
        sObjectList=[select id,name from Repayment_Test_Obj__c ];
        if(sObjectList!=null){
            delete sObjectList;
        }
        system.debug(csvfilelines.size());
        for(Integer i=1;i<2;i++){
            Repayment_Test_Obj__c repObj=new Repayment_Test_Obj__c();
            string[] csvRecordData = csvfilelines[i].split(',');
            
            system.debug(csvRecordData[0]);
            repObj.Date__c= Date.valueOf(csvRecordData[0]) ;     
            repObj.Description__c= csvRecordData[1] ;     
            repObj.Reference__c= csvRecordData[2] ;    
            repObj.Payee__c= csvRecordData[3] ;     
            repObj.Amount__c=decimal.valueOf(csvRecordData[4]) ;     
            repObj.Balance__c= decimal.valueOf(csvRecordData[5]) ;      
            repObj.Classification__c= csvRecordData[6] ;     
            repObj.AccountNumber__c= csvRecordData[7] ;     
            repObj.AccountName__c= csvRecordData[8] ;    
            repObj.LoanId__c= csvRecordData[9] ;     
            repObj.Type__c= csvRecordData[10] ;     
            repObj.BankName__c= csvRecordData[11] ;    
            sObjectList.add(repObj);
            
        }
        system.debug(sObjectList.size());
        upsert sObjectList;
        
        
    }
    public PageReference selectBank(){
          PageReference pageRef = new PageReference('/apex/selectRepaymentBank');
        return pageRef;
    }
    public PageReference scorecard(){
        ScoreCardAPI sc=new ScoreCardAPI();
        Id score=sc.computeScore();
         PageReference pageRef = new PageReference('/'+score);
        return pageRef;
    }
    public PageReference Generate(){ 
        String descp=(this.repObj).Description__c;
        Date dt=this.repObj.Date__c;
        system.debug(this.repObj);
        RepaymentHandler re=new RepaymentHandler();
        re.assignwrtKeywords(this.repObj);
//        re.tranSummary();
        //  this.repObject2.addAll([select id,amount__c,Description__c,GetCap_Classification__c,Lender_Type__c,Total_Number__c,End_Date__c,Start_Date__c,Frequency__c,Live__c,Number_of_Days__c,Payment_Freq__c from Repayment_Unique__c]);     
       // PageReference pageRef = new PageReference('/apex/Repayment_Module');
        return null;
    }
    public PageReference GenerateCredit(){ 
        String descp=(this.repObj).Description__c;
        Date dt=this.repObj.Date__c;
        system.debug(this.repObj);
        RepaymentHandler re=new RepaymentHandler();
        re.assignCreditwrtKeywords(this.repObj,null);
        //re.tranSummary();
        //  this.repObject2.addAll([select id,amount__c,Description__c,GetCap_Classification__c,Lender_Type__c,Total_Number__c,End_Date__c,Start_Date__c,Frequency__c,Live__c,Number_of_Days__c,Payment_Freq__c from Repayment_Unique__c]);     
      //  PageReference pageRef = new PageReference('/apex/CreditTran');
        return NULL;
    }
    public PageReference summary(){ 
        
        RepaymentHandler re=new RepaymentHandler();
        re.assignwrtKeywords(this.repObj);
        re.tranSummary();
        //  this.repObject2.addAll([select id,amount__c,Description__c,GetCap_Classification__c,Lender_Type__c,Total_Number__c,End_Date__c,Start_Date__c,Frequency__c,Live__c,Number_of_Days__c,Payment_Freq__c from Repayment_Unique__c]);     
        //PageReference pageRef = new PageReference('/a07?fcf=00B7F000008Z7ID');
        return null;
    }
    public List<Repayment_Unique__c> getRep(){      
        
        return([select id,amount__c,Description__c,GetCap_Classification__c,Lender_Type__c,Total_Number__c,End_Date__c,Start_Date__c,Frequency__c,Number_of_Days__c,Payment_Freq__c from Repayment_Unique__c]);
        
        
    }
   
    public List<Repayment_Test_Obj__c> getObj(){
        List<Repayment_Test_Obj__c> repObj=[select id,BankName__c,AccountNumber__c,AccountName__c from Repayment_Test_Obj__c ];
        List<Repayment_Test_Obj__c> OUToBJ=new List<Repayment_Test_Obj__c>();
        Map<String,Repayment_Test_Obj__c> repMap=new Map<STring,Repayment_Test_Obj__c>();
        
        for(Repayment_Test_Obj__c re: repObj){
            repMap.put(re.AccountNumber__c,re);
        }
        for(STring q: repMap.keySet()){
            outObj.add(repMap.get(q));
        }
        return outObj;
        
    }
    public List<Repayment_Credit_Payment__c> getCredit(){      
        
        return([select id,amount__c,Category__c,Particulars__c,date__C from Repayment_Credit_Payment__c]);
        
        
    }
    public List<Summary_of_Transactions__c> getSum(){      
        List<Summary_of_Transactions__c> sumObj=[select id,Average_Balance__c,Closing_Balance__c,Credits__c,Debits__c,Loan_Credits__c,Maximum_Bal__c,Minimum_Bal__c,Month__c,Number_of_Returns__c,Opening_Balance__c,Returns__c,Transactions_over_400__c,Verifiable_Sales__c from Summary_of_Transactions__c];
        return(sumObj);
        
        
    }
    public List<PieWedgeData> getSumData(){
         List<PieWedgeData> data = new List<PieWedgeData>();
          List<Summary_of_Transactions__c> sumObj=[select id,Average_Balance__c,Closing_Balance__c,Credits__c,Debits__c,Loan_Credits__c,Maximum_Bal__c,Minimum_Bal__c,Month__c,Number_of_Returns__c,Opening_Balance__c,Returns__c,Transactions_over_400__c,Verifiable_Sales__c from Summary_of_Transactions__c];
        for(Summary_of_Transactions__c s:sumObj){
            data.add(new PieWedgeData(s.Month__c,s.Maximum_Bal__c));
            
        }
        return data;
    }
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