@RestResource(urlMapping='/DanBotRestService/*')
global with sharing class DanBotRestService {
    
    @HttpPost
    global static SlackResponse route (String command) {
        return requestRouter(command);
    }
    
    global static SlackResponse requestRouter(String command){
        String [] arr = command.split(' ', 2);
        String mainCommand = arr[0];
        Map<String, ISlackCommandHandler> commands = listCommands();
        if(commands.containsKey(mainCommand)){
            ISlackCommandHandler sch = commands.get(mainCommand);
            String text = arr.size() >= 2 ? arr[1] : '';
            return sch.processCommand(text);
        }else {
           return requestNotFoundResponse(); 
        }
    }
    
    global static SlackResponse requestNotFoundResponse(){
        SlackResponse response = new SlackResponse('I was not able to understand your command!');
        return response;
    }
    
    global static Map<String, ISlackCommandHandler> listCommands(){
        
        Map<String, ISlackCommandHandler> commands = new Map<String, ISlackCommandHandler>();
        
        //command command
        commands.put(SCHCommands.triggerText(), new SCHCommands());
        //talk command
        commands.put(SCHTalk.triggerText(), new SCHTalk());
        //teach command
        commands.put(SCHTeach.triggerText(), new SCHTeach());
        commands.put(SCHNews.triggerText(), new SCHNews());
        
        return commands;
        //news command
        
        
    }
 }