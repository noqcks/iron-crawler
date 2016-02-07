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
