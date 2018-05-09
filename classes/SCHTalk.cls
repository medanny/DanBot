public class SCHTalk implements ISlackCommandHandler{
	public static String triggerText(){
        return 'talk';
    }
    
    public static SlackResponse processCommand(String command){
        SlackResponse response = new SlackResponse(getAnswer(command));
        return response;
    }
    
    public static String getAnswer(String text){
 		//break down the text to an array
 		String [] arr = text.split(' ');
        
        //construct query
        String query = 'SELECT Query__C, Response__C FROM Knowledge__c WHERE';
        
        Integer cindex = 0;
        for (String word : arr){
            if(cindex!=0){
                query+= ' OR';
            }
            query = query + ' Query__C like \'%' + word +'%\'';
            cindex++;
        }
        System.debug('MY QUERY: ' + query);
        List<Knowledge__c> responses = Database.query(query);
        
        if(responses.size() >= 1){
            String posibleResponses = responses.get(0).Response__C;
            String [] responseArr = posibleResponses.split(', ');
            System.debug('ARRAY: '+ responseArr);
            Integer index = (Math.random() * (responseArr.size() - 1)).intValue();
            System.debug('INDEX: '+ index);
            return responseArr[index];
        }
        return 'Sorry?!';
    }
}