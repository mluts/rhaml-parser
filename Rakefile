require 'rake/clean'
require 'rake/testtask'

RAGEL = 'ragel -R'
CLEAN << FileList['lib/rhaml/parser.rb', 'parser.dot', 'parser.png'].select { |f| File.exists?(f) }

file 'lib/rhaml/parser.rb' => %w(lib/rhaml/parser.rl lib/rhaml/parser_common.rl) do |t|
  sh "#{RAGEL} -o #{t.name} #{t.prerequisites.first}"
end

task 'parser.dot' => %w(lib/rhaml/parser.rl lib/rhaml/parser_common.rl) do |t|
  cmd = [RAGEL]
  cmd.push '-V', '-p'
  cmd.push '-o', t.name
  cmd.push '-M', ENV['MACHINE'] if ENV['MACHINE']
  cmd.push t.prerequisites.first
  sh cmd.join(' ')
end

file 'parser.png' => 'parser.dot' do |t|
  sh "dot -Tpng #{t.prerequisites.first} > #{t.name}"
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task compile: %w(lib/rhaml/parser.rb)

task draw: %w(parser.png) do |t|
  sh "feh #{t.prerequisites.first} &"
end

task default: [:compile, :test]

## Release task

VERSION_FILE = './lib/rhaml/parser/version.rb'
require VERSION_FILE

def die(msg)
  puts msg
  exit 1
end

def ask(msg, default = nil)
  print "%s (Default: %s): " % [msg, default ? default : "<empty>"]
  value = $stdin.gets.strip
  value.empty? ? default : value
end

def ask_yn?(msg)
  val = ask(msg.to_s + " (y/n)", "n")
  val[0] == 'y' ? true : false
end

def ask_sh(cmd)
  sh(cmd) if ask_yn?(cmd)
end

def release(version)
  die("version can't be empty") if version.nil? || version.to_s.empty?
  sh %Q(sed -i 's/VERSION.\\+$/VERSION = "#{version}"/' #{VERSION_FILE})
  sh "git commit --message 'Bump version to #{version}' #{VERSION_FILE}"

  sh "git tag v#{version}"
  if ask_yn?("Push commit and tags?")
    sh "git push origin HEAD v#{version}"
  else
    cleanup(version)
  end
end

def cleanup(version)
  puts
  puts "Making cleanup..."
  puts
  sh "git tag -d v#{version}"
  sh "git reset HEAD~1"
  sh "git checkout #{VERSION_FILE}"
  puts
  puts "Cleanup finished!"
  puts
end

desc "Update version.rb, make a tag and push"
task :release do
  version = nil
  trap(:INT) { cleanup(version) if version; die("Interrupted! Exiting...") }
  default_version = RHaml::Parser::VERSION.sub(/\d+$/) { |n| n.to_i + 1 }
  version = ask "Please, specify release version", default_version
  release(version)
end
