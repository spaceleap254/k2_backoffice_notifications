require 'sinatra'
require 'json'
helpers Response

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
  	subscriber_message = "Subscriber message for HTTP POST V2! Transaction reference: #{params[:transaction_reference]}. Customer: #{params[:first_name]} #{params[:last_name]}."
  else
  	subscriber_message = ""
  end
  content_type :json
  { :status => '01', :description => description, :subscriber_message => subscriber_message }.to_json
end

post '/httppost_v2_failed_reconciliation.json' do
end

post '/httppost_v2_hmac.json' do
end

post '/xml_http_v2.xml' do
  content_type 'text/xml'
    description = "Accepted"
    reference = params[:transaction_reference]
    first_name = params[:first_name]
    last_name = params[:last_name]
    subscriber_message = ""
    if !reference.empty? && !first_name.empty? && !last_name.empty?
      subscriber_message = "Subscriber message for XML HTTP V2! Transaction reference: #{reference}. Customer: #{first_name} #{last_name}."
    end
  "<?xml version = '1.0' encoding = 'UTF-8'?>
<transaction_response>
    <internal_transaction_id>3222</internal_transaction_id>
    <transaction_reference>#{reference}</transaction_reference>
    <status>01</status>
    <description>#{description}</description>
    <subscriber_message>#{subscriber_message}</subscriber_message>
</transaction_response>"
end



