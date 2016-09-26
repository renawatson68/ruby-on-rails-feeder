# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  feed_id          :integer          not null
#  link             :string           not null
#  published_at     :datetime         not null
#  text             :string           default(""), not null
#  attachments      :string           default([]), not null, is an Array
#  comments         :string           default([]), not null, is an Array
#  freefeed_post_id :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :integer          default("idle"), not null
#
# Indexes
#
#  index_posts_on_feed_id  (feed_id)
#  index_posts_on_link     (link)
#  index_posts_on_status   (status)
#

class Post < ApplicationRecord
  belongs_to :feed, counter_cache: true

  enum status: Enums::PostStatus.hash

  validate :link, :presence

  RECENT_LIMIT = 50

  scope :publishing_queue, -> { ready.order(published_at: :asc) }
  scope :recent, -> { order(created_at: :desc).limit(RECENT_LIMIT) }

  delegate :name, to: :feed, prefix: :feed

  def feeds
    feed ? [feed.name] : []
  end
end
