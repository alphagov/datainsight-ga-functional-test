require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new("test",
    "Run all tests including those which depend on being on " +
    "the same local network as other production infrastructure") do |t|
  t.cucumber_opts = %w{--format progress -t ~@pending}
end

task :default => "test"