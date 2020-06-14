# frozen_string_literal: true

require 'yaml/store'
require 'pg'
require_relative 'connection'

class Memo
  attr_accessor :id, :title, :content

  class << self
    def all(ordered: false)
      sql = ordered ? 'SELECT * FROM memos' : 'SELECT * FROM memos ORDER BY id'
      result = connection.exec(sql)
      result.map { |row| new(id: row['id'], title: row['title'], content: row['content']) }
    end

    def find(id)
      result = connection.exec_params('SELECT * FROM memos WHERE id = $1', [id])
      result.map { |row| new(id: id, title: row['title'], content: row['content']) }.first
    end
  end

  def initialize(attributes)
    assign_attributes(attributes)
  end

  def create
    connection.exec_params('INSERT INTO memos (title, content) VALUES ($1, $2)', [title, content])
  end

  def update
    connection.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3', [title, content, id])
  end

  def delete
    connection.exec_params('DELETE FROM memos WHERE id = $1', [id])
  end

  def assign_attributes(attributes)
    attributes.each do |k, v|
      assign_attribute(k, v)
    end
  end

  private

  class << self
    def memo_file_path
      'data/memo.yml'
    end

    def resource_name
      'memo'
    end

    def connection
      Connection.resource
    end
  end

  %w[memo_file_path resource_name connection].each do |name|
    define_method(name) do
      self.class.send(name)
    end
  end

  def assign_attribute(key, value)
    public_send(:"#{key}=", value)
  end
end
