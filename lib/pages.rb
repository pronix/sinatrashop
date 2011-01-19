require 'sinatra/base'

module Sinatra  
  module Pages
    module Helpers
    end
  
    def self.registered(app)
      app.helpers Pages::Helpers

      app.get '/:slug' do |slug|
        @page = Page.find_by_slug(slug)
        unless @page
          redirect '/'
        end
        @title = @page.title + ' | ' + settings.store_title
        erb :page
      end
    end
  end
end
