Location Grabber - Coding Challenge
===================================

Using Ruby, create a command line application that recursively reads all of the images from the supplied directory of images, extracts their EXIF GPS data (longitude and latitude), and then writes the name of that image and any GPS co-ordinates it finds to a CSV file.

This utility should be executable from the command line (i.e.: ‘ruby ./app.rb’ or as an executable).
With no parameters, the utility should default to scanning from the current directory. It should take an optional parameter that allows any other directory to be passed in.

As a bonus, output either CSV or HTML, based on a parameter passed in via the command line.

Running the application
-----------------------

for help:
```
./bin/location_grabber --help
```

do things for real with:
```
./bin/location_grabber
```

Install as a Gem
----------------

run:

```
bundle install && rake build && rake install
```

then you can run from anywhere

```
location_grabber --help
```


Running the tests
-----------------

Running the command:

```
rake
```

will run both the `rspec` unit tests and the `cucumber` integration tests

---------------------------------

```
usage: location_grabber [options] [path]

🤖  Read GPS data from image exif data for a folder of images

v1.0

Options:
    -h, --help                       Show command line help
        --version                    Show help/version info
        --format [html|csv]          sets output format to html
        --output_file output.csv     specify the output file

Arguments:

    path
        path to folder containing images for which you want to read GPS data (optional)
```