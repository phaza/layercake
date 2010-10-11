# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{layercake}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Haza"]
  s.date = %q{2010-10-11}
  s.description = %q{LayerCake is a simple gem that allows you to specify more than one cache store in rails.  
It is built on the idea that memory store is the most efficient store with no network or file overhead, but serves multi-process or multi-server architectures, hence a fallback like filestore or memcached store is necessary.}
  s.email = %q{peter.haza@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "layercake.gemspec",
     "lib/layercake.rb",
     "lib/layercake/store.rb",
     "test/helper.rb",
     "test/test_layercake.rb"
  ]
  s.homepage = %q{http://github.com/phaza/layercake}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Support for multiple cache stores in rails, typically memory and/or file and memcached}
  s.test_files = [
    "test/helper.rb",
     "test/test_layercake.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

