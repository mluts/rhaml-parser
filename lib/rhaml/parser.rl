%%{
  machine rhaml_parser;

  action new_header { @callbacks[:on_new_header].call(data, fpc) }

  action start_header_type { @callbacks[:on_start_header_type].call(data, fpc) }

  action finish_header_type { @callbacks[:on_finish_header_type].call(data, fpc) }

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
        raise self.class::Error.new(input, p, "parser error")
      elsif cs < rhaml_parser_first_final
        raise self.class::Error.new(input, p, "can't start to parse")
      end

      nil
    end
  end
end
