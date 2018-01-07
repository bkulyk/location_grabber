# Put your step definitions here

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

Then(/^the output file "([^"]*)" should exist$/) do |file_name|
  path = File.join "tmp/aruba", file_name
  expect(File.exists?(path)).to be true
end
