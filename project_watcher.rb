#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: Watches for filesystem changes within a project and commits changes on updates
#>--------------------------------------------------------------<#
#!/usr/bin/env ruby
root_path = File.dirname(__FILE__)
require_relative 'homework'
require 'time'
require 'rubygems'
require 'listen'

class Project_Watcher
	@@default_directory = ENV['HOME']+ "/HomeworkTracker/projects/"
	@@hw = HomeWork.new

	def watch_project(project_name)
		listener = Listen.to("#{@@default_directory}#{project_name}") do |modified, added, removed|
		  p1 = fork { @@hw.save_for_now(project_name) }
		  Process.waitpid(p1)
		end
		listener.start # not blocking
		sleep
	end
end
