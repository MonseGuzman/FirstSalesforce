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
    public Student__c student2 {get; set;}
    public Student__c student3 {get; set;}
    public List<Student__c> searchList {get; set;}
    
    public boolean showSave {get; set;}
    public boolean showSaveT {get; set;}
    public boolean showSaveS {get; set;}
    
    public boolean showSave2 {get; set;}
    public boolean showSaveT2 {get; set;}
    public boolean showSaveS2 {get; set;}
        
    //TEACHER VARIABLES
    public Teacher__c teacher {get; set;}
    public Teacher__c teacher2 {get; set;}
    public Teacher__c teacherEdit {get; set;}
    public List<Teacher__c> searchTeacherList {get; set;}
    public String idTeacherUpdate {get; set;}
    public String idTeacherDelete {get; set;}
    public boolean displayPopupT {get; set;}
    
    private String baseQueryTeacher = 'SELECT Id, Full_Name_Teacher__c, Email_Work__c, School_Work__r.Name, Number_Students__c FROM Teacher__c';
    
    //SCHOOL VARIABLES
    public School__c school {get; set;}
    public School__c school2 {get; set;}
    public List<School__c> searchSchoolList {get; set;}
    public String schoolIdUpdate {get; set;}
    public String schoolIdDelete {get; set;}
    public boolean displayPopupS {get; set;}
    
    private String baseQuerySchool = 'SELECT Id, Code_School__c, Name, Phone_School__c, Number_Teachers__c, Number_Students__c, Restantes__c FROM School__c';
    
    public AllDataController(){
        student = new Student__c();
        teacher = new Teacher__c();
        school = new School__c();
        
        student2 = new Student__c();
        student3 = new Student__c();
        teacher2 = new Teacher__c();
        school2 = new School__c();
        
        showSave2 = true;
        showSaveT2 = true;
        showSaveS2 = true;

        showSave = false;
        showSaveT = false; 
        showSaveS = false;
    }
    
    //STUDENT
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
        Student__c updateS = Database.query('SELECT Id, Name, Active_Student__c, Last_Name__c, Birth_Born__c, Email__c FROM Student__c WHERE Id =: idUpdateStudent' );

        student3.Id = updateS.Id;
        student3.Name = updateS.Name;
        student3.Last_Name__c = updateS.Last_Name__c;
        student3.Birth_Born__c = updateS.Birth_Born__c;
        student3.Active_Student__c = updateS.Active_Student__c;
        student3.Email__c = updateS.Email__c;

        displayPopup = true;
    }
    
    public void updateStudentButton(){
        Student__c myedit = new Student__c();
                
        myedit.Id = student3.Id;
        myedit.Name = student3.Name;
        myedit.Last_Name__c = student3.Last_Name__c;
        myedit.Birth_Born__c = student3.Birth_Born__c;
        myedit.Active_Student__c = student3.Active_Student__c;
        myedit.Email__c = student3.Email__c;
        
        upsert myedit;
        
        displayPopup = false;
    }
    
    public void dataForNameSt(){
        showSave = true;
        showSave2 = false;
        String search = (student2.Name).toLowerCase();
        System.debug('search ' + search);
        
        if(!String.isEmpty(search)){
            List<Student__c> lista = Database.query('SELECT Id, IdStudent__c, Full_Name_Student__c, Birth_Born__c, Email__c, School__r.Name, Teacher__r.Full_Name_Teacher__c FROM Student__c WHERE Name LIKE :search');
            if(lista.size() <= 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is not information'));
            }
            else{
                searchList = lista;
            }
        }
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

        return Database.query(query);
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

    public void updateTeacher(){
        Teacher__c updateT = Database.query('SELECT Id, Name, Last_Name__c, School_Work__c, Email_Work__c FROM Teacher__c WHERE Id =: idTeacherUpdate' );

        teacherEdit.Id = updateT.Id;
        teacherEdit.Name = updateT.Name;
        teacherEdit.Last_Name__c = updateT.Last_Name__c;
        teacherEdit.School_Work__c = updateT.School_Work__c;
        teacherEdit.Email_Work__c = updateT.Email_Work__c;

        displayPopup = true;
    }
    
    public void updateTeacherButton(){
        Teacher__c myedit = new Teacher__c();
                
        myedit.Id = teacherEdit.Id;
        myedit.Name = teacherEdit.Name;
        myedit.Last_Name__c = teacherEdit.Last_Name__c;
        myedit.School_Work__c = teacherEdit.School_Work__c;
        myedit.Email_Work__c = teacherEdit.Email_Work__c;
        
        upsert myedit;
        
        displayPopup = false;
    }

    public void dataForNameTea(){
        showSaveT = false;
        showSaveT2 = true;
        String search = teacher2.Name; 
        
        if(!String.isEmpty(search)){
            List<Teacher__c> lista = Database.query('SELECT Id, Full_Name_Teacher__c, Email_Work__c, School_Work__r.Name, Number_Students__c FROM Teacher__c WHERE Name LIKE :search');
            if(lista.size() <= 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is not information'));
            }
            else{
                searchTeacherList = lista;
            }
        }
        else{
            showSave = false;
            showSave2 = true;
        }
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

    public void dataForNameSc(){
        showSaveS = true;
        showSaveS2 = false;

        String search = school2.Name; 
        
        if(!String.isEmpty(search)){
            List<School__c> lista = Database.query('SELECT Id, Code_School__c, Name, Phone_School__c, Number_Teachers__c, Number_Students__c, Restantes__c FROM School__c WHERE Name LIKE :search');
            if(lista.size() <= 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There is not information'));
            }
            else{
                searchSchoolList = lista;
            }
        }
        else{
            showSaveS = false;
            showSaveS2 = true;
        }
    }
   
    //MODAL
    public void closePopupS() {        
        displayPopupS = false;    
    }  
    
    public void showPopupS() {        
        displayPopupS = true;
    }
    
}