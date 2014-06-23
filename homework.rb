#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: To help people from losing their damn homework!
#>--------------------------------------------------------------<#
#!/usr/bin/env ruby
root_path = File.dirname(__FILE__)
require_relative 'setting_manager'
require 'time'

class HomeWork
	@@setting_manager = Setting_Manager.new
	@@default_directory = @@setting_manager.get_default_directory

	def branch_generator(project_name)
		dt = Time.now
		branch_name = dt.to_time.iso8601.gsub(' ', '').gsub(':','-')
		if project_name != ''
					@@setting_manager.set_branch(project_name, branch_name)
		end
		branch_name
	end

	# Creates a homework assignment as a new project
	def create(project_name)
		new_branch_name = branch_generator(project_name)
		if project_name.nil?
			puts "Missing project name!"
		else

			exec("
			mkdir #{@@default_directory}#{project_name.to_s} &&
			cd #{@@default_directory}#{project_name.to_s} &&
			git init &&
			git checkout -b master &&
			git commit --allow-empty -m 'first commit' &&
			git tag -a v0.0 -m 'first tag' &&
			git checkout -b #{new_branch_name}
			")

			system("cd #{@@default_directory}#{project_name.to_s}")
			save(project_name)
		end
	end

	def save(project_name)

		current_branch = @@setting_manager.get_branch(project_name)
		new_branch_name = branch_generator(project_name)
		version = @@setting_manager.get_version(project_name)
		if project_name.nil?
			puts "Missing project name!"
		else
			exec("
			cd #{@@default_directory}#{project_name.to_s} &&
			git checkout master &&
			git merge #{current_branch} &&
			git commit -m #{current_branch} &&
			git tag -a v#{version.to_s} -m #{current_branch} &&
			git branch -D #{current_branch} &&
			git checkout -b #{new_branch_name}")
		end
	end

	def save_for_now(project_name)

		current_branch = @@setting_manager.get_branch(project_name)
		version = @@setting_manager.get_version(project_name)
		if project_name.nil?
			puts "Missing project name!"
		else
			exec("
			cd #{@@default_directory}#{project_name.to_s} &&
			git add --all . &&
			git commit -m #{current_branch} &&
			git tag -a v#{version.to_s} -m #{current_branch}")
		end
	end

	def show_log(project_name)

		current_branch = @@setting_manager.get_branch(project_name)
		if project_name.nil?
			puts "Missing project name!"
		else
			exec("
			cd #{@@default_directory}#{project_name.to_s} &&
			git log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat
			")
		end
	end

	# Reverts changes to a project
	def undo(project_name)

		current_branch = @@setting_manager.get_branch(project_name)
		new_branch_name = branch_generator(project_name)

		if project_name.nil?
			puts "Missing project name!"
		else
			exec("
			cd #{@@default_directory}#{project_name.to_s} &&
			git checkout master &&
			git branch -D #{current_branch} &&
			git checkout -b #{new_branch_name}
			")
		end
	end

end #end class
