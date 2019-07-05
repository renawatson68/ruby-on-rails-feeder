module Normalizers
  class NextbigfutureNormalizer < Normalizers::Base
    protected

    def link
      entity.url
    end

    def published_at
      entity.published
    end

    def text
      [entity.title, link].join(separator)
    end

    def attachments
      [image_url].compact
    end

    def comments
      [description].compact
    end

    private

    def image_url
      @image_url ||= Service::NextbigfutureThumbnailFetcher.call(link)
    end

    def description
      Service::Html.comment_excerpt(entity.summary)
    end
  end
end
