# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './models/memo'

get %r{/|/memos} do
  @memos = Memo.all(ordered: true)
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
  @memo = Memo.find(params[:id])
  redirect to('/memos') if @memo.nil?

  erb :show
end

get '/memos/:id/edit' do
  @memo = Memo.find(params[:id])
  redirect to('/memos') if @memo.nil?

  erb :edit
end

patch '/memos/:id' do
  @memo = Memo.find(params[:id])
  redirect to('/memos') if @memo.nil?

  @memo.assign_attributes(title: params[:title], content: params[:content])
  @memo.save
  erb :show
end

delete '/memos/:id' do
  @memo = Memo.find(params[:id])
  @memo&.delete

  redirect to('/memos')
end
