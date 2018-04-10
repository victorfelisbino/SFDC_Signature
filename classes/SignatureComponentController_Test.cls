@isTest
public class SignatureComponentController_Test {
    public static testMethod void submitSignature(){
		Case c = new case();
        c.Subject = 'test';
        insert c;
        test.startTest();
        	SignatureComponentController scc = new SignatureComponentController();
            Test.setCurrentPageReference(new PageReference('Page.Signature_Capture'));	
            System.currentPageReference().getParameters().put('id', c.id);

        	id accId = scc.objParentId;
        	Boolean results = SignatureComponentController.saveSignature('test', c.id);
        test.stopTest();
    }
}