# frozen_string_literal: true

require 'sinatra'
require "sinatra/reloader" if development?
require './models/memo'

get %r{/|/memos} do
  @memos = Memo.all

  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  @memo = Memo.new(title: params[:title], content: params[:content])
  @memo.save

  @memos = Memo.all
  erb :index
end

get '/memos/:id' do
  @memo = Memo.find(params[:id])
  erb :show
end

get '/memos/:id/edit' do
  erb :edit
end

put '/memos/:id' do
end

delete '/memos/:id' do
end
