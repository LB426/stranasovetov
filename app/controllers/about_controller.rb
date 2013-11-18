class AboutController < ApplicationController
	skip_before_action :require_login, only: [:index]
  def index
  	@publications = Publication.where("id > 0").order("id DESC").load
  	
  	#bashorg = Feedzirra::Feed.fetch_and_parse("http://bash.im/rss/")
    #logger.debug "bashorg.entries.first.summary = #{bashorg.entries.first.summary}"
  	#pravda = Feedzirra::Feed.fetch_and_parse("http://gazeta-pravda.ru/component/option,com_rss/feed,RSS2.0/no_html,1/")
    #logger.debug "pravda.entries.first.summary = #{pravda.entries.first.summary}"
  end
end
