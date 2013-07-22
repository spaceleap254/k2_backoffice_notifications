require 'sinatra'
require 'json'

get '/k2_back_office_notification.json' do
  status 200
  content_type :json
  { :status => '01', :description => 'Accepted', :subscriber_message => "Back office notification received" }.to_json
end

post '/k2_back_office_notification.json' do
  status 200
  content_type :json
  { :status => '01', :description => 'Accepted', :subscriber_message => "Back office notification received for transaction #{params[:transaction_reference]} from #{params[:first_name]} #{params[:last_name]}" }.to_json
end
