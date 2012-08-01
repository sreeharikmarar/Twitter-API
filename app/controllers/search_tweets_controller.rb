
class SearchTweetsController < ApplicationController

	def search
       	 
 user = params["username"].to_s


	response =  RestClient.get("https://twitter.com/statuses/user_timeline/"+user+".json")
        @generated_json = response.body


        @hashOfResponse = JSON.parse(@generated_json)

        @tweets = []
            @hashOfResponse.each { |trend|
                    @tweets << trend['text']
            }
        
		respond_to do |format|
          	    format.html {} 
    		end  
  
  	end
end
