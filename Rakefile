require 'bundler'
require 'pathname'
require 'logger'
require 'fileutils'

Bundler.require

require 'sprockets'
require 'stylus/sprockets'
require 'skim'

ROOT     = Pathname.new File.dirname __FILE__
JS_ROOT  = 'wwm.js'.freeze
CSS_ROOT = 'wwm.css'.freeze

DIST    = ROOT.join 'dist'
BUILD   = ROOT.join 'build'

SPROCKETS = Sprockets::Environment.new(ROOT) do |env|
  env.logger = Logger.new STDOUT
end

Stylus.setup(SPROCKETS)

['src', 'vendor'].each do |dir|
  SPROCKETS.append_path ROOT.join(dir, 'javascripts').to_s
  SPROCKETS.append_path ROOT.join(dir, 'stylesheets').to_s
end

def compile(file)
  file = DIST.join file
  FileUtils.mkdir_p file.dirname
  File.write file, SPROCKETS[file.basename].to_s
end

desc 'Build JS and CSS for development as single files.'
task :build do
  FileUtils.rm_rf BUILD
  dependencies = SPROCKETS[JS_ROOT].dependencies
  dependencies.each do |asset|
    FileUtils.mkdir_p BUILD.join File.dirname asset.logical_path
    File.write BUILD.join(asset.logical_path), asset.body
  end
  data = ''
  dependencies.each do |asset|
    data << <<SCRIPT
var script = document.createElement('script');
script.src = 'build/#{asset.logical_path}';
document.write(script.outerHTML);
SCRIPT
  end
  File.write BUILD.join('build.js'), data
  SPROCKETS[CSS_ROOT].write_to BUILD.join CSS_ROOT
end

desc 'Compile and minimize JS and CSS for distribution.'
task :compile do
  FileUtils.rm_rf DIST
  SPROCKETS.js_compressor = :uglifier
  SPROCKETS.css_compressor = :sass
  SPROCKETS[JS_ROOT].write_to DIST.join JS_ROOT
  SPROCKETS[CSS_ROOT].write_to DIST.join CSS_ROOT
end
