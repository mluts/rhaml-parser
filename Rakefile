require 'rake/clean'
require 'rake/testtask'
require 'bundler/gem_tasks'

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
