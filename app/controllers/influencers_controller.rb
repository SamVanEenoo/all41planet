class InfluencersController < ApplicationController

  def index
    @influencers = Influencer.all
  end

  def new
  end
end
