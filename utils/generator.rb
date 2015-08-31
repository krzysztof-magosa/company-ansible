#! /usr/bin/env ruby

require 'yaml'
require 'erb'

keywords = []
Dir[File.expand_path ARGV[0]].each do |file|
  content = File.read file
  documentation = content.match(/DOCUMENTATION = '''\n(.*?)\n'''/m)
  next unless documentation

  yaml = YAML::load documentation[1]
  keywords << yaml['module']

  yaml['options'].to_a.each do |option_name, option|
    keywords << option_name

    option['choices'].to_a.each do |choice|
      choice = choice.to_s
      next if choice.include? ' '

      keywords << choice
    end
  end
end

keywords.uniq!.sort!

template = File.read '../company-ansible-keywords.el.erb'
erb = ERB.new(template, nil, '-')

File.write '../company-ansible-keywords.el', erb.result
