require 'test_helper'
$-d = true

class ParserTest < Minitest::Test
  def setup
    $output = []

    callable = Object.new

    {
      on_new_header: proc {
        $output << [:header]
      },

      on_start_inline_text: proc { |input, p|
        $output << [:inline_text, p]
      },

      on_finish_inline_text: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_tag: proc { |input, p|
        $output << [:tag, p]
      },

      on_finish_tag: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_attr_name: proc { |input, p|
        $output << [:attr, p]
      },

      on_finish_attr_name: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_attr_val: proc { |input, p|
        $output.last[2] = p
      },

      on_finish_attr_val: proc { |input, p|
        $output.last[2] = input[$output.last[2]..p]
      },

      on_start_filter: proc { |input, p|
        $output << [:filter, p]
      },

      on_finish_filter: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_text: proc { |input, p|
        $output << [:text, p]
      },

      on_finish_text: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_class: proc { |input, p|
        $output << [:class, p]
      },

      on_finish_class: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_id: proc { |input, p|
        $output << [:id, p]
      },

      on_finish_id: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_id_div: proc { |input, p|
        $output << [:id_div, p]
      },

      on_finish_id_div: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_start_class_div: proc { |input, p|
        $output << [:class_div, p]
      },

      on_finish_class_div: proc { |input, p|
        $output.last[1] = input[$output.last[1]..p]
      },

      on_tab_indent: proc { $output << [:tab] },

      on_space_indent: proc { $output << [:space] },

      on_newline: proc { $output << [:newline] },

      on_element_slash: proc { $output << [:autoindent] },

      on_comment: proc { $output << [:comment] },

      on_silent_code: proc { |input, p|
        $output << [:silent]
      },

    }.each do |mtd, impl|
      callable.singleton_class.send(:define_method, mtd) do |*args|
        impl.call(*args)
      end
    end

    @parser = RHaml::Parser.new(callable)
  end

  {
    "" => [],
    "!!!" => [[:header]],
    "!!! XML" => [[:header], [:inline_text, "XML"]],
    "!!! 1.2.3.4  " => [[:header], [:inline_text, "1.2.3.4  "]],
    "%a" => [[:tag, "a"]],
    "%div" => [[:tag, "div"]],
    "!!! XML\n%a" => [[:header], [:inline_text, "XML"], [:newline], [:tag, "a"]],
    "%a\n%b" => [[:tag, "a"], [:newline], [:tag, "b"]],
    "%a\n%b\n" => [[:tag, "a"], [:newline], [:tag, "b"], [:newline]],
    "%a\n  %b" => [[:tag, "a"], [:newline], [:space], [:space], [:tag, "b"]],
    "%a\n\t\t\t%b" => [[:tag, "a"], [:newline], [:tab], [:tab], [:tab], [:tag, "b"]],
    "%a " => [[:tag, "a"]],
    "%a hello world" => [[:tag, "a"], [:inline_text, "hello world"]],
    "%a(a=b)" => [[:tag, "a"], [:attr, "a", "b"]],
    "%a(  a = b )" => [[:tag, "a"], [:attr, "a", "b"]],
    "%a(a=b)\n%b(c=d e= f d \n\r = z)" => [[:tag, "a"],
                                           [:attr, "a", "b"],
                                           [:newline],
                                           [:tag, "b"],
                                           [:attr, "c", "d"],
                                           [:attr, "e", "f"],
                                           [:attr, "d", "z"]],
    "%a{ :a => 'b'}" => [[:tag, "a"], [:attr, "a", "'b'"]],
    "%a{ a: 'b'}" => [[:tag, "a"], [:attr, "a", "'b'"]],
    ":css" => [[:filter, 'css']],
    "asdasd" => [[:text, "asdasd"]],
    ".the-class:" => [[:class_div, "the-class:"]],
    ".the-class: some-text" => [[:class_div, "the-class:"], [:inline_text, "some-text"]],
    "%a.b.c#d#e" => [[:tag, "a"], [:class, "b"], [:class, "c"], [:id, "d"], [:id, "e"]],
    ".a#b" => [[:class_div, 'a'], [:id ,'b']],
    ".a#b(a=b)" => [[:class_div, 'a'], [:id ,'b'], [:attr, 'a', 'b']],
    ".a#b(a=b) abcde" => [[:class_div, 'a'], [:id ,'b'], [:attr, 'a', 'b'], [:inline_text, 'abcde']],
    '%div{ "a" => "b" }' => [[:tag, 'div'], [:attr, '"a"', '"b"']],
    "%a/" => [[:tag, 'a'], [:autoindent]],
    '%a(checked=checked)' => [[:tag, 'a'], [:attr, 'checked', 'checked']],
    '%a{ "checked"  => "checked" }' => [[:tag, 'a'], [:attr, '"checked"', '"checked"']],
    "%a(aa=aa bb=bb)" => [[:tag, 'a'], [:attr, 'aa', 'aa'], [:attr, 'bb', 'bb']],
    '/ comment' => [[:comment], [:inline_text, 'comment']],
    "%a\n  / comment" => [[:tag, 'a'], [:newline], [:space], [:space], [:comment], [:inline_text, 'comment']],
    '%a(b)' => [[:tag, 'a'], [:attr, 'b']],
    '- abc #' => [[:silent], [:inline_text, 'abc #']]


  }.each do |example, result|
      define_method("test_spec: #{example.inspect} should generate #{result.inspect}") do
        @parser.parse(example)
        assert_equal result, $output
      end
    end
end
