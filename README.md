# Stock Data Recorder #

I like to keep track of my stock portfolio, but most historical data provides the Mid price. I want the Bid price for a more realistic estimate of the portfolio value.

That's why this simple project was created to regularly request, and store Bid and Ask prices for the specified stocks.

It's not a gem anymore because it was always going to have to be a server based application with a Web API due to the continuous logging part of its functionality. 

The API might be based on Sinatra or Rails, but I'm going to implement it all using JRuby and the JVM.

# Installation #

You're welcome to try the code for yourself, but this is a work in progress, so there are no guarantees! Any financial losses you incurr from my little project are your own problem.                               

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. I'll decide whether I want to include it.

## Copyright

Copyright (c) 2012 James Whinfrey. See the LICENSE file for more details.