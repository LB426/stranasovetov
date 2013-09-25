class AboutController < ApplicationController
	skip_before_action :require_login, only: [:index]
  def index
  	@publications = Publication.where("id > 0").order("id DESC").load
  end
end
