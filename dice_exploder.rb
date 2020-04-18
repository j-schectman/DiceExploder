files = Dir[File.join(File.dirname(__FILE__), 'src', '**', '*.rb')]
puts files
files.each do |f|
  require File.expand_path(f)
end