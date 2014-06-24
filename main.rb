#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: To help people from losing their damn homework!
#>--------------------------------------------------------------<#
#!/usr/bin/env ruby

require_relative 'homework'
require_relative 'project_watcher'

class Main
	def run(command, project)

		#puts hw.branch_generator('')
		if command == 'create'
			hw = HomeWork.new
			hw.create(project)
			puts "Successfully created project #{project}"
		elsif command == 'save'
			hw = HomeWork.new
			hw.save_for_now(project)
		elsif command == 'undo'
			hw = HomeWork.new
			hw.undo(project)
		elsif command.to_s == 'save!'
			hw = HomeWork.new
			hw.save(project)
		elsif command.to_s == 'changes?'
			hw = HomeWork.new
			hw.show_log(project)
		elsif command.to_s == 'watch'
			pw = Project_Watcher.new
		  	p1 = fork { pw.watch_project(project) }
		  	Process.detach(p1)
		else
			puts ""
			puts "Usage: homework [command] [project name]"
			puts ""
			puts "		commands: create   [creates a project]"
			puts "		          save     [saves the project] [can still use undo]"
			puts "		          save!    [saves the project] [cannot use undo]"
			puts "		          undo     [reverts a save]"
			puts "		          changes? [outputs the changes. press q to exit]"
			puts ""
		end
	end
end

mn = Main.new
mn.run(ARGV[0].to_s, ARGV[1].to_s)
