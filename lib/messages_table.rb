class MessagesTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create_message(name, message)
    insert_message_sql = <<-SQL
    INSERT INTO messages (name, message)
    VALUES ('#{name}', '#{message}')
    RETURNING ID
    SQL

    @database_connection.sql(insert_message_sql)
  end

  def find_message
    message_setter = <<-SQL
    SELECT * FROM messages
    SQL
    @database_connection.sql(message_setter).collect
  end

end
