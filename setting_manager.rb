#>--------------------------------------------------------------<#
# Author: Josh Teeter
# Date: 2014-06-21
# Purpose: To help people from losing their damn homework!
#>--------------------------------------------------------------<#
require 'fileutils'
require 'time'
require 'yaml'

class Setting_Manager

  def add_project(project_name, branch_name)
    settings = get_settings
    project = {project_name => {'current_branch' => branch_name}}

    if settings['default']['projects'].nil?
      project = {'projects' => {project_name => {'current_branch' => branch_name}}}
      settings['default'].merge!(project)
    else
      settings['default']['projects'].merge!(project)
    end
    puts settings.inspect
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

  def get_version(project_name)
    settings = get_settings
    settings['default']['projects'][project_name]['version']
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
      settings['default']['projects'][project_name]['current_branch'] = branch_name
      #settings['default']['projects'][project_name]['version'] = update_version(project_name).to_s.chomp
      save_yaml(settings)
    rescue
      add_project(project_name, branch_name)
    end
  end

  def update_version(project_name)
    version.to_s.chomp = get_version(project_name)
    version.to_s.chomp.to_i += 0.1
  end

end
