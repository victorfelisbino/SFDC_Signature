global with sharing class SignatureComponentController {
    public SignatureComponentController() {

    }
    public id objParentId{
        get{
            return System.currentPageReference().getParameters().get('id');
        }
        set;
    }
 
    @RemoteAction
    global static boolean saveSignature(String signatureBody, id parentId){
        try{
            system.debug('Record== ' + parentId);
            system.debug(signatureBody);
            Attachment a = new Attachment();
            a.ParentId = parentId;
            a.Body = EncodingUtil.base64Decode(signatureBody);
            a.ContentType = 'image/png';
            a.Name = 'Signature.png';
            insert a;
            
            Schema.SObjectType sobjectType = parentId.getSObjectType();
            String sobjectName = sobjectType.getDescribe().getName();
            sObject s = Schema.getGlobalDescribe().get(sobjectName).newSObject() ;
            s.put('Id',parentId);
            // at this point you can edit any fields you have on the parentId.
            // I have SignaureId__(text[18]) on objects where I want to capture the id of the signature
            // attachment on the record.
            String imgUrl = '<a href="/servlet/servlet.FileDownload?file='+a.id+'" target="_blank">'+
                            '<img alt="User-added image" src="/servlet/servlet.FileDownload?file='+a.id+'"></img>'+
                            '</a>';
            s.put('Signature__c', imgUrl);
            update s;

            return true;
            //return '{success:true, attachId:' + a.Id + ', sObject: ' + c + '}';
        }catch(Exception e){
            system.debug(e);
            return false;
        }
    }
}