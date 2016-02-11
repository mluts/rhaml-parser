require 'test_helper'

class ParserTest < Minitest::Test
  def setup
    @output = []

    @parser = RHaml::Parser.new(
      on_new_header: proc {
        puts "on_new_header"
        @output << [:header]
      },

      on_start_header_type: proc { |input, p|
        puts "on_start_header_type"
        @output.last << p
      },

      on_finish_header_type: proc { |input, p|
        puts "on_finish_header_type"
        @output.last[1] = input[@output.last[1]..p]
      }
    )
  end

  {

    "!!!" => [[:header]],

    "!!! XML" => [[:header, "XML"]]

  }.each do |example, result|
      define_method("test_spec: #{example.inspect} should generate #{result.inspect}") do
        @parser.parse(example)
        assert_equal result, @output
      end
    end
end
