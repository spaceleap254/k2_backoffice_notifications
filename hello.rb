require 'sinatra'
require 'json'

get '/k2_back_office_notification.json' do
  content_type :json
  { :status => '01', :description => 'Accepted', :subscriber_message => "Back office notification received" }.to_json
end
