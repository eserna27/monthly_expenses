require 'spec_helper'
require_relative '../app/application/user'

describe 'New User' do
  it 'should have a form with name email and password' do
    user = User.form(UserStoreFake)
    expect(user.name).to eq nil
    expect(user.email).to eq nil
    expect(user.password).to eq nil
  end
end

describe 'Create User' do
  it 'should recive a create user and seccion' do
    user = User.create({name: "Emmanuel", email: "eserna27@gmail.com", password: "123456"}, UserStoreFake)
    expect(user.name).to eq "Emmanuel"
    expect(user.email).to eq "eserna27@gmail.com"
    expect(user.password).to eq "123456"
    expect(user.error).to eq nil
  end

  it 'should have all the params to be create' do
    user = User.create({name: nil, email: nil, password: "nil"}, UserStoreFake)
    expect(user.error).to eq "Se requiere llenar todos los campos"
  end
end

class UserStoreFake
  attr_reader :name, :email, :password, :error
  attr_writer :error
  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
    @error = nil
  end

  def create
    self
  end

  def add_error
    self.error = "Se requiere llenar todos los campos"
  end
end
