global class SlackResponse {
		public String text;
        public SlackResponseAttachment[] attachments;

        public SlackResponse(String text) {
            this.text = text;
            this.attachments = new SlackResponseAttachment[]{};

        }
        
        public void addAtachment(SlackResponseAttachment attachment){
            this.attachments.add(attachment);
        }
}