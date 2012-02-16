Abrio
======

A Ruby API for http://abr.io

More information for API here:
http://abr.io/pages/api

Project goals:
  *Easy to use
  *Flexible to configure
  *No external dependencies

Installation
------------

    gem install abrio

Usage
-----

Case 1:

    require "rubygems"
    require "abrio"

    client = Abrio::Client.new(:login => "login", :key => "Z_123")
    url = client.shorten("http://google.com")
    url.short_url  #=> "http://abr.io/11jU"

Case 2:

    require "rubygems"
    require "abrio"

    #This is useful to setup config at Rails initializer for example.
    Abrio.setup do |client|
      client.uri = "http://abr.io/api/links"
      client.login = "login"
      client.key = "key"
    end
    url = Abrio.shorten("http://google.com")
    url.short_url  #=> "http://abr.io/18VN"

Running the Tests
-----------------

Install development dependencies with:

    $ bundle install

To run the test suite:

    $ rake test


Contributing
------------

Once you've made your great commits:

1. [Fork][0] abrio
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create an [Issue][1] with a link to your branch
5. That's it!


[0]: http://help.github.com/forking/
[1]: https://github.com/abril/abrio/issues
