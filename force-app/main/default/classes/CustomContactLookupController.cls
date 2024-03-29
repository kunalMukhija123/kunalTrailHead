public with sharing class CustomContactLookupController {

  public Contact contact {get;set;} // new account to create
  public List<Contact> results{get;set;} // search results
  public string searchString{get;set;} // search keyword

  public CustomContactLookupController() {
   // contact = new Contact();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    runSearch();  
  }

  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }

  // prepare the query and issue the search command
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);               
  } 

  // run the search and return the records found. 
  private List<Contact> performSearch(string searchString) {

    String soql = 'select id, name from Contact';
    if(searchString != '' && searchString != null)
      soql = soql +  ' where name LIKE \'%' + searchString +'%\'';
    soql = soql + ' limit 100';
    System.debug(soql);
    return database.query(soql); 

  }


  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }

  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }    

}