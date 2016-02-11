%%{
  machine rhaml_parser;

  action new_header { @callbacks[:on_new_header].call(data, fpc) }

  action start_tag { @callbacks[:on_start_tag].call(data, fpc) }

  action finish_tag { @callbacks[:on_finish_tag].call(data, fpc == eof ? fpc : fpc-1) }

  action start_inline_text { @callbacks[:on_start_inline_text].call(data, fpc) }

  action finish_inline_text { @callbacks[:on_finish_inline_text].call(data, fpc == eof ? fpc : fpc-1) }

  action tab_indent { @callbacks[:on_tab_indent].call(data, fpc) }

  action space_indent { @callbacks[:on_space_indent].call(data, fpc) }

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

    def initialize(callbacks)
      @callbacks = Hash.new do |h,k|
        h[k] = proc{ puts "Warning! No callback for #{k.inspect}" }
      end

      @callbacks.merge!(callbacks)
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
  end
end
