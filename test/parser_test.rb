require 'test_helper'
$-d = true

class ParserTest < Minitest::Test
  def setup
    @output = []

    callbacks = {
      on_new_header: proc {
        @output << [:header]
      },

      on_start_inline_text: proc { |input, p|
        @output << [:inline_text, p]
      },

      on_finish_inline_text: proc { |input, p|
        @output.last[1] = input[@output.last[1]..p]
      },

      on_start_tag: proc { |input, p|
        @output << [:tag, p]
      },

      on_finish_tag: proc { |input, p|
        @output.last[1] = input[@output.last[1]..p]
      },

      on_tab_indent: proc { @output << [:tab] },

      on_space_indent: proc { @output << [:space] }

    }.inject({}) do |acc, (k, v)|
      acc[k] = proc { |*args| puts k.inspect if $-d; v.call(*args) }
      acc
    end

    @parser = RHaml::Parser.new(callbacks)
  end

  {
    "" => [],
    "!!!" => [[:header]],
    "!!! XML" => [[:header], [:inline_text, "XML"]],
    "!!! 1.2.3.4  " => [[:header], [:inline_text, "1.2.3.4  "]],
    "%a" => [[:tag, "a"]],
    "%div" => [[:tag, "div"]],
    "!!! XML\n%a" => [[:header], [:inline_text, "XML"], [:tag, "a"]],
    "%a\n%b" => [[:tag, "a"], [:tag, "b"]],
    "%a\n%b\n" => [[:tag, "a"], [:tag, "b"]],
    "%a\n  %b" => [[:tag, "a"], [:space], [:space], [:tag, "b"]],
    "%a\n\t\t\t%b" => [[:tag, "a"], [:tab], [:tab], [:tab], [:tag, "b"]],
    "%a " => [[:tag, "a"]],
    "%a hello world" => [[:tag, "a"], [:inline_text, "hello world"]],

  }.each do |example, result|
      define_method("test_spec: #{example.inspect} should generate #{result.inspect}") do
        @parser.parse(example)
        assert_equal result, @output
      end
    end
end
