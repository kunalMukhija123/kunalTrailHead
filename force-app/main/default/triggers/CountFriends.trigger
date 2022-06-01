trigger CountFriends on Contact(before insert) {
  for (Contact c : Trigger.new) {
    // We often use System.debug to see the values of variables
    System.debug('David has a new friend!');
    System.debug('Hi ' + c.FirstName + ' ' + c.LastName + '!');
  }
  List<Contact> total = [SELECT Id FROM Contact];
  System.debug('David has ' + total.size() + ' friends total.');
}