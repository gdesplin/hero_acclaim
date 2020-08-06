class HeroesController < ApplicationController

  def index
    @heroes_data = JSON.parse(MarvelService.new(params[:search]).retrieve_characters.body)
  end

  def show
    hero_data = JSON.parse(MarvelService.new(id: params[:id]).retrieve_characters.body)
    @hero = hero_data['data']['results'][0]
    @hero["issued_badges"] = JSON.parse(
      AcclaimService.new.retrieve_issued_badges(
        filter: "recipient_email::#{hero_email(@hero)}"
      ).body
    )["data"]
    @hero["available_badges"] = JSON.parse(AcclaimService.new.retrieve_badge_templates.body)["data"]
  end

end