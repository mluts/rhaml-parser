%%{
  machine rhaml_parser;

  action new_header { __call(:on_new_header, data, fpc) }

  action start_tag { __call(:on_start_tag, data, fpc) }

  action finish_tag { __call(:on_finish_tag, data, fpc == eof ? fpc : fpc-1) }

  action start_inline_text { __call(:on_start_inline_text, data, fpc) }

  action finish_inline_text { __call(:on_finish_inline_text, data, fpc == eof ? fpc : fpc-1) }

  action tab_indent { __call(:on_tab_indent, data, fpc) }

  action space_indent { __call(:on_space_indent, data, fpc) }

  action start_attr_name { __call(:on_start_attr_name, data, fpc) }

  action finish_attr_name { __call(:on_finish_attr_name, data, fpc-1) }

  action start_attr_val { __call(:on_start_attr_val, data, fpc) }

  action finish_attr_val { __call(:on_finish_attr_val, data, fpc) }

  action start_filter { __call(:on_start_filter, data, fpc) }

  action finish_filter { __call(:on_finish_filter, data, fpc) }

  action start_text { __call(:on_start_text, data, fpc) }

  action finish_text { __call(:on_finish_text, data, fpc) }

  action start_class { __call(:on_start_class, data, fpc) }

  action finish_class { __call(:on_finish_class, data, fpc == eof ? fpc : fpc-1) }

  action start_id { __call(:on_start_id, data, fpc) }

  action finish_id { __call(:on_finish_id, data, fpc == eof ? fpc : fpc-1) }

  action start_class_div { __call(:on_start_class_div, data, fpc) }

  action finish_class_div { __call(:on_finish_class_div, data, fpc == eof ? fpc : fpc-1) }

  action start_id_div { __call(:on_start_id_div, data, fpc) }

  action finish_id_div { __call(:on_finish_id_div, data, fpc == eof ? fpc : fpc-1) }

  action element_slash { __call(:on_element_slash, data, fpc) }

  action newline { __call(:on_newline, data, fpc) }

  include rhaml_common "parser_common.rl";
}%%

module RHaml
  class Parser
    class Error < StandardError
      def initialize(input, p, msg = nil)
        @input = input
        @p = p
        super "SyntaxError on #{p} #{msg && "(#{msg})"}"
      end
    end

    def initialize(callable)
      @callable = callable
    end

    def parse(input)
      cs = 0
      data = input
      p = 0
      pe = input.length
      top = 0
      stack = []
      eof = pe

      %%{
        write data;
        write init;
        write exec;
      }%%
      
      if cs == rhaml_parser_error
        raise self.class::Error.new(input, p, "unexpected char #{data[p].inspect}")
      #elsif cs < rhaml_parser_first_final
      #  raise self.class::Error.new(input, p, "eof")
      end

      nil
    rescue => ex
      raise self.class::Error.new(input, p, "#{ex.class}: #{ex.message}")
    end

    def __call(mtd, input, p)
      puts "#{mtd.inspect} #{p.inspect}" if $-d
      if @callable.respond_to?(mtd)
        @callable.send(mtd, input, p)
      else
        warn "No callback for #{mtd.inspect}"
      end
    end
  end
end
