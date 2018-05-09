global class SlackResponseAttachment {
		public String fallback;
        public String pretext;
        public String color;
        public String author_name;
        public String author_link;
        public String author_icon;
        public String title;
        public String title_link;
        public String text;
        public String image_url;
        public String thumb_url;
        public String footer;
        public String footer_icon;
        public String ts;
        
        public SlackResponseAttachmentField[] fields;
        public SlackResponseAttachmentAction[] actions;
        
        public SlackResponseAttachment(String pretext) {
            this.pretext = pretext;
            
            this.fields = new SlackResponseAttachmentField[]{};
            this.actions = new SlackResponseAttachmentAction[]{};
        }	
}