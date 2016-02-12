require 'rake/clean'
require 'rake/testtask'

RAGEL = 'ragel -R'
CLEAN << FileList['lib/rhaml/parser.rb', 'parser.dot', 'parser.png']

file 'lib/rhaml/parser.rb' => %w(lib/rhaml/parser.rl lib/rhaml/parser_common.rl) do |t|
  sh "#{RAGEL} -o #{t.name} #{t.prerequisites.first}"
end

file 'parser.dot' => %w(lib/rhaml/parser.rl lib/rhaml/parser_common.rl) do |t|
  sh "#{RAGEL} -V -o #{t.name} #{t.prerequisites.first}"
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
  fork do
    exec "feh #{t.prerequisites.first}"
  end
end

task default: [:compile, :test]
