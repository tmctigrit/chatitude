require 'pg'

require_relative 'chatitude/repos/chats_repo.rb'
require_relative 'chatitude/repos/users_repo.rb'


module Chatitude
  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

  def self.clear_db(db)
    db.exec <<-SQL
      DELETE FROM chats;
      DELETE FROM users;
    SQL
  end

  def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users(
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        password VARCHAR
      );
      CREATE TABLE IF NOT EXISTS chats(
        id SERIAL PRIMARY KEY,
        content VARCHAR,
        user_id INT references users(id)
      );
    SQL
  end

  def self.seed_users(db)
    db.exec <<-SQL
      INSERT INTO users (username, password) values ('testuser', 'pass123')
    SQL
  end

  def self.seed_chats(db)
    db.exec <<-SQL
      INSERT INTO chats (content, user_id) values ('i love chocolate', 1)
    SQL
  end

  def self.drop_tables(db)
    db.exec <<-SQL
      DROP TABLE chats;
      DROP TABLE users;
    SQL
  end
end
