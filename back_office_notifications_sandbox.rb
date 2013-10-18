require 'sinatra'
require 'json'

get '/' do
  "Go to /httppost_v2.json for the JSON response for HTTP POST notifications. More to come..."
end

post '/httppost_v2.json' do
  status 200
  description = "Accepted"
  reference = params[:transaction_reference]
  first_name = params[:first_name]
  last_name = params[:last_name]
  if !reference.empty? && !first_name.empty? && !last_name.empty?
  	subscriber_message = "Subscriber message ndio hiyo > Transaction reference: #{params[:transaction_reference]}. Customer: #{params[:first_name]} #{params[:last_name]}."
  else
  	subscriber_message = ""
  end
  content_type :json
  { :status => '01', :description => description, :subscriber_message => subscriber_message }.to_json
end
