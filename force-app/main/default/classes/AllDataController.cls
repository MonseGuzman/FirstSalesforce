public class AllDataController {
    
    public Integer pageSize = 5;
    public Integer pageNumber = 0;
    
    //STUDENT VARIABLE
    private String baseQuery = 'SELECT Id, IdStudent__c, Full_Name_Student__c, Birth_Born__c, Email__c, School__r.Name, Teacher__r.Full_Name_Teacher__c FROM Student__c';
    
    public String IdDelete {get; set;}
    public String IdUpdate {get; set;}
    public boolean displayPopup {get; set;}
    public Student__c student {get; set;}
    
    /*public Boolean activeStudent {get; set;}
    public String name {get; set;}
    public String lastName {get; set;}
    public Date birthBorn {get; set;}
    public String email {get; set;}*/
    
    //TEACHER VARIABLES
    public Teacher__c teacher {get; set;}
    public String IdUpdateT {get; set;}
    public String IdDeleteT {get; set;}
    public boolean displayPopupT {get; set;}
    
    private String baseQueryTeacher = 'SELECT Id, Full_Name_Teacher__c, Email_Work__c, School_Work__r.Name, Number_Students__c FROM Teacher__c';
    
    //SCHOOL VARIABLES
    public School__c school {get; set;}
    public String IdUpdateS {get; set;}
    public String IdDeleteS {get; set;}
    public boolean displayPopupS {get; set;}
    
    private String baseQuerySchool = 'SELECT Id, Code_School__c, Name, Phone_School__c, Number_Teachers__c FROM School__c';
    
    public AllDataController(){
        student = new Student__c();
        teacher = new Teacher__c();
        school = new School__c();
    }
    
    //GENERAL
    public PageReference next(){
        pageNumber++;
        getQueryStudents();
        return null;
    }
    
    public PageReference previous(){
        pageNumber--;
        if (pageNumber < 0)
            return null;
        
        getQueryStudents();
        return null;
    }
    
    //STUDENT
    //ADD
    public PageReference addNewStudent(){
        insert student;
        return null;
    }
    
    public List<Student__c> getQueryStudents(){
        Integer offset = pageNumber * pageSize;
        String query = baseQuery + ' LIMIT '+pageSize +' OFFSET '+ offset;
        List<Student__c> result;
        
        result = Database.query(query);
        
        return result;
    }
    
    public void deleteRecord(){
        Student__c deleteARecord = new Student__c (Id = IdDelete);
        delete deleteARecord;
        getQueryStudents();
    }
    
    public List<Student__c> getDataRecord(){
        String Id = 'a004P00000tkLseQAE';
        System.debug('nel ' + IdUpdate);
        return Database.query('SELECT Id, Name, Active_Student__c, Last_Name__c, Birth_Born__c, Email__c FROM Student__c WHERE Id =: IdUpdate' );
    }
    
    public void updateRecord(){ //save-NO
        Database.query('UPDATE Student__c SET Name: name');
    }
   
    //MODAL
    public void closePopup() {        
        displayPopup = false;    
    }  
    
    public void showPopup() {        
        displayPopup = true;
        System.debug('nel 2 ' + IdUpdate);
    }
    
    //TEACHER
    //ADD
    public PageReference addNewTeacher(){
        insert teacher;
        return null;
    }
    
    public List<Teacher__c> getQueryTeacher(){
        Integer offset = pageNumber * pageSize;
        String query = baseQueryTeacher + ' LIMIT '+pageSize +' OFFSET '+ offset;
        List<Teacher__c> result;
        
        result = Database.query(query);
        
        return result;
    }
    
    public void deleteRecordTeacher(){
        Teacher__c deleteARecord = new Teacher__c (Id = IdDeleteT);
        delete deleteARecord;
    }
    
    public List<Teacher__c> getDataRecordTeacher(){
        String Id = 'a004P00000tkLseQAE';
        System.debug('nel ' + IdUpdate);
        return Database.query('SELECT Id, Name, Last_Name__c, Email_Work__c FROM Teacher__c WHERE Id =: IdUpdate' );
    }
    
    public void updateRecordTeacher(){ //save-NO
        //Database.query('UPDATE Student__c SET Name: name');
    }
   
    //MODAL
    public void closePopupT() {        
        displayPopupT = false;    
    }  
    
    public void showPopupT() {        
        displayPopupT = true;
        System.debug('nel 2 ' + IdUpdate);
    }
    
    //SCHOOL
    //ADD
    public PageReference addNewSchool(){
        insert school;
        return null;
    }
    
    public List<School__c> getQuerySchool(){
        Integer offset = pageNumber * pageSize;
        String query = baseQuerySchool + ' LIMIT '+pageSize +' OFFSET '+ offset;
        List<School__c> result;
        
        result = Database.query(query);
        
        return result;
    }
    
    public void deleteRecordSchool(){
        School__c deleteARecord = new School__c (Id = IdDeleteS);
        delete deleteARecord;
    }
    
    public List<School__c> getDataRecordSchool(){
        String Id = 'a004P00000tkLseQAE';
        System.debug('nel ' + IdUpdate);
        return Database.query('SELECT Id, Name, Phone_School__c FROM School__c WHERE Id =: IdUpdate' );
    }
    
    public void updateRecordSchool(){ //save-NO
        //Database.query('UPDATE Student__c SET Name: name');
    }
   
    //MODAL
    public void closePopupS() {        
        displayPopupS = false;    
    }  
    
    public void showPopupS() {        
        displayPopupS = true;
        System.debug('nel 2 ' + IdUpdate);
    }
    
}