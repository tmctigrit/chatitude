module Chatitude
  class ChatsRepo
    def self.all db
      sql = %q[SELECT * FROM chats]
      result = db.exec(sql)
      result.entries
    end

    def self.find db, id
      sql = %q[SELECT * FROM chats WHERE id = $1]
      result = db.exec(sql, [id])
      result.first
    end

    def self.save db, chat_data
      unless chat_data['id']
        sql = %q[INSERT INTO chats (content, user_id) values ($1, $2) RETURNING *]
        result = db.exec(sql, [chat_data[:content], chat_data[:user_id]])
        result.first
      end
    end

    def self.destroy db, id
      sql = %q[DELETE FROM chats where id = $1]
      db.exec(sql, [id])
      comment_exists?(db, id)
    end

    private

    def self.chat_exists? db, id
      result = find db, id
      !!result.first
    end
  end
end