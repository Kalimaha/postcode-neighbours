class WelcomeController < ApplicationController
  def index
  end

  def search
    render json: ListingsRepository.find_by_suburb(suburb: suburb).map(&:to_json)
  end

  private

  def suburb
		params[:suburb].split.map(&:capitalize).join(' ')
  end
end
