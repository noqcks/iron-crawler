# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

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

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'bundler/setup'
require 'rubocop/rake_task'
require 'reek/rake/task'
require 'roodi_task'

task default: [:audit]

task audit: [:style, :complexity, :duplication, :design, :documentation]

task style: [:rubocop]

desc 'Enforce Style Conformance with RuboCop'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = false
end

task complexity: [:flog]

desc 'Assess Complexity with flog'
task :flog do
  sh 'flog lib/**/*.rb'
end

task duplication: [:flay]

desc 'Detect duplication with flay'
task :flay do
  sh 'flay lib/**/*.rb'
end

task design: [:reek]

# desc 'Question design decisions with roodi'
# RoodiTask.new do |task|
#   task.patterns = ['lib/**/*.rb']
# end

desc 'Sniff out code smells with reek'
Reek::Rake::Task.new(:reek) do |task|
  task.fail_on_error = false
end

desc 'Identity volatile areas with churn'
task :rework do
  sh 'churn'
end

desc 'Critique documentation with inch'
task :documentation do
  sh 'inch'
end
