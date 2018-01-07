Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "location_grabber"
    Then the exit status should be 0
    And the banner should be present
    And the banner should document that this app takes options
    And the following options should be documented:
      |--format      |
      |--version     |
      |--help        |
      |--output_file |
    And the banner should document that this app's arguments are:
      | path | which is optional |


  Scenario: Run for folder
    When I run `location_grabber ../../spec/samples`
    Then the output should contain "Success! Check contents of"
    Then the output should contain "output.csv"
    Then the outputfile should contain:
      | gps_images/cats/image_e.jpg,59.92475507998271,10.695598120067395 |
      | gps_images/image_d.jpg,,                                         |
      | gps_images/image_b.jpg,,                                         |
      | gps_images/image_c.jpg,38.4,-122.82866666666666                  |
      | gps_images/image_a.jpg,50.09133333333333,-122.94566666666667     |


  Scenario: Run for just sub folder
    When I run `location_grabber ../../spec/samples/gps_images/cats`
    Then the output should contain "Success! Check contents of"
    Then the output should contain "output.csv"
    Then the outputfile should contain:
      | image_e.jpg,59.92475507998271,10.695598120067395 |


  Scenario: Run with --format html
    When I run `location_grabber --format html ../../spec/samples`
    Then the output should contain "Success! Check contents of"
    Then the output should contain "output.html"
    Then the html outputfile should contain:
      | <h1>GPS information for files</h1>     |
      | <td>./gps_images/cats/image_e.jpg</td> |


  Scenario: Run with --format html and output_file option
    When I run `location_grabber --output output_file.csv ../../spec/samples`
    Then the output file "output_file.csv" should exist
    Then the output should contain "output_file.csv"

