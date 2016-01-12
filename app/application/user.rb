require 'bcrypt'

module User
  include BCrypt

  def self.form(store)
    store.new(nil, nil, nil)
  end

  def self.create(params, store)
    if params[:name] != nil && params[:password] != nil && valid_email?(params[:email]})
      user = store.new(params[:name], params[:email], encripted_password(params[:password]))
      user.create
    else
      user = store.new(params[:name], params[:email], encripted_password(params[:password]))
      user.add_error
      user
    end
  end

private
  def self.encripted_password(password)
    Password.create(password)
  end

  def self.valid_email?(email)

  end
end

class UserStore
  attr_reader :name, :email, :password

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
  end

  def create

  end
end
