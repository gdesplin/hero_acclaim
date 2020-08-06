class ApplicationController < ActionController::Base

  private

  def hero_email(hero)
    "#{hero['id']}@marvel.com"
  end

end
