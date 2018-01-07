# Put your step definitions here

require 'awesome_print'

Then("the outputfile should contain:") do |table|
  contents = File.open("tmp/aruba/output.csv", 'r') { |f| f.read() }
  table.raw.flatten.each do |check|
    expect(contents).to include check
  end
end

Then("the html outputfile should contain:") do |table|
  contents = File.open("tmp/aruba/output.html", 'r') { |f| f.read() }
  table.raw.flatten.each do |check|
    expect(contents).to include check
  end
end