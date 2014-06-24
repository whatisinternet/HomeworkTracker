
require 'fileutils'
require 'time'
require 'yaml'

settings = {'default' => {'directory' => 'HomeworkTracker/projects/',
                          'projects' => nil }}
root_path = File.dirname(__FILE__)
File.open("#{root_path}/settings.yml", "w") do |f|
  f  << settings.to_yaml
end