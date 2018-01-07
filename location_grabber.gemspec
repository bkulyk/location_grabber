
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lib_location_grabber"

Gem::Specification.new do |spec|
  spec.name          = "location_grabber"
  spec.version       = LocationGrabber::VERSION
  spec.authors       = ["Brian Kulyk"]
  spec.email         = ["brian@kulyk.ca"]

  spec.summary       = %q{extracts gps coordinates from all jpegs in a folder}
  spec.description   = %q{recursively reads all of the images from the supplied directory of images, extracts their EXIF GPS data (longitude and latitude), and then writes the name of that image and any GPS co-ordinates it finds to a CSV file}

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('methadone', '~> 1.9.5')
  spec.add_dependency('exifr', '~> 1.3.3')
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('aruba')
  spec.add_development_dependency('test-unit')
  spec.add_development_dependency('rspec', '~> 3')
  spec.add_development_dependency('awesome_print')
end
