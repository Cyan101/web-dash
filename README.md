# Web-Dash

![Build Status](https://travis-ci.org/Cyan101/web-dash.svg?branch=master)

Web-Dash is a small Web UI for keeping an eye on your linux system, most likely your NAS or any Pi's/SBC's you have
Its aim is to provide information on statistics such as running services, memory usage, cpu usage and being able to control/toggle said services
Web-Dash will also have support for links to other web programs running so it can be used to navigate through your system remotely without having to bookmark a bunch of URL's

Current Example:
![Current Example](http://i.imgur.com/OxfEls1.png)

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here
1. Compile with `crystal build --release src/web-dash.cr` (add `--no-debug` if you have issues) or use a build from the releases tab
2. `./web-dash > web-dash.output &` is a simple way to run web-dash in the background, might stick with this or look into other better ways. This needs to be run inside the project folder for proper linking to the `public/` folder for CSS and such
2. To use SSL with Web-Dash `./web-dash --ssl --ssl-key-file your_key_file --ssl-cert-file your_cert_file`

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/cyan101/web-dash/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Cyan101](https://github.com/[your-github-name]cyan101) Cyan101 - creator, maintainer
