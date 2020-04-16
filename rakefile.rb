task :default => :test
task :test do
  Dir.glob('./**/test/*.rb').each { |file| require_relative file}
end