require 'spec_helper'

describe LocationGrabber do

  before :all do
    @path = File.join(File.dirname(__FILE__), "samples")
  end

  describe "#get_all_files" do
    it "should get a list of files for a given path, recursively" do
      result = subject.get_all_files(@path).map { |f| File.basename(f) }
      expect(result).to include('image_a.jpg')
      expect(result).to include('image_b.jpg')
      expect(result).to include('image_c.jpg')
      expect(result).to include('image_d.jpg')
      expect(result).to include('image_e.jpg') # this folder is in a deeper path
    end
  end

  describe "#get_exif_for_file" do
    it 'should get exif data for a jpeg file' do
      file_path = File.join(@path, 'gps_images', 'image_a.jpg')
      result = subject.get_exif_for_file file_path
      expect(result.gps.latitude.to_i).to eql 50
      expect(result.gps.longitude.to_i).to eql -122
    end
  end

  describe "#relative_path" do
    it 'should get exif data for a jpeg file' do
      file_path = File.join(@path, 'gps_images', 'image_a.jpg')
      result = subject.relative_path @path, file_path
      expect(result).to eql "./gps_images/image_a.jpg"
    end
  end

  describe "#get_formatter" do
    it 'should get csv formatter by default' do
      expect(subject.get_formatter.name).to eql "LocationGrabber::CSV"
    end

    it 'should get html formatter if "html" was requested' do
      expect(subject.get_formatter("html").name).to eql "LocationGrabber::HTML"
    end

    it 'should get html formatter if "csv" was requested' do
      expect(subject.get_formatter("csv").name).to eql "LocationGrabber::CSV"
    end
  end

  describe "#get_gps_data_for_files_recursive" do
    it 'should gps info for a folder name' do
      result = subject.get_gps_data_for_files_recursive @path

      # this one has gps data
      expect(File.basename(result[0][:file])).to eql "image_e.jpg"
      expect(result[0][:data].latitude.to_i).to eql 59
      expect(result[0][:data].longitude.to_i).to eql 10

      # this one has no gps data
      expect(File.basename(result[2][:file])).to eql "image_b.jpg"
      expect(result[2][:data]).to be nil
    end
  end

end

describe LocationGrabber::HTML do

  before :all do
    @path = File.join(File.dirname(__FILE__), "samples")
  end

  describe "#render" do
    it 'should be able to render html for the give data' do
      data = LocationGrabber.get_gps_data_for_files_recursive(@path)
      html = subject.render data

      expect(html).to include "<html>"
      expect(html).to include "<h1"
      expect(html).to include "image_a.jpg"
      expect(html).to include "image_b.jpg"
      expect(html).to include "image_c.jpg"
      expect(html).to include "image_d.jpg"
      expect(html).to include "image_e.jpg"
    end
  end

end

describe LocationGrabber::CSV do

  before :all do
    @path = File.join(File.dirname(__FILE__), "samples")
  end

  describe "#render" do
    it 'should be able to render html for the give data' do
      data = LocationGrabber.get_gps_data_for_files_recursive(@path)
      csv = subject.render data
      expect(csv).to include "file,latitude,longitude"
      expect(csv).to include "image_a.jpg"
      expect(csv).to include "image_b.jpg"
      expect(csv).to include "image_c.jpg"
      expect(csv).to include "image_d.jpg"
      expect(csv).to include "image_e.jpg"
    end
  end

end
