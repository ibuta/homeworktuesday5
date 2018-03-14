require 'sinatra'
require 'sinatra/reloader' if development?

require_relative './controllers/tweeters_controller'

use Rack::reloader
use Rack::MethodOverride
run PostsController
