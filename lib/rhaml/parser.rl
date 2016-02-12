%%{
  machine rhaml_parser;

  action new_header { @callbacks[:on_new_header].call(data, fpc) }

  action start_tag { @callbacks[:on_start_tag].call(data, fpc) }

  action finish_tag { @callbacks[:on_finish_tag].call(data, fpc == eof ? fpc : fpc-1) }

  action start_inline_text { @callbacks[:on_start_inline_text].call(data, fpc) }

  action finish_inline_text { @callbacks[:on_finish_inline_text].call(data, fpc == eof ? fpc : fpc-1) }

  action tab_indent { @callbacks[:on_tab_indent].call(data, fpc) }

  action space_indent { @callbacks[:on_space_indent].call(data, fpc) }

  action start_attr_name { @callbacks[:on_start_attr_name].call(data, fpc) }

  action finish_attr_name { @callbacks[:on_finish_attr_name].call(data, fpc-1) }

  action start_attr_val { @callbacks[:on_start_attr_val].call(data, fpc) }

  action finish_attr_val { @callbacks[:on_finish_attr_val].call(data, fpc) }

  action start_filter { @callbacks[:on_start_filter].call(data, fpc) }

  action finish_filter { @callbacks[:on_finish_filter].call(data, fpc) }

  action start_text { @callbacks[:on_start_text].call(data, fpc) }

  action finish_text { @callbacks[:on_finish_text].call(data, fpc) }

  action start_class { @callbacks[:on_start_class].call(data, fpc) }

  action finish_class { @callbacks[:on_finish_class].call(data, fpc == eof ? fpc : fpc-1) }

  action start_id { @callbacks[:on_start_id].call(data, fpc) }

  action finish_id { @callbacks[:on_finish_id].call(data, fpc == eof ? fpc : fpc-1) }

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
