global class SlackResponseAttachmentAction {
		public String type;
        public String text;
        public String url;
        
        public SlackResponseAttachmentAction(String type, String text, String url){
            this.type = type;
            this.text = text;
            this.url = url;
        }
}