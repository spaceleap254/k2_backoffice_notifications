require 'sinatra'
require 'json'

get '/' do
  "Go to /httppost_v2.json for the JSON response for HTTP POST notifications. More to come..."
end

get '/httppost_v2.json' do
  status 200
  content_type :json
  { :status => '01', :description => 'Accepted', :subscriber_message => "Back office notification received" }.to_json
end

post '/httppost_v2.json' do
  status 200
  content_type :json
  { :status => '01', :description => 'Accepted', :subscriber_message => "Back office notification received for transaction #{params[:transaction_reference]} from #{params[:first_name]} #{params[:last_name]}" }.to_json
end
