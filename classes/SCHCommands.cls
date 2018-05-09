global class SCHCommands implements ISlackCommandHandler {
    public static String triggerText(){
        return 'commands';
    }
    
    public static SlackResponse processCommand(String command){
        SlackResponse response = new SlackResponse('Please find a list of commands below');
        SlackResponseAttachment sa = new SlackResponseAttachment('Last updated 10/04/18');
        sa.title = 'Commands';
        sa.fields.add(new SlackResponseAttachmentField('DanBot Commands','will display a list of commands.'));
        sa.fields.add(new SlackResponseAttachmentField('Danbot Talk {keywords}','will reply with what he knows.'));
        sa.fields.add(new SlackResponseAttachmentField('Danbot teach {triggerword1, triggerword2, triggerwordN - reply1, reply2 replyN}','teach Danbot how to reply to specific keywords.'));
        sa.fields.add(new SlackResponseAttachmentField('Danbot news || Danbot news {mx, us, ar, co } || Danbot search {keywords}','Read latest news from a country or search for news.'));
        response.addAtachment(sa);
        return response;
    } 
}