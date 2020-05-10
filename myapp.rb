# frozen_string_literal: true

require 'sinatra'
require "sinatra/reloader" if development?

get %r{/|/memos} do
  Memo = Struct.new(:id, :title)
  @memos = []
  (1..3).each do |n|
    @memos << Memo.new(n, "メモ#{n}")
  end

  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
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
