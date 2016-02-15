
# line 1 "lib/rhaml/parser.rl"

# line 51 "lib/rhaml/parser.rl"


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

      
# line 32 "lib/rhaml/parser.rb"
class << self
	attr_accessor :_rhaml_parser_actions
	private :_rhaml_parser_actions, :_rhaml_parser_actions=
end
self._rhaml_parser_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 14, 1, 
	15, 1, 16, 1, 17, 1, 18, 1, 
	19, 1, 20, 1, 21, 1, 22, 1, 
	25, 2, 2, 23, 2, 2, 24, 2, 
	8, 9, 2, 9, 10, 2, 16, 23, 
	2, 16, 24, 2, 18, 23, 2, 18, 
	24, 3, 8, 9, 10
]

class << self
	attr_accessor :_rhaml_parser_key_offsets
	private :_rhaml_parser_key_offsets, :_rhaml_parser_key_offsets=
end
self._rhaml_parser_key_offsets = [
	0, 0, 1, 2, 9, 10, 11, 15, 
	16, 17, 25, 37, 45, 61, 69, 85, 
	93, 109, 117, 129, 135, 145, 156, 168, 
	172, 183, 184, 188, 200, 212, 213, 225, 
	226, 237, 248, 249, 254, 267, 268, 277, 
	278, 284, 296, 300, 301, 308, 308
]

class << self
	attr_accessor :_rhaml_parser_trans_keys
	private :_rhaml_parser_trans_keys, :_rhaml_parser_trans_keys=
end
self._rhaml_parser_trans_keys = [
	10, 10, 9, 32, 33, 35, 37, 46, 
	58, 33, 33, 10, 32, 9, 13, 10, 
	10, 45, 95, 48, 58, 65, 90, 97, 
	122, 10, 32, 45, 95, 9, 13, 48, 
	58, 65, 90, 97, 122, 45, 95, 48, 
	58, 65, 90, 97, 122, 10, 32, 35, 
	40, 45, 46, 95, 123, 9, 13, 48, 
	58, 65, 90, 97, 122, 45, 95, 48, 
	58, 65, 90, 97, 122, 10, 32, 35, 
	40, 45, 46, 95, 123, 9, 13, 48, 
	58, 65, 90, 97, 122, 45, 95, 48, 
	58, 65, 90, 97, 122, 10, 32, 35, 
	40, 45, 46, 95, 123, 9, 13, 48, 
	58, 65, 90, 97, 122, 45, 95, 48, 
	58, 65, 90, 97, 122, 10, 32, 45, 
	95, 9, 13, 48, 58, 65, 90, 97, 
	122, 48, 57, 65, 90, 97, 122, 10, 
	32, 9, 13, 48, 57, 65, 90, 97, 
	122, 32, 45, 95, 9, 13, 48, 58, 
	65, 90, 97, 122, 32, 45, 61, 95, 
	9, 13, 48, 58, 65, 90, 97, 122, 
	32, 61, 9, 13, 32, 34, 36, 39, 
	95, 9, 13, 65, 90, 97, 122, 34, 
	32, 41, 9, 13, 32, 41, 45, 95, 
	9, 13, 48, 58, 65, 90, 97, 122, 
	32, 36, 41, 95, 9, 13, 48, 57, 
	65, 90, 97, 122, 39, 32, 34, 36, 
	39, 58, 95, 9, 13, 65, 90, 97, 
	122, 34, 32, 34, 36, 39, 95, 9, 
	13, 65, 90, 97, 122, 32, 34, 36, 
	39, 95, 9, 13, 65, 90, 97, 122, 
	34, 32, 44, 125, 9, 13, 32, 36, 
	44, 95, 125, 9, 13, 48, 57, 65, 
	90, 97, 122, 39, 36, 58, 95, 48, 
	57, 65, 90, 97, 122, 39, 36, 95, 
	65, 90, 97, 122, 32, 36, 61, 95, 
	9, 13, 48, 57, 65, 90, 97, 122, 
	32, 61, 9, 13, 62, 9, 32, 33, 
	35, 37, 46, 58, 0
]

class << self
	attr_accessor :_rhaml_parser_single_lengths
	private :_rhaml_parser_single_lengths, :_rhaml_parser_single_lengths=
