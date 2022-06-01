trigger HelloWorld on Lead ( before update ) {
For(Lead l : Trigger.new) {
l.FirstName='Hello';
l.LastName='World';
}
}