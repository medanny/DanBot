global interface ISlackCommandHandler {
	String triggerText();
    SlackResponse processCommand(String command);
}