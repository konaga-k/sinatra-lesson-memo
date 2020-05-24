# frozen_string_literal: true

require 'sinatra'
require "sinatra/reloader" if development?
require './models/memo'

# Memo = Struct.new(:id, :title, :content)

get %r{/|/memos} do
  @memos = []
  (1..3).each do |n|
    @memos << Memo.new(id: n, memo: "メモ#{n}", content: "内容#{n}")
  end

  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  @memo = Memo.new(title: params[:title], content: params[:content])
  @memo.save

  @memos = [@memo]
  erb :index
end

get '/memos/:id' do
  erb :show
end

get '/memos/:id/edit' do
  erb :edit
end

put '/memos/:id' do
end

delete '/memos/:id' do
end
