global class SCHNews implements ISlackCommandHandler{
    public static String triggerText(){
        return 'news';
    }
    public static SlackResponse processCommand(String command){
        String country = 'mx';
        String method = 'all';
        String query = '';
        Integer count = 5;
        
        if(String.isNotBlank(command)){
            String[] textarr = command.split(' ', 2);
            if(textarr.size() >= 1){
                if(textarr[0] == 'search'){
                    method = 'search';
                    query = textarr[1];
                }else {
                    country = textarr[0];
                }
            }
        }
        
        NewsResponse news = getNews(method, country, query);
        
        SlackResponse sr = new SlackResponse('Here you go!');
        Integer counter = 0;
        for(NewsResponseArticles NRA : news.articles){
            if(counter <=5){
            	SlackResponseAttachment sra = new SlackResponseAttachment('');
        		sra.author_name = NRA.author;
        		//sra.image_url = NRA.urlToImage;
        		sra.text = NRA.description;
        		sra.title = NRA.title;
        		sra.title_link = NRA.url;
        		sra.footer = NRA.source.name;
        		sr.addAtachment(sra);   
            }else{
                break;
            }
            counter++;
        }
        return sr;
    }
    
    public static NewsResponse getNews(String method, String country, String query){
        String apiKey = 'd7fb47bb7532468cae49ce51719b5034';
       	String url = '';
        
        if(method == 'all'){
        	url = 'https://newsapi.org/v2/top-headlines?country=' + country + '&apiKey=' + apiKey;  
        }else {
            url = 'https://newsapi.org/v2/everything?q=' + query + '&sortBy=popularity&apiKey=' + apiKey;
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
		req.setMethod('GET');
		Http http = new Http();
		HTTPResponse res = http.send(req);
		System.debug(res.getBody());
        NewsResponse nr = (NewsResponse) System.JSON.deserialize(res.getBody(), NewsResponse.class);
		System.debug(nr);
        return nr;
    }
}