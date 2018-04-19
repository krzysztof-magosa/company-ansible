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

          # in some DOCUMENTATION sections choice might be double
          # quoted, which does not get interpreted by Ruby's YAML, but
          # is common in python. In the final generated list these
          # double quotes break elisp.
          if choice.start_with? '["' and choice.end_with? '"]'
            choice.gsub(/\A\[|]\Z/, '').split(',').each do |choice_quote|
              keywords << choice_quote.gsub(/\A"|"\Z/, '')
            end
          else
            # normally, add directly
            keywords << choice
          end
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
