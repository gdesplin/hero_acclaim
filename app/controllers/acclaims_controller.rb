class AcclaimsController < ApplicationController

  def create
    hero = JSON.parse(params[:hero])
    data = {
      recipient_email: hero_email(hero),
      issued_to_first_name: find_first_name(hero["name"]),
      issued_to_last_name: find_last_name(hero["name"]),
      badge_template_id: params[:badge_template_id],
      issued_at: Time.now
    }
    @badge_data = JSON.parse(
      AcclaimService.new.issue_badge(data).body)["data"]
    redirect_to "/heroes/#{hero['id']}"
  end

  private

  def find_first_name(name)
    name.split(" ")[0]
  end

  def find_last_name(name)
    array = name.split(" ")
    return name if array.length == 1

    array[1..-1].join(" ")
  end

end