# frozen_string_literal: true

require 'json'

root_dir = __dir__.gsub('dumb-aliases', '')
file = File.open("#{root_dir}.zsh_history")

# remove extra fluff
commands = file.readlines.map do |line|
  line = line.chomp
  line.split(';').last
end

# get counts for each command
command_counts = Hash.new(0)
commands.each { |command| command_counts[command] += 1 }

# sort them and remove infrequently used
command_counts = command_counts.filter { |k,v| v > 4 }.sort_by { |k,v| v }.reverse.to_h

# generate alias file
File.open('dumb_aliases.txt', 'w') do |file|
  command_counts.each do |command, _freq|
    next unless command
    first_letters = command.split(/[^a-zA-Z\d:]/).map { |word| word[0] }
    next unless first_letters.length > 1 && first_letters.length < 5 # aliases should be short but not tooo short
    dumb_alias = first_letters.join
    file.puts "alias #{dumb_alias}=\"#{command}\""
  end
end

# generate frequency file
File.write('command_counts.json', JSON.pretty_generate(command_counts))
