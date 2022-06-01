trigger CreateMyProjectFromProj on PROJECTS__c (after insert) {
List<PROJECTS__c> Projects = new List<PROJECTS__c>();
for(PROJECTS__c p : trigger.new){
if(!string.isBlank(p.id)){
Projects.add(p);
system.debug('---------Projects Name -------' +Projects);
}
}
if(Projects.Size()>0){
List<MY_PROJECT__c> MyProjects = new List<MY_PROJECT__c>();
// Map<id,PROJECTS__c> ProjectByNameKeys = new Map<id,PROJECTS__c>();
for(PROJECTS__c p : Projects){

// ProjectByNameKeys.put(MyProjectName , p);
//system.debug('--------Project Detail from Map -------' +ProjectByNameKeys);
MY_PROJECT__c Pro = new MY_PROJECT__c(Name = p.Name,
                     PROJECT__c = p.ID);
MyProjects.add(pro);
system.debug('--------My Projects -------' +MyProjects);
}
insert MyProjects;
}

}