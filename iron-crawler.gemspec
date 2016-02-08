# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: iron-crawler 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "iron-crawler"
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ben Visser"]
  s.date = "2016-02-08"
  s.description = "A generic web crawler that doesn't crawl outside URLs."
  s.email = "theodore.r.visser@gmail.com"
  s.executables = ["iron-crawler"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/iron-crawler",
    "iron-crawler.gemspec",
    "lib/iron-crawler.rb",
    "lib/iron-crawler/crawler.rb",
    "tasks/jeweler.rake",
    "tasks/qa.rake"
  ]
  s.homepage = "http://github.com/noqcks/iron-crawler"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "A generic web crawler."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.4.0"])
      s.add_development_dependency(%q<reek>, ["~> 3.10.0"])
      s.add_development_dependency(%q<roodi>, ["~> 5.0.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.8.0"])
      s.add_development_dependency(%q<churn>, ["~> 1.0.2"])
      s.add_development_dependency(%q<flay>, ["~> 2.7.0"])
      s.add_development_dependency(%q<flog>, ["~> 4.3.2"])
      s.add_development_dependency(%q<inch>, ["~> 0.7.0"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.37.0"])
    else
      s.add_dependency(%q<mechanize>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.4.0"])
      s.add_dependency(%q<reek>, ["~> 3.10.0"])
      s.add_dependency(%q<roodi>, ["~> 5.0.0"])
      s.add_dependency(%q<yard>, ["~> 0.8.0"])
      s.add_dependency(%q<churn>, ["~> 1.0.2"])
      s.add_dependency(%q<flay>, ["~> 2.7.0"])
      s.add_dependency(%q<flog>, ["~> 4.3.2"])
      s.add_dependency(%q<inch>, ["~> 0.7.0"])
      s.add_dependency(%q<rubocop>, ["~> 0.37.0"])
    end
  else
    s.add_dependency(%q<mechanize>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.4.0"])
    s.add_dependency(%q<reek>, ["~> 3.10.0"])
    s.add_dependency(%q<roodi>, ["~> 5.0.0"])
    s.add_dependency(%q<yard>, ["~> 0.8.0"])
    s.add_dependency(%q<churn>, ["~> 1.0.2"])
    s.add_dependency(%q<flay>, ["~> 2.7.0"])
    s.add_dependency(%q<flog>, ["~> 4.3.2"])
    s.add_dependency(%q<inch>, ["~> 0.7.0"])
    s.add_dependency(%q<rubocop>, ["~> 0.37.0"])
  end
end

