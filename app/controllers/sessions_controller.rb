class SessionsController < ApplicationController
skip_before_action :authenticate_user

def create
  resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
    req.params['client_id'] = ENV['3BL5P4PQNVWBJPJ53BHQMHW2HSO53ZHSMXLZB50BEJ0TJL0V']
    req.params['client_secret'] = ENV['U4F4BCXEXDOVQTZUD5OTZZJ4XDGSV5YQZIB3FZTMBR51Q25V']
    req.params['grant_type'] = 'authorization_code'
    req.params['redirect_uri'] = "http://localhost:3000/auth"
    req.params['code'] = params[:code]
  end
 
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
end