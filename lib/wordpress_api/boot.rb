# @deprecated

require 'bundler'
Bundler.require

app_dir = File.expand_path(File.dirname(__FILE__))
file_pattern = File.join(app_dir, %w(** *.rb))

Dir.glob(file_pattern).each { |file| require file }