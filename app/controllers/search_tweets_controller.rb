
class SearchTweetsController < ApplicationController

	def search
       	 
 	user = params["username"].to_s


	#response =  RestClient.get("https://twitter.com/statuses/user_timeline/"+user+".json")
	response =  RestClient.get("http://api.twitter.com/1/statuses/user_timeline.json?id="+user+"&count=200&page=1")
        @generated_json = response.body


        @hashOfResponse = JSON.parse(@generated_json)
        @tweets_count = []

            @hashOfResponse.each { |trend|
                    @tweets_count << trend['text'].split.size
            }

	

		respond_to do |format|
          	    format.html {} 
    		end  
  
  	end
end
