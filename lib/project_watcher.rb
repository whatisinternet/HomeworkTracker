#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: Homework Tracker was created to provide an easy to use and understand
# wrapper for git. The idea is to provide students with something easy to use
# with low overhead an nearly zero terminal knowledge.
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
