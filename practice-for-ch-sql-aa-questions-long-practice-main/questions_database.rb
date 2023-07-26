require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end


class Question

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| self.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    return nil unless question.length > 0
    Question.new(question.first)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  attr_accessor :id, :title, :body, :author_id
end

class User

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| self.new(datum) }
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    return nil unless user.length > 0
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    return nil unless users.length > 0
    users.map{|us| User.new(us)}
    # User.new(users.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  attr_accessor :id, :fname, :lname
end

class QuestionFollows

  def self.find_by_id(id)
    question_follows = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_follows
    WHERE
      id = ?
    SQL
    return nil unless question_follows.length > 0
    QuestionFollows.new(question_follows.first)
  end

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| self.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  attr_accessor :user_id, :question_id, :id
end

class Replies

    def self.all
      data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
      data.map { |datum| self.new(datum) }
    end

    def self.find_by_id(id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL
      return nil unless reply.length > 0
      Replies.new(reply.first)
    end

    def initialize(options)
      @id = options['id']
      @body = options['body']
      @pre_question_id = options['pre_question_id']
      @parent_reply_id = options['parent_reply_id']
      @user_id = options['user_id']
    end

    attr_accessor :id, :body, :pre_question_id, :parent_reply_id, :user_id

end

class QuestionLikes

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| self.new(datum) }
  end

  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL
    return nil unless question_like.length > 0
    QuestionLikes.new(question_like.first)
  end

  def initialize(options)
    @id = options['id']
    @liked = options['liked']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  attr_accessor :id, :liked, :question_id, :user_id
end
