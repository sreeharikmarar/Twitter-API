
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

	@actual_count = Hash.new(0)

	# iterate over the array, counting duplicate entries	
	  @tweets_count.each do |v|
  		@actual_count[v] += 1
	end

	@count = @actual_count.sort_by {|key,value| value }
	puts " ----------- #{@count}"
		respond_to do |format|
          	    format.html {} 
    		end  
  
  	end
end
