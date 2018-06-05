require 'readline'

Pry.config.editor = 'vim'
Pry.config.prompt = Pry::NAV_PROMPT

# === for pry-byebug ===
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  # Pry.commands.alias_command 'f', 'finish'
end

# === Custom Prompt ===
# This prompt shows the ruby version (useful for rvm)
Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

# === Listing config ===
# Better colors - by default the headings for methods are too
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme
# for your terminal
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# === Plugins ===
# awesome_print gem: great syntax colorized printing
# look at ~/.aprc for more settings for awesome_print
begin
  require 'awesome_print'
  # The following line enables awesome_print for all pry output,
  # and it also enables paging
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }

  # If you want awesome_print without automatic pagination, use the line below
  # Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError
  puts 'gem install awesome_print  # <-- highly recommended'
end

begin
  require 'rb-readline'
  if defined?(RbReadline)
    def RbReadline.rl_reverse_search_history(sign, key)
      rl_insert_text `cat ~/.pry_history | fzf --tac | tr '\n' ' '`
    end
  end
rescue LoadError
  puts 'gem install rb-readline'
end

# === Custom Commands ==
default_command_set = Pry::CommandSet.new do
  command 'copy', 'Copy argument to the clipboard' do |str|
    IO.popen('pbcopy', 'w') { |f| f << str.to_s }
  end

  command 'caller_method' do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth + 1).first
      file   = Regexp.last_match[1]
      line   = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end
end
Pry.config.commands.import default_command_set

Signal.trap('SIGINT') { raise Interrupt }
