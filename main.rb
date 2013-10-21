#coding: UTF-8
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pony'
require 'sass'
require 'haml'
require './message'

require 'sass/plugin/rack'
use Sass::Plugin::Rack

configure do
  set email_options: {
    to: 'kranbortspb@gmail.com',
    from: 'kranbortspb@gmail.com',
    port: '587',
    via: :smtp,
    enable_starttls_auto: true,
    via_options: {
      address: 'smtp.gmail.com',
      port: '587',
      enable_starttls_auto: true,
      user_name: 'kranbortspb',
      password: 'qwedsa123',
      authentication: :plain,
      domain: 'localhost.localdomain'
    }
  }
end
Pony.options = settings.email_options

get('/') { haml :index }
get('/contacts') { haml :contacts }
get('/faq') { haml :faq }
get('/info') { haml :contacts }
get('/prices') { haml :prices }
get('/services') { haml :services }
get('/gallery') { haml :gallery }

post '/contacts' do
  if Message.new(params[:message]).deliver
    logger.info "=========== Mail sent"
  else
    logger.info "=========== Spam detected"
  end
  redirect to('/')
end
