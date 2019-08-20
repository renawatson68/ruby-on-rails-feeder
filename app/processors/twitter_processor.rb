class TwitterProcessor < BaseProcessor
  protected

  def entities
    pick_uid = ->(entity) { [entity.fetch('id').to_s, entity] }
    tweets.map(&pick_uid).to_h
  end

  def tweets
    content.as_json
  end
end
