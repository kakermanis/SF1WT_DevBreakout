public with sharing class CaseUpload{
    public blob photo { get; set; }
    public Case theCase {get; set;}
    public String lastError {get; set;}
    public ContentVersion photoContent {get; set;}

    public CaseUpload() {
        theCase = new Case();
        photoContent = new ContentVersion();
        lastError = '';
    }
      
    public PageReference save() {
        createNewCase();


        theCase = new Case();        
        // Clear out view state
        photo = null;
        photoContent = null;
        lastError = 'ok';
         
        // Continue along
        return null;
    }
      
     private void createNewCase() {      
        try {
            insert theCase;

            // K.Akermanis - how's about making this a chatter file instead and posting it to the feed?
            // Cuz I loath the attachments related list, it's so 90's!!!!
/*
            File photoFile = new File();
            Attachment attachment=new Attachment();
            attachment.body = photo;
            attachment.name = 'Case ' + theCase.id + ' Photo';
            attachment.parentid= theCase.id;
            attachment.ContentType = 'application/jpg';
            insert attachment;
            string Attid= attachment.id;
            string attachmentid=Attid.substring(0,15);

            theCase.Photo__c = '/servlet/servlet.FileDownload?file='+attachmentid;            
            update theCase;
*/            

                // K.Akermanis - This post doesn't seem to be actually posting for whatever reason...
             // Would also be cool to have it post the pic itself to the chatter feed vs. just doing it as an attachment....

                FeedItem post = new FeedItem();
                
                post.parentId = theCase.Id;
                post.Body = 'Photo for case: ' + theCase.Subject;
                //post.ParentId = ApexPages.currentPage().getParameters().get('id');
                //post.type = 'LinkPost'; 
                //post.LinkUrl = '/' + theCase.id;
                //post.Title = theCase.Subject;
                post.contentData = photoContent.VersionData;
                //post.ContentFileName = photoContent.PathOnClient;
                post.ContentFileName = photoContent.PathOnClient;
                post.type = 'ContentPost';
                insert post;

            } catch(System.Exception ex){
               lastError = ex.getMessage();
            }
        }  
}