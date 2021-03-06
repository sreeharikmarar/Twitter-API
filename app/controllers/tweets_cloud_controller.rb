class TweetsCloudController < ApplicationController
  
    
	def index
    @back_ground_url = 'assets/cloud.jpg'
    @response_text = params[:response_text]
    respond_to do |format|
      format.html {}
    end
    
	end

	def cloud_tag
	
    @back_ground_url = 'assets/tag_cloud.jpg'
    
    user = params["username"].to_s


    response =  RestClient.get("http://api.twitter.com/1/statuses/user_timeline.json?id="+user+"&count=200&include_rts=true&exclude_replies=true&page=1"){|response, request, result| response }


    if response.code == 200
      @generated_json = response.body

      
      @hashOfResponse = JSON.parse(@generated_json)
	
	
      if @hashOfResponse.any?
      @name = @hashOfResponse[0]['user']['name'] if @hashOfResponse[0]['user']['name']
      end

      @tweets_count = []
      
      @hashOfResponse.each { |res|
        @tweets_count << res['text'].split.size if res['text']
      }


      # iterate over the array, counting duplicate entries

      @actual_count = Hash.new(0)

      if @tweets_count.any?
      	@tweets_count.each do |v|
        	@actual_count[v] += 1
      	end
	@count = @actual_count.sort_by {|key,value| value }.reverse
	respond_to do |format|
        	format.html {}
      	end
      else
	@response_text  =  " Sorry! No tweets Found"
        respond_to do |format|
        	format.html {redirect_to root_path(:response_text=>@response_text)}
      	end
      end
          
    elsif response.code == 404
      @response_text  =  " Sorry! That Page Does not Found"
      respond_to do |format|
        format.html {redirect_to root_path(:response_text=>@response_text)}
      end
    elsif response.code == 500
      @response_text  =  " Sorry! Server Error"
      respond_to do |format|
        format.html {redirect_to root_path(:response_text=>@response_text)}
      end
    else
      @response_text  =  " Not Found"
      respond_to do |format|
        format.html {redirect_to root_path(:response_text=>@response_text)}
      end
    end
  
  end


end
