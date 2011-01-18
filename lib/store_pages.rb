require 'sinatra/base'

module Sinatra  
  module StorePages
    module Helpers
    end
  
    def self.registered(app)
      app.helpers StorePages::Helpers

      app.get '/:slug' do |slug|
        @page = Page.find_by_slug(slug)
        @title = @page.title + ' | ' + settings.store_title
        erb :page
      end
    end
  end
end
