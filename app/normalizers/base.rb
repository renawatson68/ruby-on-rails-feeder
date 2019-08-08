module Normalizers
  class Base
    include Callee
    include Dry::Monads[:result]

    param :uid
    param :entity
    param :feed
    option :logger, optional: true, default: -> { Rails.logger }

    def call
      valid? ? Success(payload) : Failure(validation_errors)
    rescue StandardError => e
      logger.error(e)
      Failure("normalization error: #{e.message}")
    end

    protected

    def link
      nil
    end

    def published_at
      nil
    end

    def text
      nil
    end

    def attachments
      []
    end

    def comments
      []
    end

    SEPARATOR = ' - '.freeze

    def separator
      SEPARATOR
    end

    def valid?
      validation_errors.blank?
    end

    def validation_errors
      []
    end

    def options
      feed.try(:options) || {}
    end

    private

    def payload
      {
        'uid' => uid,
        'link' => link,
        'published_at' => published_at,
        'text' => text,
        'attachments' => (attachments || []).reject(&:blank?),
        'comments' => (comments || []).reject(&:blank?)
      }.freeze
    end
  end
end
