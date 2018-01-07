require 'exifr/jpeg'
require 'erb'

module LocationGrabber
  VERSION = "1.0"
  HTML_TEMPLATE_FILE = "output.html.erb"

  def self.get_all_files(dir_path)
    return [] if dir_path.nil?
    Dir.glob File.join dir_path, '**', '*.jpg'
  end

  def self.get_exif_for_file(file_path)
    EXIFR::JPEG.new file_path
  end

  def self.relative_path(path, file_path)
    file_path.sub path, '.'
  end

  def self.get_formatter(output_format='csv')
    output_format === 'csv' ? LocationGrabber::CSV : LocationGrabber::HTML
  end

  def self.get_gps_data_for_files_recursive(path)
    get_all_files(path).map do |file|
      {file: relative_path(path, file), data: get_exif_for_file(file).gps}
    end
  end

  module CSV
    def self.render(rows)
      "file,latitude,longitude" + rows.map { |row|
        [row[:file], row[:data]&.latitude, row[:data]&.longitude ].join ","
      }.join("\n")
    end
  end

  module HTML
    def self.get_template
      path = File.join(File.dirname(__FILE__), HTML_TEMPLATE_FILE)
      File.open(path, 'r') { |f| f.read() }
    end

    def self.render(rows)
      @rows = rows
      ERB.new(get_template).result(binding())
    end
  end

end