end
self._rhaml_parser_single_lengths = [
	0, 1, 1, 7, 1, 1, 2, 1, 
	1, 2, 4, 2, 8, 2, 8, 2, 
	8, 2, 4, 0, 2, 3, 4, 2, 
	5, 1, 2, 4, 4, 1, 6, 1, 
	5, 5, 1, 3, 5, 1, 3, 1, 
	2, 4, 2, 1, 7, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_range_lengths
	private :_rhaml_parser_range_lengths, :_rhaml_parser_range_lengths=
end
self._rhaml_parser_range_lengths = [
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 3, 4, 3, 4, 3, 4, 3, 
	4, 3, 4, 3, 4, 4, 4, 1, 
	3, 0, 1, 4, 4, 0, 3, 0, 
	3, 3, 0, 1, 4, 0, 3, 0, 
	2, 4, 1, 0, 0, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_index_offsets
	private :_rhaml_parser_index_offsets, :_rhaml_parser_index_offsets=
end
self._rhaml_parser_index_offsets = [
	0, 0, 2, 4, 12, 14, 16, 20, 
	22, 24, 30, 39, 45, 58, 64, 77, 
	83, 96, 102, 111, 115, 122, 130, 139, 
	143, 152, 154, 158, 167, 176, 178, 188, 
	190, 199, 208, 210, 215, 225, 227, 234, 
	236, 241, 250, 254, 256, 264, 265
]

class << self
	attr_accessor :_rhaml_parser_indicies
	private :_rhaml_parser_indicies, :_rhaml_parser_indicies=
end
self._rhaml_parser_indicies = [
	1, 0, 2, 0, 4, 5, 6, 7, 
	8, 9, 10, 3, 11, 1, 12, 1, 
	14, 13, 13, 1, 1, 15, 17, 16, 
	18, 18, 18, 18, 18, 1, 20, 19, 
	21, 21, 19, 21, 21, 21, 1, 22, 
	22, 22, 22, 22, 1, 24, 23, 25, 
	26, 27, 28, 27, 29, 23, 27, 27, 
	27, 1, 30, 30, 30, 30, 30, 1, 
	32, 31, 33, 34, 35, 36, 35, 37, 
	31, 35, 35, 35, 1, 38, 38, 38, 
	38, 38, 1, 40, 39, 41, 42, 43, 
	44, 43, 45, 39, 43, 43, 43, 1, 
	46, 46, 46, 46, 46, 1, 48, 47, 
	49, 49, 47, 49, 49, 49, 1, 50, 
	50, 50, 1, 52, 51, 51, 53, 53, 
	53, 1, 54, 55, 55, 54, 55, 55, 
	55, 1, 56, 57, 58, 57, 56, 57, 
	57, 57, 1, 59, 60, 59, 1, 60, 
	61, 62, 63, 62, 60, 62, 62, 1, 
	65, 64, 66, 67, 66, 1, 66, 67, 
	55, 55, 66, 55, 55, 55, 1, 66, 
	68, 67, 68, 66, 68, 68, 68, 1, 
	65, 69, 70, 71, 72, 73, 74, 72, 
	70, 72, 72, 1, 76, 75, 77, 78, 
	79, 80, 79, 77, 79, 79, 1, 81, 
	82, 83, 84, 83, 81, 83, 83, 1, 
	86, 85, 87, 70, 88, 87, 1, 87, 
	89, 70, 89, 88, 87, 89, 89, 89, 
	1, 86, 90, 91, 77, 91, 91, 91, 
	91, 1, 76, 92, 93, 93, 93, 93, 
	1, 94, 95, 96, 95, 94, 95, 95, 
	95, 1, 97, 98, 97, 1, 81, 1, 
	4, 5, 6, 7, 8, 9, 10, 3, 
	1, 1, 0
]

class << self
	attr_accessor :_rhaml_parser_trans_targs
	private :_rhaml_parser_trans_targs, :_rhaml_parser_trans_targs=
end
self._rhaml_parser_trans_targs = [
	2, 0, 44, 1, 3, 3, 4, 9, 
	11, 17, 19, 5, 6, 7, 44, 8, 
	8, 44, 10, 7, 44, 10, 12, 7, 
	44, 13, 6, 12, 15, 6, 14, 7, 
	44, 13, 6, 14, 15, 6, 16, 7, 
	44, 13, 6, 16, 15, 6, 18, 7, 
	44, 18, 20, 7, 44, 20, 21, 22, 
	23, 22, 24, 23, 24, 25, 28, 29, 
	25, 26, 27, 45, 28, 29, 30, 31, 
	38, 39, 40, 31, 32, 33, 34, 36, 
	37, 33, 34, 36, 37, 34, 35, 35, 
	46, 36, 37, 38, 39, 41, 42, 41, 
	43, 42, 43
]

class << self
	attr_accessor :_rhaml_parser_trans_actions
	private :_rhaml_parser_trans_actions, :_rhaml_parser_trans_actions=
end
self._rhaml_parser_trans_actions = [
	0, 0, 29, 27, 11, 13, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 7, 
	0, 9, 43, 45, 45, 0, 3, 5, 
	5, 5, 49, 0, 5, 52, 35, 37, 
	37, 37, 67, 0, 37, 70, 31, 33, 
	33, 33, 61, 0, 33, 64, 39, 41, 
	41, 0, 23, 25, 25, 0, 0, 15, 
	17, 0, 17, 0, 0, 19, 58, 19, 
	0, 21, 0, 47, 21, 0, 0, 15, 
	15, 15, 0, 0, 0, 17, 55, 73, 
	55, 0, 19, 58, 19, 0, 21, 0, 
	47, 21, 0, 0, 0, 15, 17, 0, 
	17, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_eof_actions
	private :_rhaml_parser_eof_actions, :_rhaml_parser_eof_actions=
end
self._rhaml_parser_eof_actions = [
	0, 0, 29, 0, 0, 0, 0, 0, 
	9, 0, 45, 0, 5, 0, 37, 0, 
	33, 0, 41, 0, 25, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0
]

class << self
	attr_accessor :rhaml_parser_start
end
self.rhaml_parser_start = 44;
class << self
	attr_accessor :rhaml_parser_first_final
end
self.rhaml_parser_first_final = 44;
class << self
	attr_accessor :rhaml_parser_error
end
self.rhaml_parser_error = 0;

class << self
	attr_accessor :rhaml_parser_en_html_attrs
end
self.rhaml_parser_en_html_attrs = 21;
class << self
	attr_accessor :rhaml_parser_en_ruby_attrs
end
self.rhaml_parser_en_ruby_attrs = 30;
class << self
	attr_accessor :rhaml_parser_en_main
end
self.rhaml_parser_en_main = 44;


# line 269 "lib/rhaml/parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = rhaml_parser_start
	top = 0
end

# line 277 "lib/rhaml/parser.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _rhaml_parser_key_offsets[cs]
	_trans = _rhaml_parser_index_offsets[cs]
	_klen = _rhaml_parser_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _rhaml_parser_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _rhaml_parser_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _rhaml_parser_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _rhaml_parser_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _rhaml_parser_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _rhaml_parser_indicies[_trans]
	cs = _rhaml_parser_trans_targs[_trans]
	if _rhaml_parser_trans_actions[_trans] != 0
		_acts = _rhaml_parser_trans_actions[_trans]
		_nacts = _rhaml_parser_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _rhaml_parser_actions[_acts - 1]
when 0 then
# line 4 "lib/rhaml/parser.rl"
		begin
 __call(:on_new_header, data, p) 		end
when 1 then
# line 6 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_tag, data, p) 		end
when 2 then
# line 8 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_tag, data, p == eof ? p : p-1) 		end
when 3 then
# line 10 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_inline_text, data, p) 		end
when 4 then
# line 12 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_inline_text, data, p == eof ? p : p-1) 		end
when 5 then
# line 14 "lib/rhaml/parser.rl"
		begin
 __call(:on_tab_indent, data, p) 		end
when 6 then
# line 16 "lib/rhaml/parser.rl"
		begin
 __call(:on_space_indent, data, p) 		end
when 7 then
# line 18 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_attr_name, data, p) 		end
when 8 then
# line 20 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_attr_name, data, p-1) 		end
when 9 then
# line 22 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_attr_val, data, p) 		end
when 10 then
# line 24 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_attr_val, data, p) 		end
when 11 then
# line 26 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_filter, data, p) 		end
when 12 then
# line 28 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_filter, data, p) 		end
when 13 then
# line 30 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_text, data, p) 		end
when 14 then
# line 32 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_text, data, p) 		end
when 15 then
# line 34 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_class, data, p) 		end
when 16 then
# line 36 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_class, data, p == eof ? p : p-1) 		end
when 17 then
# line 38 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_id, data, p) 		end
when 18 then
# line 40 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_id, data, p == eof ? p : p-1) 		end
when 19 then
# line 42 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_class_div, data, p) 		end
when 20 then
# line 44 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_class_div, data, p == eof ? p : p-1) 		end
when 21 then
# line 46 "lib/rhaml/parser.rl"
		begin
 __call(:on_start_id_div, data, p) 		end
when 22 then
# line 48 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_id_div, data, p == eof ? p : p-1) 		end
when 23 then
# line 31 "lib/rhaml/parser_common.rl"
		begin
 	begin
		stack[top] = cs
		top+= 1
		cs = 21
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
when 24 then
# line 32 "lib/rhaml/parser_common.rl"
		begin
 	begin
		stack[top] = cs
		top+= 1
		cs = 30
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
when 25 then
# line 33 "lib/rhaml/parser_common.rl"
		begin
 	begin
		top -= 1
		cs = stack[top]
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 485 "lib/rhaml/parser.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	__acts = _rhaml_parser_eof_actions[cs]
	__nacts =  _rhaml_parser_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _rhaml_parser_actions[__acts - 1]
when 2 then
# line 8 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_tag, data, p == eof ? p : p-1) 		end
when 4 then
# line 12 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_inline_text, data, p == eof ? p : p-1) 		end
when 12 then
# line 28 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_filter, data, p) 		end
when 14 then
# line 32 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_text, data, p) 		end
when 16 then
# line 36 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_class, data, p == eof ? p : p-1) 		end
when 18 then
# line 40 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_id, data, p == eof ? p : p-1) 		end
when 20 then
# line 44 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_class_div, data, p == eof ? p : p-1) 		end
when 22 then
# line 48 "lib/rhaml/parser.rl"
		begin
 __call(:on_finish_id_div, data, p == eof ? p : p-1) 		end
# line 545 "lib/rhaml/parser.rb"
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 80 "lib/rhaml/parser.rl"

      
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
      if @callable.respond_to?(mtd)
        @callable.send(mtd, input, p)
      else
        warn "No callback for #{mtd.inspect}"
      end
    end
  end
end
