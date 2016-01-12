class WelcomeController < ApplicationController
  def index
    @user_form = User.form(UserStore)
  end
end
