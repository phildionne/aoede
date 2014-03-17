require 'aoede/attributes/base'

module Aoede
  module Attributes
    module Flac
      include Aoede::Attributes::Base

      AUDIO_PROPERTIES += [:sample_width, :signature]

      def release_date=(value)
        audio.tag.send("year=", value.to_i)
      end

      def track_number=(value)
        audio.tag.send("track=", value.to_i)
      end

      # @return [Image, Nil]
      def image
        return @image if @image

        if image = audio.picture_list.first
          @image = Aoede::Image.new(data: image.data, mime_type: image.mime_type, width: image.width, height: image.height)
        end
      end

      # @param image [Image]
      # @return [Image]
      def image=(image)
        raise ArgumentError, "Image width and height must be present" unless image.width.present? && image.height.present?

        picture = TagLib::FLAC::Picture.new
        picture.mime_type = image.mime_type
        picture.type      = TagLib::FLAC::Picture::FrontCover
        picture.data      = image.data
        picture.width     = image.width
        picture.height    = image.height

        if delete_image && audio.add_picture(picture)
          @image = image
        end

        image
      end

      # Deletes the images
      #
      # @return [Boolean]
      def delete_image
        @image = nil
        !!audio.remove_pictures
      end

      def vendor_id
        audio.xiph_comment.vendor_id
      end
    end
  end
end
