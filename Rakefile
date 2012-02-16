require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'bundler'

Bundler::GemHelper.install_tasks
 
desc 'Generate API documentation to doc/rdocs/index.html'
Rake::RDocTask.new do |rd|
  rd.rdoc_dir = 'doc'
  rd.main = 'README.md'
  rd.rdoc_files.include "README.md", "LICENSE", "lib/**/*\.rb"
 
  rd.options << '--inline-source'
  rd.options << '--line-numbers'
  rd.options << '--all'
  rd.options << '--fileboxes'
end

desc "Run tests"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*.rb']
  t.verbose = true
end

task :default => :test
