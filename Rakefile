require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "turtle"
    gem.summary = %Q{minimal task management}
    gem.description = %Q{minimal console-based task management system}
    gem.email = "mail@dreamimperium.tk"
    gem.homepage = "https://github.com/Dream-Imperium/turtle"
    gem.authors = ["Dream-Imperium"]
    gem.add_development_dependency "rspec"
    gem.add_dependency "colored", ">= 1.2"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) is not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--color', '--format=specdoc']
end

task :spec => :check_dependencies

task :default => :spec

