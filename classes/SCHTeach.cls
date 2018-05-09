public class SCHTeach implements ISlackCommandHandler{
	public static String triggerText(){
        return 'teach';
    }
    
    public static SlackResponse processCommand(String command){
        //command should be word, word, word * Response, Response Response
        String [] inputarr = command.split('-', 2);
        if(inputarr.size() == 2){
            try{
            	Knowledge__c nk = new Knowledge__c();
            	nk.Query__c = inputarr[0];
            	nk.Response__c = inputarr[1];
                insert nk;
                return new SlackResponse('Great I can now answer to: ' + inputarr[0]);
            } catch(DMLException dmle){
                return new SlackResponse('There was a error learning.');
            }
        } else {
			return new SlackResponse('There was an error, please make sure you are following the expected format, use commands for more information.'); 
        }
        
    }
}