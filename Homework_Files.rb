#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: To help people from loosing their damn homework!
#>--------------------------------------------------------------<#
require 'fileutils'
require 'time'

class Homework_Files
	def save_branch_name(project_name, branch_name)
		default_directory = ENV['HOME']+ "/projects/"
		branch_folder = ENV['HOME']+"/HomeworkTracker/branches/"
		directories_folder = ENV['HOME']+"/HomeworkTracker/directories/"

		puts ENV['HOME']+"/branches/#{project_name.to_s}.hw"
		if File.directory?(project_name)
			#exec("mkdir #{project_name.to_s}")
			puts 'oops!'
		end

		if project_name == ''
			File.open("#{branch_folder}/#{project_name.to_s}.hw", 'w') do |f2|
  				f2.puts "#{branch_name}"
			end
		else
			File.open("#{branch_folder}/#{project_name.to_s}.hw", 'w') do |f2|
  				f2.puts "#{branch_name}"
			end
		end

	end

	def open_branch_name(project_name)
		default_directory = ENV['HOME']+ "/projects/"
		branch_folder = ENV['HOME']+"/HomeworkTracker/branches/"
		directories_folder = ENV['HOME']+"/HomeworkTracker/directories/"

		current_branch = File.readlines("#{branch_folder}/#{project_name.to_s}.hw").first.chomp.gsub('/n','')
	end

	def record_directory(project_name)
		default_directory = ENV['HOME']+ "/projects/"
		branch_folder = ENV['HOME']+"/HomeworkTracker/branches/"
		directories_folder = ENV['HOME']+"/HomeworkTracker/directories/"

		File.open("#{directories_folder}/#{project_name.to_s}.hw", 'w') do |f2|
				f2.puts "#{project_name}"
		end
	end

	def read_directory(project_name)
		default_directory = ENV['HOME']+ "/projects/"
		branch_folder = ENV['HOME']+"/HomeworkTracker/branches/"
		directories_folder = ENV['HOME']+"/HomeworkTracker/directories/"

		current_directory = File.readlines("#{directories_folder}/#{project_name.to_s}.hw").first.chomp.gsub('/n','')
	end
end
