files = Dir[File.join(File.dirname(__FILE__), 'dice_exploder', '**', '*.rb')]
files.each do |f|
  require File.expand_path(f)
end