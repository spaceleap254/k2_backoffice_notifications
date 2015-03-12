require 'sinatra'
require 'json'
require 'nokogiri'
require 'pp'
require 'openssl'
require 'addressable/uri'
require 'base64'

get '/' do
  "Go to /httppost_v2.json"
end

post '/httppost_v2.json' do
  status 200
  description = "Accepted"
  reference = params[:transaction_reference]
  first_name = params[:first_name]
  middle_name = params[:middle_name]
  last_name = params[:last_name]
  if !reference.nil? && !first_name.nil? && !last_name.nil?
  	subscriber_message = "Subscriber message for HTTP POST V2! Transaction reference: #{params[:transaction_reference]}. Customer: #{params[:first_name]} #{params[:middle_name]} #{params[:last_name]}."
  else
  	subscriber_message = ""
  end
  content_type :json
  { :status => '01', :description => description, :subscriber_message => subscriber_message }.to_json
end

post '/httppost_v2_hmac.json' do
  def encode(value)
  value = value.to_s if value.kind_of?(Symbol)
  return Addressable::URI.encode_component(
      value,
      Addressable::URI::CharacterClasses::UNRESERVED
  )
  end
  api_key = "8b9ff59121c213a832fc1e3973fa364338c78671" #this is my API key generated on a test environment
  k2_signature = params[:signature]
  reference = params[:transaction_reference]
  first_name = params[:first_name]
  middle_name = params[:middle_name]
  last_name = params[:last_name]
  #the username and password will be moved to the header (as should be the case) soon
  params.delete('username')
  params.delete('password')

  params.delete('signature')
  base_string =  ((params.to_a.map do |(key, value)|
                   [key.to_s, value.to_s]
                 end).sort.inject([]) do |accu, (key, value)|
                   accu << encode(key) + '=' + encode(value)
                   accu
                 end).join('&')
  
  signature = Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), api_key, base_string))

  content_type :json
  puts k2_signature
  puts signature
  if k2_signature == signature   
    status 200
    result = {}
    description = "Accepted"
    if !reference.nil? && !first_name.nil? && !last_name.nil?
      subscriber_message = "Subscriber message for HTTP POST V2 HMAC AUTHENTICATED! Transaction reference: #{reference}. Customer: #{first_name} #{middle_name} #{last_name}."
    end
    result = { :status => '01', :description => description, :subscriber_message => subscriber_message }.to_json
  else
    status 400
    description = "HMAC Authentication failed. Untrusted source."
    result = { :status => '', :description => '', :subscriber_message => "" }.to_json
  end
  result
end

post '/httppost_v2_failed_reconciliation.json' do
end

post '/xml_http_v2.xml' do
  description = "Accepted"
  reference = ""
  first_name = ""
  last_name = ""
  subscriber_message = ""
  req = Nokogiri::XML::Reader(request.body)
  pp req
  if req
    req.each do |node|
      if node.name == "transaction_reference"
        reference = node.inner_xml
      elsif node.name == "first_name"
        first_name = node.inner_xml
      elsif node.name == "last_name"
        last_name = node.inner_xml
      end    
    end
  end
  
  if !reference.nil? && !first_name.nil? && !last_name.nil?
    subscriber_message = "Subscriber message for XML HTTP V2! Transaction reference: #{reference}. Customer: #{first_name} #{last_name}."
  end
  content_type 'text/xml'
  "<?xml version = '1.0' encoding = 'UTF-8'?>
     <transaction_response>
     <internal_transaction_id>3222</internal_transaction_id>
     <transaction_reference>#{reference}</transaction_reference>
     <status>01</status>
     <description>#{description}</description>
     <subscriber_message>#{subscriber_message}</subscriber_message>
   </transaction_response>"
end

post '/xml_http_v2_failed_reconciliation.xml' do
end




