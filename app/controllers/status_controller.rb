class StatusController < ApplicationController

  def index
  
    before_index
    
    @frequent_errors = 
      begin
        Rails.cache.fetch('frequent_hoptoad_errors', :expires_in => ERROR_EXPIRY_TIME_IN_MINUTES.minutes) do
          hoptoad = Hoptoad.new
          errors = Error.find :all
          errors.partition { |e| e.notices_count >= ERROR_FREQUENCY_MINIMUM }.first
        end
      rescue
        []
      end
    
    @newrelic_account = Rails.cache.fetch('newrelic_account', :expires_in => 60.seconds) do
      NewRelicApi.api_key = NEWRELIC_API_KEY
      NewRelicApi::Account.find(NEWRELIC_ACCOUNT_ID)
    end
    
    @posts = Post.paginate :page => params[:page], :order => 'created_at DESC'
    
    after_index
    
  end
  
  private
  
  def before_index
  end
  
  def after_index
  end
  
end
