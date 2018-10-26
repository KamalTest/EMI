public class wrapperClassController {
    public List<cRepayment> repList {get;set;}
    public Repayment_Test_Obj__c repObj{set;get;}
    public List<Repayment_Test_Obj__c> rejTestObj{get;set;}
    public Integer value {get;set;}
    public String description{get;set;}
    public Date toDate{get;set;}
    public Date fromDate{get;set;}
    Map<String,String> rejectMap=new Map<String,String>();
    Map<String,String> finalMap=new Map<String,String>();
    Map<String,String> finalMap1=new Map<String,String>();
    Map<String,String> finalMapCredit=new Map<String,String>();
    List<Repayment_All_Payment__c> repAllList=new List<Repayment_All_Payment__c>();
    List<Repayment_Credit_Payment__c> repAllListCredit=new List<Repayment_Credit_Payment__c>();
    List<Repayment_Test_Obj__c> tstObj=new List<Repayment_Test_Obj__c>();
    List<Repayment_Test_Obj__c> finaltstObj=new List<Repayment_Test_Obj__c>();
    Map<String,Repayment_Keywords__c> keyDesc=new Map<String,Repayment_Keywords__c>() ;
    Map<String,Repayment_Test_Obj__c> fullDesc=new Map<String,Repayment_Test_Obj__c>() ;
    Map<String,Repayment_Test_Obj__c> firstFilterDesc=new Map<String,Repayment_Test_Obj__c>() ;
    Map<String,Repayment_Test_Obj__c> firstFilterDescCredit=new Map<String,Repayment_Test_Obj__c>() ;
    List<Repayment_Rejection__c> rejectList=new List<Repayment_Rejection__c>();
    Map<String,Repayment_Test_Obj__c> repMap=new Map<STring,Repayment_Test_Obj__c>();
    //String description;
    public wrapperClassController()
    {
        repList = new List<cRepayment>();
        List<Repayment_Test_Obj__c> repObj=[select id,description__c,BankName__c,AccountNumber__c,AccountName__c from Repayment_Test_Obj__c ];
        List<Repayment_Test_Obj__c> OUToBJ=new List<Repayment_Test_Obj__c>();
        for(Repayment_Test_Obj__c re: repObj){
            repMap.put(re.AccountNumber__c,re);
        }
        for(STring q: repMap.keySet()){
            outObj.add(repMap.get(q));
        }        
        for(Repayment_Test_Obj__c c : outObj) {
            this.repList.add(new cRepayment(c,false,c.description__c));
        }
    }
   
    public List<cRepayment> getContacts() {
        if(repList == null) {
            repList = new List<cRepayment>();
            List<Repayment_Test_Obj__c> repObj=[select id,description__c,BankName__c,AccountNumber__c,AccountName__c from Repayment_Test_Obj__c ];
            List<Repayment_Test_Obj__c> OUToBJ=new List<Repayment_Test_Obj__c>();
            for(Repayment_Test_Obj__c re: repObj){
                repMap.put(re.AccountNumber__c,re);
            }
            for(STring q: repMap.keySet()){
                outObj.add(repMap.get(q));
            }
            for(Repayment_Test_Obj__c c : outObj) {
                repList.add(new cRepayment(c,false,c.description__c));
            }
        }
        return repList;
    }
        public PageReference processSelected() {
        //description=Apexpages.currentPage().getParameters().get('description');
        system.debug(description);
        List<Repayment_Unique__c> uniqPayList=[select id,name from Repayment_Unique__c];
        if(uniqPayList!=null)
            delete uniqPayList;
        List<Repayment_All_Payment__c> allPayList=[select id,name from Repayment_All_Payment__c];
        if(allPayList!=null)
            delete allPayList;
        rejectList =[select id,name from Repayment_Rejection__c];
        for(Repayment_Rejection__c rejL:rejectList){
            rejectMap.put(rejL.name,rejL.name);
        }
        List<String> accNumberList=new List<String>();
        rejTestObj = new List<Repayment_Test_Obj__c>();
        for(cRepayment cCon : repList) {
            if(cCon.ISselected == true) {
                system.debug(ccon.con.AccountNumber__c);
                accNumberList.add(ccon.con.AccountNumber__c);
                //rejTestObj=[select id,AccountName__c,AccountNumber__c,Amount__c,Balance__c,BankName__c,Classification__c,Date__c,Description__c,LoanId__c,ownerid__c,Payee__c,Reference__c,Type__c from Repayment_Test_Obj__c  where AccountNumber__c=:(ccon.con.AccountNumber__c)];
            }
            
        }
        List<Repayment_Unique__c> repUniq= new List<Repayment_Unique__c>();
        system.debug(accNumberList);
       
            RepaymentHandler re=new RepaymentHandler();        
            //repUniq.addall(re.assignwrtAccountNumb(accNumberList,description));
            repUniq.addall(re.assignwrtAccountNumbWithoutFilter(accNumberList));
        
        
        PageReference pageRef = new PageReference('/apex/Repayment_Module');
        return pageRef;
    }
    public PageReference processSelectedWithFilter() {
        //description=Apexpages.currentPage().getParameters().get('description');
        system.debug(description);
        List<Repayment_Unique__c> uniqPayList=[select id,name from Repayment_Unique__c];
        if(uniqPayList!=null)
            delete uniqPayList;
        List<Repayment_All_Payment__c> allPayList=[select id,name from Repayment_All_Payment__c];
        if(allPayList!=null)
            delete allPayList;
        rejectList =[select id,name from Repayment_Rejection__c];
        for(Repayment_Rejection__c rejL:rejectList){
            rejectMap.put(rejL.name,rejL.name);
        }
        List<String> accNumberList=new List<String>();
        rejTestObj = new List<Repayment_Test_Obj__c>();
        for(cRepayment cCon : repList) {
            if(cCon.ISselected == true) {
                system.debug(ccon.con.AccountNumber__c);
                accNumberList.add(ccon.con.AccountNumber__c);
                //rejTestObj=[select id,AccountName__c,AccountNumber__c,Amount__c,Balance__c,BankName__c,Classification__c,Date__c,Description__c,LoanId__c,ownerid__c,Payee__c,Reference__c,Type__c from Repayment_Test_Obj__c  where AccountNumber__c=:(ccon.con.AccountNumber__c)];
            }
            
        }
        List<Repayment_Unique__c> repUniq= new List<Repayment_Unique__c>();
        system.debug(accNumberList);
       
            RepaymentHandler re=new RepaymentHandler();        
            //repUniq.addall(re.assignwrtAccountNumb(accNumberList,description));
            repUniq.addall(re.assignwrtAccountNumb(accNumberList,description));
        
        
        PageReference pageRef = new PageReference('/apex/Repayment_Module');
        return pageRef;
    }
     public PageReference crediTransactionWithFilter() {
        List<Repayment_Unique__c> uniqPayList=[select id,name from Repayment_Unique__c];
        if(uniqPayList!=null)
            delete uniqPayList;
        List<Repayment_All_Payment__c> allPayList=[select id,name from Repayment_All_Payment__c];
        if(allPayList!=null)
            delete allPayList;
        rejectList =[select id,name from Repayment_Rejection__c];
        
        
        for(Repayment_Rejection__c rejL:rejectList){
            rejectMap.put(rejL.name,rejL.name);
        }
        List<String> accNumberList=new List<String>();
        rejTestObj = new List<Repayment_Test_Obj__c>();
        for(cRepayment cCon : repList) {
            if(cCon.ISselected == true) {
                system.debug(ccon.con.AccountNumber__c);
                accNumberList.add(ccon.con.AccountNumber__c);
                //rejTestObj=[select id,AccountName__c,AccountNumber__c,Amount__c,Balance__c,BankName__c,Classification__c,Date__c,Description__c,LoanId__c,ownerid__c,Payee__c,Reference__c,Type__c from Repayment_Test_Obj__c  where AccountNumber__c=:(ccon.con.AccountNumber__c)];
            }
          
        }
        List<Repayment_Credit_Payment__c> repUniq= new List<Repayment_Credit_Payment__c>();
        system.debug(accNumberList);
        
        
            RepaymentHandler re=new RepaymentHandler();        
            repUniq.addall(re.assignCreditwrtKeywordsWithFilter(accNumberList,description));
        
        
        PageReference pageRef = new PageReference('/apex/CreditTran');
        return pageRef;
    }
     public PageReference scorecard(){
        ScoreCardAPI sc=new ScoreCardAPI();
		Id score=sc.computeScore();
         PageReference pageRef = new PageReference('/'+score);
        return pageRef;
    }
    public PageReference crediTransaction() {
        List<Repayment_Unique__c> uniqPayList=[select id,name from Repayment_Unique__c];
        if(uniqPayList!=null)
            delete uniqPayList;
        List<Repayment_All_Payment__c> allPayList=[select id,name from Repayment_All_Payment__c];
        if(allPayList!=null)
            delete allPayList;
        rejectList =[select id,name from Repayment_Rejection__c];
        
        
        for(Repayment_Rejection__c rejL:rejectList){
            rejectMap.put(rejL.name,rejL.name);
        }
        List<String> accNumberList=new List<String>();
        rejTestObj = new List<Repayment_Test_Obj__c>();
        for(cRepayment cCon : repList) {
            if(cCon.ISselected == true) {
                system.debug(ccon.con.AccountNumber__c);
                accNumberList.add(ccon.con.AccountNumber__c);
                //rejTestObj=[select id,AccountName__c,AccountNumber__c,Amount__c,Balance__c,BankName__c,Classification__c,Date__c,Description__c,LoanId__c,ownerid__c,Payee__c,Reference__c,Type__c from Repayment_Test_Obj__c  where AccountNumber__c=:(ccon.con.AccountNumber__c)];
            }
           if(ccon.con.Description__c!=null){
                description=ccon.con.Description__c;
            }
        }
        List<Repayment_Credit_Payment__c> repUniq= new List<Repayment_Credit_Payment__c>();
        system.debug(accNumberList);
        
        
            RepaymentHandler re=new RepaymentHandler();        
            repUniq.addall(re.assignCreditwrtKeywords(null,accNumberList));
        
        
        PageReference pageRef = new PageReference('/apex/CreditTran');
        return pageRef;
    }
    public PageReference summary(){ 
        List<String> accNumberList=new List<String>();        
        rejTestObj = new List<Repayment_Test_Obj__c>();
        for(cRepayment cCon : repList) {
            if(cCon.ISselected == true) {
                system.debug(ccon.con.AccountNumber__c);
                accNumberList.add(ccon.con.AccountNumber__c);
                //rejTestObj=[select id,AccountName__c,AccountNumber__c,Amount__c,Balance__c,BankName__c,Classification__c,Date__c,Description__c,LoanId__c,ownerid__c,Payee__c,Reference__c,Type__c from Repayment_Test_Obj__c  where AccountNumber__c=:(ccon.con.AccountNumber__c)];
            }
           if(ccon.con.Description__c!=null){
               // description=ccon.con.Description__c;
            }
        }
        description=Apexpages.currentPage().getParameters().get('description');
        List<Repayment_Unique__c> repUniq= new List<Repayment_Unique__c>();
        system.debug(accNumberList);
       // for(string q: accNumberList){
            RepaymentHandler re=new RepaymentHandler();        
        //    repUniq.addall(re.assignwrtAccountNumb(accNumberList,description));
        repUniq.addall(re.assignwrtAccountNumb(accNumberList,description));
            re.tranSummary();
            
      //  }
        
        PageReference pageRef = new PageReference('/a07?fcf=00B7F000008Z7ID');
        return pageRef;
    }
    public List<Repayment_Test_Obj__c> getselectedRep(){
        System.debug('printingtcontc inside get'+rejTestObj.size());
        if(rejTestObj.size()>0)
            return rejTestObj;
        else return null;
    }
    public class cRepayment {
        public Repayment_Test_Obj__c con {get; set;}
        public Boolean isSelected {get; set;}
        public String des{get;set;}
        public cRepayment(Repayment_Test_Obj__c c,Boolean isSelected,String des) {
            this.con = c;
            this.des=des;
            this.isSelected = isSelected;
        }
    }
}