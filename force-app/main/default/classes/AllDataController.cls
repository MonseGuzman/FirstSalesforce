public class AllDataController {
    
    public Integer pageSize = 5;
    public Integer pageNumber = 0;
    public Integer pageNumberForTea = 0;
    public Integer pageNumberForScho = 0;
    
    //STUDENT VARIABLE
    private String baseQuery = 'SELECT Id, IdStudent__c, Full_Name_Student__c, Birth_Born__c, Email__c, School__r.Name, Teacher__r.Full_Name_Teacher__c FROM Student__c';
    
    public String idDeleteStudent {get; set;}
    public String idUpdateStudent {get; set;}
    public boolean displayPopup {get; set;}
    public Student__c student {get; set;}
    
    public boolean activeStudent {get; set;}
    public String name {get; set;}
    public String lastName {get; set;}
    public Date birthBorn {get; set;}
    public String email {get; set;}
    
    //TEACHER VARIABLES
    public Teacher__c teacher {get; set;}
    public String idTeacherUpdate {get; set;}
    public String idTeacherDelete {get; set;}
    public boolean displayPopupT {get; set;}
    
    private String baseQueryTeacher = 'SELECT Id, Full_Name_Teacher__c, Email_Work__c, School_Work__r.Name, Number_Students__c FROM Teacher__c';
    
    //SCHOOL VARIABLES
    public School__c school {get; set;}
    public String schoolIdUpdate {get; set;}
    public String schoolIdDelete {get; set;}
    public boolean displayPopupS {get; set;}
    
    private String baseQuerySchool = 'SELECT Id, Code_School__c, Name, Phone_School__c, Number_Teachers__c, Number_Students__c, Restantes__c FROM School__c';
    
    public AllDataController(){
        student = new Student__c();
        teacher = new Teacher__c();
        school = new School__c();
    }
    
    //PAGINATION
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
        String id = student.School__c;       
        School__c st = Database.query('SELECT Restantes__c FROM School__c WHERE Id =: id');

        if(st.Restantes__c > 0){
            insert student;
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Can’t add more than 10 Students'));
        }
        return null;
    }
    
    public List<Student__c> getQueryStudents(){
        Integer offset = pageNumber * pageSize;
        String query = baseQuery + ' LIMIT '+pageSize +' OFFSET '+ offset;
        List<Student__c> result;
        
        result = Database.query(query);
        
        return result;
    }
    
    public void deleteStudent(){
        Student__c deleteS = Database.query('SELECT Id, School__c FROM Student__c WHERE Id =: idDeleteStudent');
        
        String id = deleteS.School__c;
        School__c validation = Database.query('SELECT Id, Number_Students__c, Number_Teachers__c FROM School__c WHERE Id =: id');
        
        if(validation.Number_Students__c == 0 && validation.Number_Teachers__c == 0){
            delete deleteS;
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Can’t delete a Student because its associated/related to another object'));
        }
    }
    
    public List<Student__c> getDataRecord(){
        return Database.query('SELECT Id, Name, Active_Student__c, Last_Name__c, Birth_Born__c, Email__c FROM Student__c WHERE Id =: idUpdateStudent' );
    }
    
    public void updateStudent(){
        Student__c updateS = new Student__c(Id = idUpdateStudent);

        updateS.Name = name;
        updateS.Active_Student__c = activeStudent;
        updateS.Last_Name__c = lastName;
        updateS.Birth_Born__c = birthBorn;
        updateS.Email__c = email;

        //update updateS;
    }
    
    public List<Student__c> searchNameStudent(){
        String query = baseQuery + ' WHERE Name LIKE '+ name +' LIMIT '+ pageSize;
        return Database.query(query);
    }
   
    //MODAL
    public void closePopup() {        
        displayPopup = false;    
    }  
    
    public void showPopup() {        
        displayPopup = true;
    }
    
    //TEACHER
    //PAGINATION
    public PageReference nextTeacher(){
        pageNumberForTea++;
        getQueryStudents();
        return null;
    }
    
    public PageReference previousTeacher(){
        pageNumberForTea--;
        if (pageNumberForTea < 0)
            return null;
        
        getQueryStudents();
        return null;
    }
    //ADD
    public PageReference addNewTeacher(){
        String id = teacher.School_Work__c;        
        School__c st = Database.query('SELECT Number_Teachers__c FROM School__c WHERE Id =: id');

        if(st.Number_Teachers__c < 5){
            insert teacher;
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Can’t add more than 5 teachers'));
        }
        return null;
    }
    
    public List<Teacher__c> getQueryTeacher(){
        Integer offset = pageNumberForTea * pageSize;
        String query = baseQueryTeacher + ' LIMIT '+pageSize +' OFFSET '+ offset;
        List<Teacher__c> result;
        
        result = Database.query(query);
        
        return result;
    }
    
    public void deleteRecordTeacher(){
        Teacher__c deleteARecord = Database.query('SELECT Id, School_Work__c FROM Teacher__c WHERE Id =: idTeacherDelete');
        
        String id = deleteARecord.School_Work__c;
        School__c validation = Database.query('SELECT Id, Number_Students__c, Number_Teachers__c FROM School__c WHERE Id =: id');
        
        if(validation.Number_Students__c == 0 && validation.Number_Teachers__c == 0){
            delete deleteARecord;
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Can’t delete a teacher because its associated/related to another object'));
        }
    }
    
    public List<Teacher__c> getDataRecordTeacher(){
        return Database.query('SELECT Id, Name, Last_Name__c, School_Work__c, Email_Work__c FROM Teacher__c WHERE Id =: idTeacherUpdate' );
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
    }
    
    //SCHOOL
    //PAGINATION
    public PageReference nextSchool(){
        pageNumberForScho++;
        getQuerySchool();
        return null;
    }
    
    public PageReference previousSchool(){
        pageNumberForScho--;
        if (pageNumberForScho < 0)
            return null;
        
        getQuerySchool();
        return null;
    }
    
    //ADD
    public PageReference addNewSchool(){
        insert school;
        return null;
    }
    
    public List<School__c> getQuerySchool(){
        Integer offset = pageNumberForScho * pageSize;
        String query = baseQuerySchool + ' LIMIT '+pageSize +' OFFSET '+ offset;
        List<School__c> result;
        
        result = Database.query(query);
        
        return result;
    }
    
    public void deleteRecordSchool(){
        School__c validation = Database.query('SELECT Id, Number_Students__c, Number_Teachers__c FROM School__c WHERE Id =: schoolIdDelete');
        
        if(validation.Number_Students__c == 0 && validation.Number_Teachers__c == 0){
            delete validation;
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Can’t delete a classroom because its associated/related to another object'));
        }
    }
    
    public List<School__c> getDataRecordSchool(){
        return Database.query('SELECT Id, Name, Phone_School__c FROM School__c WHERE Id =: schoolIdUpdate' );
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
    }
    
}