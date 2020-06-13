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
  memo = Memo.new(title: params[:title], content: params[:content])
  memo.save

  redirect to('/memos')
end

get '/memos/:id' do
  if @memo = Memo.find(params[:id])
    erb :show
  else
    redirect to('/memos')
  end
end

get '/memos/:id/edit' do
  if @memo = Memo.find(params[:id])
    erb :edit
  else
    redirect to('/memos')
  end
end

patch '/memos/:id' do
  if @memo = Memo.find(params[:id])
    @memo.assign_attributes(title: params[:title], content: params[:content])
    @memo.save
    erb :show
  else
    redirect to('/memos')
  end
end

delete '/memos/:id' do
  if @memo = Memo.find(params[:id])
    @memo.delete
  end

  redirect to('/memos')
end
