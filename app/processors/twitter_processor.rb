require 'rss'

module Processors
  class TwitterProcessor < Processors::Base
    protected

    def entities
      source.as_json.map { |entity| [entity['id'].to_s, entity] }.to_h
    end
  end
end
