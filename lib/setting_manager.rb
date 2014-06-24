#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: Homework Tracker was created to provide an easy to use and understand
# wrapper for git. The idea is to provide students with something easy to use
# with low overhead an nearly zero terminal knowledge.
#>--------------------------------------------------------------<#
require 'fileutils'
require 'time'
require 'yaml'

class Setting_Manager

  def add_project(project_name, branch_name)
    settings = get_settings
    project = {project_name => {'current_branch' => branch_name}}

    if settings['default']['projects'].nil?
      project = {'projects' => {project_name => {'current_branch' => branch_name, 'version' => '0.0'}}}
      settings['default'].merge!(project)
    else
      settings['default']['projects'].merge!(project)
    end
    save_yaml(settings)
  end

  def get_branch(project_name)
    settings = get_settings
    settings['default']['projects'][project_name]['current_branch'].chomp.gsub('/n','')
  end

  def get_default_directory
    settings = get_settings
    ENV['HOME'] + "/#{settings['default']['directory']}"
  end

  def get_settings
    root_path = File.dirname(__FILE__)
    settings = YAML::load(File.open("#{root_path}/settings.yml"))
  end

  def save_yaml(settings_to_save)
    root_path = File.dirname(__FILE__)
    File.open("#{root_path}/settings.yml", "w") do |f|
      f  << settings_to_save.to_yaml
    end
  end

  def set_branch(project_name, branch_name)
    begin
      settings = get_settings
      version = update_version(project_name)
      settings['default']['projects'][project_name]['current_branch'] = branch_name
      save_yaml(settings)
    rescue
      add_project(project_name, branch_name)
    end
  end

end
