
# line 1 "lib/rhaml/parser.rl"

# line 59 "lib/rhaml/parser.rl"


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
	23, 1, 24, 1, 25, 1, 26, 1, 
	29, 2, 2, 23, 2, 2, 24, 2, 
	2, 27, 2, 2, 28, 2, 4, 24, 
	2, 8, 29, 2, 10, 29, 2, 12, 
	24, 2, 14, 24, 2, 16, 23, 2, 
	16, 24, 2, 16, 27, 2, 16, 28, 
	2, 18, 23, 2, 18, 24, 2, 18, 
	27, 2, 18, 28, 2, 20, 24, 2, 
	20, 27, 2, 20, 28, 2, 22, 24, 
	2, 22, 27, 2, 22, 28
]

class << self
	attr_accessor :_rhaml_parser_key_offsets
	private :_rhaml_parser_key_offsets, :_rhaml_parser_key_offsets=
end
self._rhaml_parser_key_offsets = [
	0, 0, 1, 2, 11, 12, 13, 17, 
	18, 19, 27, 43, 51, 67, 75, 91, 
	99, 115, 123, 139, 144, 152, 168, 176, 
	192, 198, 208, 219, 232, 245, 256, 257, 
	261, 273, 285, 286, 298, 299, 303, 307, 
	308, 319, 320, 325, 330, 343, 344, 353, 
	354, 360, 372, 381, 381
]

class << self
	attr_accessor :_rhaml_parser_trans_keys
	private :_rhaml_parser_trans_keys, :_rhaml_parser_trans_keys=
end
self._rhaml_parser_trans_keys = [
	10, 10, 9, 32, 33, 35, 37, 45, 
	46, 47, 58, 33, 33, 10, 32, 9, 
	13, 10, 10, 45, 95, 48, 58, 65, 
	90, 97, 122, 10, 32, 35, 40, 45, 
	46, 95, 123, 9, 13, 48, 58, 65, 
	90, 97, 122, 45, 95, 48, 58, 65, 
	90, 97, 122, 10, 32, 35, 40, 45, 
	46, 95, 123, 9, 13, 48, 58, 65, 
	90, 97, 122, 45, 95, 48, 58, 65, 
	90, 97, 122, 10, 32, 35, 40, 45, 
	46, 95, 123, 9, 13, 48, 58, 65, 
	90, 97, 122, 45, 95, 48, 58, 65, 
	90, 97, 122, 10, 32, 35, 40, 46, 
	47, 95, 123, 9, 13, 45, 58, 65, 
	90, 97, 122, 45, 95, 48, 58, 65, 
	90, 97, 122, 10, 32, 35, 40, 46, 
	47, 95, 123, 9, 13, 45, 58, 65, 
	90, 97, 122, 10, 32, 47, 9, 13, 
	45, 95, 48, 58, 65, 90, 97, 122, 
	10, 32, 35, 40, 46, 47, 95, 123, 
	9, 13, 45, 58, 65, 90, 97, 122, 
	45, 95, 48, 58, 65, 90, 97, 122, 
	10, 32, 35, 40, 45, 46, 95, 123, 
	9, 13, 48, 58, 65, 90, 97, 122, 
	48, 57, 65, 90, 97, 122, 10, 32, 
	9, 13, 48, 57, 65, 90, 97, 122, 
	32, 45, 95, 9, 13, 48, 58, 65, 
	90, 97, 122, 32, 41, 45, 61, 95, 
	9, 13, 48, 58, 65, 90, 97, 122, 
	32, 41, 45, 61, 95, 9, 13, 48, 
	58, 65, 90, 97, 122, 32, 34, 36, 
	39, 95, 9, 13, 65, 90, 97, 122, 
	34, 32, 41, 9, 13, 32, 41, 45, 
	95, 9, 13, 48, 58, 65, 90, 97, 
	122, 32, 36, 41, 95, 9, 13, 48, 
	57, 65, 90, 97, 122, 39, 32, 34, 
	36, 39, 58, 95, 9, 13, 65, 90, 
	97, 122, 34, 32, 61, 9, 13, 32, 
	61, 9, 13, 62, 32, 34, 36, 39, 
	95, 9, 13, 65, 90, 97, 122, 34, 
	32, 44, 125, 9, 13, 32, 44, 125, 
	9, 13, 32, 36, 44, 95, 125, 9, 
	13, 48, 57, 65, 90, 97, 122, 39, 
	36, 58, 95, 48, 57, 65, 90, 97, 
	122, 39, 36, 95, 65, 90, 97, 122, 
	32, 36, 61, 95, 9, 13, 48, 57, 
	65, 90, 97, 122, 9, 32, 33, 35, 
	37, 45, 46, 47, 58, 0
]

class << self
	attr_accessor :_rhaml_parser_single_lengths
	private :_rhaml_parser_single_lengths, :_rhaml_parser_single_lengths=
