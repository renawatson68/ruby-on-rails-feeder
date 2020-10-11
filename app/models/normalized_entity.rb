class NormalizedEntity
  extend Dry::Initializer

  option :feed, optional: true
  option :uid, optional: true
  option :link, optional: true
  option :published_at, optional: true
  option :text, optional: true
  option :attachments, optional: true
  option :comments, optional: true
  option :validation_errors, optional: true, default: -> { [] }

  def status
    validation_errors.none? ? PostStatus.ready : PostStatus.ignored
  end

  def ready?
    status == PostStatus.ready
  end

  def find_or_create_post
    existing_post || create_post
  end

  private

  def existing_post
    Post.find_by(feed: feed, uid: uid)
  end

  def create_post
    Post.create!(
      feed: feed,
      uid: uid,
      link: link,
      published_at: published_at,
      text: text,
      attachments: attachments,
      comments: comments,
      validation_errors: validation_errors,
      status: status
    )
  end
end
