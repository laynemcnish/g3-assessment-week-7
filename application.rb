require 'sinatra/base'
require 'gschool_database_connection'
require './lib/messages_table'
require './lib/country_list'

class Application < Sinatra::Application
  enable :sessions

  def initialize
    super
    @messages_table = MessagesTable.new(GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"]))

  end

  get '/' do
    @messages = @messages_table.find_message
    erb :index
  end

  post '/submit_message' do
    @messages_table.create_message(params[:name], params[:message])
    redirect '/'
  end

  get '/continents' do
    all_continents = CountryList.new.continents
    erb :continents, locals: {continents: all_continents}
  end

  get '/continents/:continent_name' do
    list_of_countries = CountryList.new.countries_for_continent(params[:continent_name])
    erb :countries, locals: {countries: list_of_countries, continent: params[:continent_name]}
  end

end