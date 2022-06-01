public class GL_ExportDemoController {
    public List<Contact> contactList {get; set;}
    public GL_ExportDemoController(){
       contactList = new List<Contact>();
       for (Contact c : [Select id, Name from Contact limit 20]) {       
           contactList.add(c);
       }
    }
}