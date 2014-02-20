require 'aoede/attributes/base'

module Aoede
  module Attributes
    module Flac
      include Aoede::Attributes::Base

      AUDIO_PROPERTIES += [:sample_width, :signature]

      # @return [Array]
      def images
        audio.picture_list.map do |image|
          Aoede::Image.new(data: image.data, mime_type: image.mime_type, width: image.width, height: image.height)
        end
      end

      # @param image [Image]
      def add_image(image)
        picture = TagLib::FLAC::Picture.new

        picture.mime_type = image.mime_type
        picture.type      = TagLib::FLAC::Picture::FrontCover
        picture.data      = image.data
        picture.width     = image.width
        picture.height    = image.height

        audio.add_picture(picture)
      end

      # Deletes all images
      #
      # @return [Nil]
      def delete_images
        audio.remove_pictures
      end

      def vendor_id
        audio.xiph_comment.vendor_id
      end
    end
  end
end
