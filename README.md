# Aoede
A thin wrapper on top of [taglib-ruby](https://github.com/robinst/taglib-ruby) providing a consistent API to play with tracks.

[![Gem Version](https://badge.fury.io/rb/aoede.png)](http://badge.fury.io/rb/aoede)
[![Code Climate](https://codeclimate.com/github/phildionne/aoede.png)](https://codeclimate.com/github/phildionne/aoede)
[![Coverage Status](https://coveralls.io/repos/phildionne/aoede/badge.png)](https://coveralls.io/r/phildionne/aoede)
[![Build Status](https://travis-ci.org/phildionne/aoede.png)](https://travis-ci.org/phildionne/aoede)

## Usage

### Track

Instantiating a new track automatically infers the underlying `TagLib::File` to use by looking at the filename. Currently these formats are supported: `mp4, m4a, oga, ogg, flac, mp3`

```ruby
t = Aoede::Track.new("path-to/Temples - Mesmerise.mp3")

t.album        #=> "Sun Structures"
t.album_artist #=> "Temples"
t.artist       #=> "Temples"
t.genre        #=> "Progressive Rock"
t.release_date #=> "2014"
t.title        #=> "Mezmerise"
t.track_number #=> "5/12"

t.audio_properties
# => { bitrate: 320, channels: 2, length: 222, sample_rate: 44100, layer: 3, version: 0 }

t.update(title: "Mesmerise")
# => true
```

Access the underlying TagLib::File:

```ruby
t.audio
# => #<TagLib::MPEG::File:0x007fa1b1b76290 @__swigtype__="_p_TagLib__MPEG__File">
```

__Note:__ Pass `audio_properties: false` for faster initialization, see [http://rubydoc.info/gems/taglib-ruby/TagLib/FileRef:initialize](http://rubydoc.info/gems/taglib-ruby/TagLib/FileRef:initialize)


### Image

A simple structure to work with images:

```ruby
f = File.new("path-to/cover.jpeg")
i = Aoede::Image.new(data: f.read, format: :jpeg, width: 200, height: 200)

# Adding an image
t.add_image(i)
# =>

t.save
t.images
# =>

# Deleting all images
t.delete_images
# => true
```


### Library

Useful for working with multiple tracks:

```ruby
l = Aoede::Library.new("/Users/pdionne/Music/iTunes/iTunes Media/Music/")

l.files
# => #<Enumerator::Lazy: ...>

l.tracks
# => #<Enumerator::Lazy: ...>
```

## Thanks
- Robin Stocker for [taglib-ruby](https://github.com/robinst/taglib-ruby)

## Contributing

1. Fork it
2. [Create a topic branch](http://learn.github.com/p/branching.html)
3. Add specs for your unimplemented modifications
4. Run `bundle exec rspec`. If specs pass, return to step 3.
5. Implement your modifications
6. Run `bundle exec rspec`. If specs fail, return to step 5.
7. Commit your changes and push
8. [Submit a pull request](http://help.github.com/send-pull-requests/)
9. Thank you!

## Author

[Philippe Dionne](http://phildionne.com)

## License

See [LICENSE](https://github.com/phildionne/aoede/blob/master/LICENSE)
