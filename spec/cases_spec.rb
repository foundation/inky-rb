require 'spec_helper'
require 'json'

INKY_VERSION_REQUIRED = Inky::NODE_VERSION

def npm_packages
  JSON.parse(`npm list -g --depth=1 --json=true`)
rescue SystemCallError, JSON::ParserError
  puts <<-ERR
    npm not detected, skipping comparison tests.
  ERR
  nil
end

def inky_cli_ok?
  return unless packages = npm_packages

  version = packages['dependencies']['inky-cli']['dependencies']['inky']['version']
  return true if version >= INKY_VERSION_REQUIRED

  puts "Requires inky version #{INKY_VERSION_REQUIRED}+, currently installed #{version}"
  false
rescue NoMethodError
  puts <<-ERR
    inky-cli not globally installed, skipping comparison tests.
    Install with:
        npm install inky-cli -g
  ERR
  false
end

RSpec.describe "Inky-rb" do
  if inky_cli_ok?
    context "compared to inky-cli" do
      Dir['./spec/cases/*'].each do |path|
        folder = File.basename(path)
        output_path = "./spec/_cases_output/#{File.basename(folder)}"
        sources = "#{path}/*.inky"
        source_paths = Dir[sources]

        context "for #{folder} components" do
          before(:all) do
            shell = source_paths.map { |p| "inky #{p} #{output_path}" }
            `#{shell.join(' && ')}`
          end

          source_paths.each do |filepath|
            file = File.basename(filepath, '.inky')
            content = File.read(filepath)
            exec = content =~ /^<!--\s*(pending|skip)/ ? $1 : :it
            send exec, "provides the same results for #{file}" do
              compare(content, File.read("#{output_path}/#{file}.inky"))
            end
          end
        end
      end
    end
  end
end
