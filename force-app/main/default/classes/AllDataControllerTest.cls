@isTest
public class AllDataControllerTest {
    
    //STUDENT TEST
    @isTest static void addNewStudentTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);
                
        School__c school = new School__c();
        school.Name = 'test school';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacherAdd = new Teacher__c();
        teacherAdd.Name = 'un teacher';
        teacherAdd.Last_Name__c = 'test';
        teacherAdd.Email_Work__c = 'test@teacher.com';
        teacherAdd.School_Work__c = idSchool;
        insert teacherAdd;
        Teacher__c teacherList = [SELECT Id FROM Teacher__c LIMIT 1];
       	String teacherid = teacherList.Id;
        
        Student__c studenttoinsert = new Student__c();
        studenttoinsert.Name = 'no lo sé';
        studenttoinsert.Last_Name__c = 'si un test';
        studenttoinsert.Active_Student__c = false;
        studenttoinsert.Birth_Born__c = Date.valueOf('2015-12-31');
        studenttoinsert.Email__c = 'test@test.com';
        studenttoinsert.School__c = idSchool;
        studenttoinsert.Teacher__c = teacherid;
        
        AllDataController controller = new AllDataController();
        controller.student = studenttoinsert;

        controller.addNewStudent();          
    }
    
    @isTest static void deleteStudentTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'test school';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacher = new Teacher__c();
        teacher.Name = 'un teacher';
        teacher.Last_Name__c = 'test';
        teacher.Email_Work__c = 'test@teacher.com';
        teacher.School_Work__c = idSchool;
        insert teacher;
        Teacher__c teacherList = [SELECT Id FROM Teacher__c LIMIT 1];
       	String teacherid = teacherList.Id;
        
        Student__c studenttodelete = new Student__c();
        studenttodelete.Name = 'test';
        studenttodelete.Last_Name__c = 'si un test';
        studenttodelete.Active_Student__c = false;
        studenttodelete.Birth_Born__c = Date.valueOf('2015-12-31');
        studenttodelete.Email__c = 'test@test.com';
        studenttodelete.School__c = idSchool;
        studenttodelete.Teacher__c = teacherid;
        insert studenttodelete;

        Student__c lista = [SELECT Id FROM Student__c];
        
        AllDataController controller = new AllDataController();
        controller.idDeleteStudent = lista.Id;

        controller.deleteStudent();
    }

    @isTest static void updateStudentTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'clase de tessst';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacher = new Teacher__c();
        teacher.Name = 'un teacher';
        teacher.Last_Name__c = 'test';
        teacher.Email_Work__c = 'test@teacher.com';
        teacher.School_Work__c = idSchool;
        insert teacher;
        Teacher__c teacherList = [SELECT Id FROM Teacher__c LIMIT 1];
       	String teacherid = teacherList.Id;
        
        Student__c updatestudent = new Student__c();
        updatestudent.Name = 'test';
        updatestudent.Last_Name__c = 'si un test';
        updatestudent.Active_Student__c = true;
        updatestudent.Birth_Born__c = Date.valueOf('2015-12-31');
        updatestudent.Email__c = 'test@test.com';
        updatestudent.School__c = idSchool;
        updatestudent.Teacher__c = teacherid;
        insert updatestudent;

        Student__c lista = [SELECT Id FROM Student__c];
        
        AllDataController controller = new AllDataController();
        controller.idUpdateStudent = lista.Id;

        controller.updateStudent();
        controller.updateStudentButton();
    }
    
    @isTest static void dataForNameStTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'clase de searchhhhhh';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacher = new Teacher__c();
        teacher.Name = 'un teacher';
        teacher.Last_Name__c = 'test';
        teacher.Email_Work__c = 'test@teacher.com';
        teacher.School_Work__c = idSchool;
        insert teacher;
        Teacher__c teacherList = [SELECT Id FROM Teacher__c LIMIT 1];
       	String teacherid = teacherList.Id;
        
        Student__c searchstudent = new Student__c();
        searchstudent.Name = 'testito';
        searchstudent.Last_Name__c = 'si un test';
        searchstudent.Active_Student__c = true;
        searchstudent.Birth_Born__c = Date.valueOf('2015-12-31');
        searchstudent.Email__c = 'test@test.com';
        searchstudent.School__c = idSchool;
        searchstudent.Teacher__c = teacherid;
        insert searchstudent;

        Student__c lista = [SELECT Name FROM Student__c];
        
        AllDataController controller = new AllDataController();
        controller.student2 = lista;

        controller.dataForNameSt();
    }
    
    //TEACHER TEST
    @isTest static void addNewTeacherTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);
                
        School__c school = new School__c();
        school.Name = 'test school';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacherAdd = new Teacher__c();
        teacherAdd.Name = 'un teacher';
        teacherAdd.Last_Name__c = 'test';
        teacherAdd.Email_Work__c = 'test@teacher.com';
        teacherAdd.School_Work__c = idSchool;
        
        AllDataController controller = new AllDataController();
        controller.teacher = teacherAdd;

        controller.addNewTeacher();          
    }
    
    @isTest static void deleteRecordTeacherTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'test school';
        school.Phone_School__c = '123456789';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacherDelete = new Teacher__c();
        teacherDelete.Name = 'un teacher';
        teacherDelete.Last_Name__c = 'test';
        teacherDelete.Email_Work__c = 'test@teacher.com';
        teacherDelete.School_Work__c = idSchool;
        insert teacherDelete;
        Teacher__c teacherList = [SELECT Id FROM Teacher__c LIMIT 1];
        
        AllDataController controller = new AllDataController();
        controller.idTeacherDelete = teacherList.Id;

        controller.deleteRecordTeacher();
    }

    @isTest static void updateTeacherTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'clase de tessst';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacher = new Teacher__c();
        teacher.Name = 'un teacher';
        teacher.Last_Name__c = 'test';
        teacher.Email_Work__c = 'test@teacher.com';
        teacher.School_Work__c = idSchool;
        insert teacher;
        Teacher__c teacherList = [SELECT Id FROM Teacher__c LIMIT 1];
       	        
        AllDataController controller = new AllDataController();
        controller.idTeacherUpdate = teacherList.Id;

        controller.updateTeacher();
        controller.updateTeacherButton();
    }
    
    @isTest static void dataForNameTeaTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'clase de searchhhhhh';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	String idSchool = schoolList.Id;
        
        Teacher__c teacher = new Teacher__c();
        teacher.Name = 'un teacher';
        teacher.Last_Name__c = 'test';
        teacher.Email_Work__c = 'test@teacher.com';
        teacher.School_Work__c = idSchool;
        insert teacher;
        Teacher__c teacherList = [SELECT Name FROM Teacher__c LIMIT 1];        
        
        AllDataController controller = new AllDataController();
        controller.teacher2 = teacherList;

        controller.dataForNameTea();
    }
    
    //SCHOOL TEST
    @isTest static void addNewSchoolTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);
                
        School__c school = new School__c();
        school.Name = 'test school';
        school.Phone_School__c = '3411008478';
        
        AllDataController controller = new AllDataController();
        controller.school = school;

        controller.addNewSchool();          
    }
    
    @isTest static void deleteRecordSchoolTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'test school';
        school.Phone_School__c = '123456789';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
        
        AllDataController controller = new AllDataController();
        controller.schoolIdDelete = schoolList.Id;

        controller.deleteRecordSchool();
    }

    @isTest static void updateSchoolTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'clase de tessst';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Id FROM School__c LIMIT 1];
       	        
        AllDataController controller = new AllDataController();
        controller.schoolIdUpdate = schoolList.Id;

        controller.updateSchool();
        controller.updateSchoolButton();
    }
    
    @isTest static void dataForNameScTest(){
        PageReference myVfPage = Page.AllData;
        Test.setCurrentPage(myVfPage);

        School__c school = new School__c();
        school.Name = 'clase de searchhhhhh';
        school.Phone_School__c = '3411008478';
        insert school;
        School__c schoolList = [SELECT Name FROM School__c LIMIT 1];            
        
        AllDataController controller = new AllDataController();
        controller.school2 = schoolList;

        controller.dataForNameSc();
    }
}