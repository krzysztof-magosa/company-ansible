#! /usr/bin/env ruby

require 'yaml'
require 'erb'

keywords = []
Dir[File.expand_path ARGV[0]].each do |file|
  content = File.read file
  documentation = content.match(/DOCUMENTATION = r?'''\n(.*?)\n'''/m)
  next unless documentation

  begin
    yaml = YAML::load documentation[1]
    keywords << yaml['module']

    yaml['options'].to_a.each do |option_name, option|
      keywords << option_name

      if option['choices'] == 'BOOLEANS'
          keywords.concat(['yes', 'no', 'true', 'false'])
      else
        option['choices'].to_a.each do |choice|
          choice = choice.to_s
          next if choice.include? ' '
          next if choice == ''

          keywords << choice
        end
      end
    end
  rescue Psych::SyntaxError => e
    print "An error occurred during scanning #{file}: #{e}."
  end
end

keywords.uniq!.sort!

template = File.read '../company-ansible-keywords.el.erb'
erb = ERB.new(template, nil, '-')

File.write '../company-ansible-keywords.el', erb.result
