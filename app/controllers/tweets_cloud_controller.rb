class TweetsCloudController < ApplicationController

	def index
    respond_to do |format|
      format.html {}
    end
	end

	def cloud_tag
	
       	 
    user = params["username"].to_s


    #response =  RestClient.get("https://twitter.com/statuses/user_timeline/"+user+".json")[
    response =  RestClient.get("http://api.twitter.com/1/statuses/user_timeline.json?id="+user+"&count=200&page=1&include_rts=true"){|response, request, result| response }


#    puts "&"*100
#    puts "RESPONSE CODE : #{response.code}"
#    puts "&"*100
#    puts "RESPONSE TO STRING : #{response.to_str}"
#    puts "&"*100
#    puts "RESPONSE HEADERS : #{response.headers}"


    @generated_json = response.body


    @hashOfResponse = JSON.parse(@generated_json)

    @tweets_count = []
    @re_tweets_count = []

    @hashOfResponse.each { |res|
      @tweets_count << res['text'].split.size
    }
    
    @hashOfResponse.each { |re_twt|
      @re_tweets_count << re_twt['retweet_count']
    }

   
    
    puts "^"*100
    puts "retweets_count : #{@re_tweets_count}"
    puts "^"*100
    
    @actual_count = Hash.new(0)

    # iterate over the array, counting duplicate entries
	  @tweets_count.each do |v|
  		@actual_count[v] += 1
    end

     @count = @actual_count.sort_by {|key,value| value }.reverse
     
		respond_to do |format|
      format.html {}
    end
  
  end


end
