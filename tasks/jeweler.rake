require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = "iron-crawler"
  gem.homepage = "http://github.com/noqcks/iron-crawler"
  gem.license = "MIT"
  gem.summary = %Q{A generic web crawler.}
  gem.description = %Q{A generic web crawler that doesn't crawl outside URLs.}
  gem.email = "theodore.r.visser@gmail.com"
  gem.authors = ["Ben Visser"]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
