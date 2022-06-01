trigger ContactCreate on Contact (before insert , before Update) {
for(Contact c : trigger.new)
{
c.Description = 'New Contact has been created successfully'+userinfo.getusername();
}

}