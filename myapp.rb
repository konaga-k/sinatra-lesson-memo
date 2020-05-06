# frozen_string_literal: true

require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
end

get '/memos/new' do
end

post '/memos' do
end

get '/memos/:id' do
end

get '/memos/:id/edit' do
end

put '/memos/:id' do
end

delete '/memos/:id' do
end