end
self._rhaml_parser_single_lengths = [
	0, 1, 1, 9, 1, 1, 2, 1, 
	1, 2, 8, 2, 8, 2, 8, 2, 
	8, 2, 8, 3, 2, 8, 2, 8, 
	0, 2, 3, 5, 5, 5, 1, 2, 
	4, 4, 1, 6, 1, 2, 2, 1, 
	5, 1, 3, 3, 5, 1, 3, 1, 
	2, 4, 9, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_range_lengths
	private :_rhaml_parser_range_lengths, :_rhaml_parser_range_lengths=
end
self._rhaml_parser_range_lengths = [
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 3, 4, 3, 4, 3, 4, 3, 
	4, 3, 4, 1, 3, 4, 3, 4, 
	3, 4, 4, 4, 4, 3, 0, 1, 
	4, 4, 0, 3, 0, 1, 1, 0, 
	3, 0, 1, 1, 4, 0, 3, 0, 
	2, 4, 0, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_index_offsets
	private :_rhaml_parser_index_offsets, :_rhaml_parser_index_offsets=
end
self._rhaml_parser_index_offsets = [
	0, 0, 2, 4, 14, 16, 18, 22, 
	24, 26, 32, 45, 51, 64, 70, 83, 
	89, 102, 108, 121, 126, 132, 145, 151, 
	164, 168, 175, 183, 193, 203, 212, 214, 
	218, 227, 236, 238, 248, 250, 254, 258, 
	260, 269, 271, 276, 281, 291, 293, 300, 
	302, 307, 316, 326, 327
]

class << self
	attr_accessor :_rhaml_parser_trans_targs
	private :_rhaml_parser_trans_targs, :_rhaml_parser_trans_targs=
end
self._rhaml_parser_trans_targs = [
	0, 2, 50, 2, 3, 3, 4, 9, 
	15, 6, 22, 6, 24, 1, 5, 0, 
	6, 0, 50, 7, 7, 0, 0, 8, 
	50, 8, 10, 10, 10, 10, 10, 0, 
	50, 7, 11, 6, 10, 13, 10, 6, 
	7, 10, 10, 10, 0, 12, 12, 12, 
	12, 12, 0, 50, 7, 11, 6, 12, 
	13, 12, 6, 7, 12, 12, 12, 0, 
	14, 14, 14, 14, 14, 0, 50, 7, 
	11, 6, 14, 13, 14, 6, 7, 14, 
	14, 14, 0, 16, 16, 16, 16, 16, 
	0, 50, 7, 17, 19, 20, 6, 16, 
	19, 7, 16, 16, 16, 0, 18, 18, 
	18, 18, 18, 0, 50, 7, 17, 19, 
	20, 6, 18, 19, 7, 18, 18, 18, 
	0, 50, 7, 6, 7, 0, 21, 21, 
	21, 21, 21, 0, 50, 7, 17, 19, 
	20, 6, 21, 19, 7, 21, 21, 21, 
	0, 23, 23, 23, 23, 23, 0, 50, 
	7, 11, 6, 23, 13, 23, 6, 7, 
	23, 23, 23, 0, 25, 25, 25, 0, 
	50, 7, 7, 25, 25, 25, 0, 26, 
	27, 27, 26, 27, 27, 27, 0, 28, 
	51, 27, 29, 27, 28, 27, 27, 27, 
	0, 28, 51, 27, 29, 27, 28, 27, 
	27, 27, 0, 29, 30, 33, 34, 33, 
	29, 33, 33, 0, 31, 30, 32, 51, 
	32, 0, 32, 51, 27, 27, 32, 27, 
	27, 27, 0, 32, 33, 51, 33, 32, 
	33, 33, 33, 0, 31, 34, 35, 36, 
	46, 47, 48, 46, 35, 46, 46, 0, 
	37, 36, 38, 39, 38, 0, 38, 39, 
	38, 0, 40, 0, 40, 41, 44, 45, 
	44, 40, 44, 44, 0, 42, 41, 43, 
	35, 52, 43, 0, 43, 35, 52, 43, 
	0, 43, 44, 35, 44, 52, 43, 44, 
	44, 44, 0, 42, 45, 46, 40, 46, 
	46, 46, 46, 0, 37, 47, 49, 49, 
	49, 49, 0, 38, 49, 39, 49, 38, 
	49, 49, 49, 0, 3, 3, 4, 9, 
	15, 6, 22, 6, 24, 1, 0, 0, 
	0
]

class << self
	attr_accessor :_rhaml_parser_trans_actions
	private :_rhaml_parser_trans_actions, :_rhaml_parser_trans_actions=
end
self._rhaml_parser_trans_actions = [
	0, 0, 81, 0, 11, 13, 1, 0, 
	0, 53, 0, 51, 0, 27, 0, 0, 
	0, 0, 49, 0, 0, 0, 0, 7, 
	69, 0, 43, 43, 43, 43, 43, 0, 
	117, 45, 45, 120, 0, 45, 0, 123, 
	45, 0, 0, 0, 0, 35, 35, 35, 
	35, 35, 0, 99, 37, 37, 102, 0, 
	37, 0, 105, 37, 0, 0, 0, 0, 
	31, 31, 31, 31, 31, 0, 87, 33, 
	33, 90, 0, 33, 0, 93, 33, 0, 
	0, 0, 0, 3, 3, 3, 3, 3, 
	0, 60, 5, 5, 63, 5, 57, 0, 
	66, 5, 0, 0, 0, 0, 35, 35, 
	35, 35, 35, 0, 99, 37, 37, 102, 
	37, 96, 0, 105, 37, 0, 0, 0, 
	0, 49, 0, 47, 0, 0, 31, 31, 
	31, 31, 31, 0, 87, 33, 33, 90, 
	33, 84, 0, 93, 33, 0, 0, 0, 
	0, 39, 39, 39, 39, 39, 0, 108, 
	41, 41, 111, 0, 41, 0, 114, 41, 
	0, 0, 0, 0, 23, 23, 23, 0, 
	78, 25, 25, 0, 0, 0, 0, 0, 
	15, 15, 0, 15, 15, 15, 0, 17, 
	72, 0, 17, 0, 17, 0, 0, 0, 
	0, 0, 55, 15, 0, 15, 0, 15, 
	15, 15, 0, 0, 19, 19, 19, 19, 
	0, 19, 19, 0, 0, 0, 21, 75, 
	21, 0, 0, 55, 15, 15, 0, 15, 
	15, 15, 0, 21, 0, 75, 0, 21, 
	0, 0, 0, 0, 0, 0, 0, 15, 
	15, 15, 0, 15, 0, 15, 15, 0, 
	0, 0, 17, 17, 17, 0, 0, 0, 
	0, 0, 0, 0, 0, 19, 19, 19, 
	19, 0, 19, 19, 0, 0, 0, 21, 
	21, 75, 21, 0, 0, 0, 55, 0, 
	0, 21, 0, 21, 0, 75, 21, 0, 
	0, 0, 0, 0, 0, 0, 17, 0, 
	0, 0, 0, 0, 0, 0, 15, 15, 
	15, 15, 0, 17, 0, 17, 0, 17, 
	0, 0, 0, 0, 11, 13, 1, 0, 
	0, 53, 0, 51, 0, 27, 0, 0, 
	0
]

class << self
	attr_accessor :_rhaml_parser_eof_actions
	private :_rhaml_parser_eof_actions, :_rhaml_parser_eof_actions=
end
self._rhaml_parser_eof_actions = [
	0, 0, 29, 0, 0, 0, 0, 0, 
	9, 0, 45, 0, 37, 0, 33, 0, 
	5, 0, 37, 0, 0, 33, 0, 41, 
	0, 25, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0
]

class << self
	attr_accessor :rhaml_parser_start
end
self.rhaml_parser_start = 50;
class << self
	attr_accessor :rhaml_parser_first_final
end
self.rhaml_parser_first_final = 50;
class << self
	attr_accessor :rhaml_parser_error
end
self.rhaml_parser_error = 0;

class << self
	attr_accessor :rhaml_parser_en_html_attrs
end
self.rhaml_parser_en_html_attrs = 26;
class << self
	attr_accessor :rhaml_parser_en_ruby_attrs
end
self.rhaml_parser_en_ruby_attrs = 35;
class << self
	attr_accessor :rhaml_parser_en_main
end
self.rhaml_parser_en_main = 50;


# line 306 "lib/rhaml/parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = rhaml_parser_start
	top = 0
end

# line 314 "lib/rhaml/parser.rb"
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
 __call(:on_finish_attr_val, data, p-1) 		end
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
# line 50 "lib/rhaml/parser.rl"
		begin
 __call(:on_element_slash, data, p) 		end
when 24 then
# line 52 "lib/rhaml/parser.rl"
		begin
 __call(:on_newline, data, p) 		end
when 25 then
# line 54 "lib/rhaml/parser.rl"
		begin
 __call(:on_comment, data, p) 		end
when 26 then
# line 56 "lib/rhaml/parser.rl"
		begin
 __call(:on_silent_code, data, p) 		end
when 27 then
# line 4 "lib/rhaml/parser_common.rl"
		begin
 	begin
		stack[top] = cs
		top+= 1
		cs = 26
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
when 28 then
# line 5 "lib/rhaml/parser_common.rl"
		begin
 	begin
		stack[top] = cs
		top+= 1
		cs = 35
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
when 29 then
# line 6 "lib/rhaml/parser_common.rl"
		begin
 	begin
		top -= 1
		cs = stack[top]
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 537 "lib/rhaml/parser.rb"
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
# line 597 "lib/rhaml/parser.rb"
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

# line 88 "lib/rhaml/parser.rl"

      
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
      puts "#{mtd.inspect} #{p.inspect} #{input[p].inspect}" if $-d
      if @callable.respond_to?(mtd)
        @callable.send(mtd, input, p)
      else
        warn "No callback for #{mtd.inspect}"
      end
    end
  end
end
