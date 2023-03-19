module Types
  module Objects
    # @note AttachmentType
    class AttachmentType < Types::BaseObject
      description 'AttachmentType'

      field :file_url, String, null: true, description: 'File URL'
      field :id, ID, null: false, description: 'ID'
      field :tweet, Types::Objects::TweetType, null: false, description: 'Tweet'

      def file_url
        return Rails.application.routes.url_helpers.rails_blob_url(object.file, only_path: true) if object.file.attached?

        nil
      end
    end
  end
end
