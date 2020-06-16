# frozen_string_literal: true

require 'dotenv/load'

# modelではないが、他の場所に配置しようにもディレクトリ名が思いつかない
class Connection
  def self.resource
    connection_options = { dbname: ENV['DB_NAME'], user: ENV['DB_USER'], password: ENV['DB_PASSWORD'] }
    @resource ||= PG.connect(**connection_options)
  end
end
