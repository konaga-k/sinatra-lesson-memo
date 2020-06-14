# frozen_string_literal: true

# modelではないが、他の場所に配置しようにもディレクトリ名が思いつかない
class Connection
  DBNAME = 'sinatra_lesson_memo_development'
  USER = 'root'
  PASSWORD = 'root'

  def self.resource
    connection_options = { dbname: DBNAME, user: USER, password: PASSWORD }
    @resource ||= PG.connect(**connection_options)
  end
end
