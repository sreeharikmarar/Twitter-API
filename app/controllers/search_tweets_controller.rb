
class SearchTweetsController < ApplicationController

	def search
       	 
 	user = params["username"].to_s


	#response =  RestClient.get("https://twitter.com/statuses/user_timeline/"+user+".json")[
	response =  RestClient.get("http://api.twitter.com/1/statuses/user_timeline.json?id="+user+"&count=200&page=1"){|response, request, result| response }
  puts "&"*100
  puts "RESPONSE CODE : #{response.code}"
  puts "&"*100
  puts "RESPONSE TO STRING : #{response.to_str}"
  puts "&"*100
  puts "RESPONSE HEADERS : #{response.headers}"
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
  @list = []
  @hash = Hash.new(0)

  @tweets_count
  @a = []
  
  @actual_count.each do |s|
    @a << Hash[:text => "#{s[0]}" , :weight => s[1]]
 end

 @hash = @a.to_json
  
  puts "%"*100
	puts " ----------- #{@hash}"
  puts "%"*100
  puts "%"*100
	puts " ----------- #{@a}"
  puts "%"*100

    
		respond_to do |format|
          	    format.html {} 
    		end  
  
  	end
end
