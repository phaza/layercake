# LayerCake

## Description
LayerCake is a simple gem that allows you to specify more than one cache store in rails.  
It is built on the idea that memory store is the most efficient store with no network or file overhead, but serves multi-process or multi-server architectures, hence a fallback like filestore or memcached store is necessary.

## Installation

The order of the arguments are defining the layers, where the first ones are on the lowest/closest levels.  
Add this in your application.rb (Rails 3 anyway)  
`config.cache_store = Layercake::Store.new(:memory_store, :mem_cache_store => 'localhost:11211')`  
(localhost:11211 is default, and not really necessary to specify)

Use it like you would normally use any cache store.  
`Rails.cache.fetch
Rails.cache.write
Rails.cache.read`  
all the options given will be passed on to the individual cache stores

## Tests
If you write, I'll merge

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Peter Haza. See LICENSE for details.
