#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: To help people from loosing their damn homework!
#>--------------------------------------------------------------<#
require 'fileutils'
require 'time'
require 'yaml'

class Setting_Manager

  def get_settings
    root_path = File.dirname(__FILE__)
    settings = YAML::load(File.open("#{root_path}/settings.yml"))
  end

  def get_default_directory
    settings = get_settings
    ENV['HOME'] + "/#{settings['default']['directory']}"
  end

  def get_branch(project_name)
    settings = get_settings
    settings['default']['projects'][project_name]['current_branch'].chomp.gsub('/n','')
  end

  def set_branch(project_name, branch_name)
    begin
      settings = get_settings
      settings['default']['projects'][project_name]['current_branch'] = branch_name

      root_path = File.dirname(__FILE__)
      File.open("#{root_path}/settings.yml", "w") do |f|
        f  << settings.to_yaml
      end
    rescue NoMethodError
      add_project(project_name, branch_name)
    end
  end
  
  def add_project(project_name, branch_name)
    settings = get_settings
    project = {project_name => {current_branch => branch_name}}
    settings['default']['projects'].merge(project)
  end

end
