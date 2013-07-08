class User < ActiveRecord::Base
  attr_reader :entered_password

  has_many :surveys
  has_many :completed_surveys

  validates :name, :length => { :minimum => 3, :message => "must be at least 3 characters, fool!" }
  validates :email, :uniqueness => true, :format => /.+@.+\..+/ # imperfect, but okay

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @entered_password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil # either invalid email or wrong password
  end

  def self.parse_twitter(env)
    user = User.find_or_initialize_by(:uid => env['uid'])
    user.update(:name => env['info']['name'])
    user.save(:validate => false)
    return user
  end
end
