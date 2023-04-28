# frozen_string_literal: true

require 'json'

ALIASES_FILENAME = 'dumb_aliases.txt'
COMMAND_COUNTS_FILENAME = 'command_counts.json'
HISTORY_FILE = ARGV[0] == 'bash' ? '.bash_history' : '.zsh_history'

root_dir = __dir__.gsub('dumb-aliases', '')
shell_history = File.open("#{root_dir}#{HISTORY_FILE}")

# remove extra fluff
commands = shell_history.readlines.map do |line|
  line = line.chomp
  line.split(';').last
end

# get counts for each command
command_counts = Hash.new(0)
commands.each { |command| command_counts[command] += 1 }

# sort commands and remove those infrequently used
command_counts = command_counts.filter { |_, freq| freq > 4 }.sort_by { |_, freq| freq }.reverse.to_h

# generate alias file
File.open(ALIASES_FILENAME, 'w') do |alias_file|
  command_counts.each do |command, _|
    next unless command

    first_letters = command.split(/[^a-zA-Z\d:]/).map { |word| word[0] }
    next unless first_letters.length > 1 && first_letters.length < 5 # aliases should be short but not too short

    alias_file.puts "alias #{first_letters.join}=\"#{command}\""
  end
end

# generate frequency file
File.write(COMMAND_COUNTS_FILENAME, JSON.pretty_generate(command_counts))
