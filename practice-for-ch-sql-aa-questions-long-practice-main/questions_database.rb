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
