
# line 1 "lib/rhaml/parser.rl"

# line 55 "lib/rhaml/parser.rl"


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
	23, 1, 24, 1, 27, 2, 2, 23, 
	2, 2, 24, 2, 2, 25, 2, 2, 
	26, 2, 4, 24, 2, 9, 10, 2, 
	12, 24, 2, 14, 24, 2, 16, 23, 
	2, 16, 24, 2, 16, 25, 2, 16, 
	26, 2, 18, 23, 2, 18, 24, 2, 
	18, 25, 2, 18, 26, 2, 20, 24, 
	2, 20, 25, 2, 20, 26, 2, 22, 
	24, 2, 22, 25, 2, 22, 26
]

class << self
	attr_accessor :_rhaml_parser_key_offsets
	private :_rhaml_parser_key_offsets, :_rhaml_parser_key_offsets=
end
self._rhaml_parser_key_offsets = [
	0, 0, 1, 2, 9, 10, 11, 15, 
	16, 17, 25, 41, 49, 65, 73, 89, 
	97, 113, 121, 137, 142, 150, 166, 174, 
	190, 196, 206, 217, 229, 233, 244, 245, 
	249, 261, 273, 274, 286, 287, 291, 295, 
	296, 307, 308, 313, 326, 327, 336, 337, 
	343, 355, 362, 362
]

class << self
	attr_accessor :_rhaml_parser_trans_keys
	private :_rhaml_parser_trans_keys, :_rhaml_parser_trans_keys=
end
self._rhaml_parser_trans_keys = [
	10, 10, 9, 32, 33, 35, 37, 46, 
	58, 33, 33, 10, 32, 9, 13, 10, 
	10, 45, 95, 48, 58, 65, 90, 97, 
	122, 10, 32, 35, 40, 45, 46, 95, 
	123, 9, 13, 48, 58, 65, 90, 97, 
	122, 45, 95, 48, 58, 65, 90, 97, 
	122, 10, 32, 35, 40, 45, 46, 95, 
	123, 9, 13, 48, 58, 65, 90, 97, 
	122, 45, 95, 48, 58, 65, 90, 97, 
	122, 10, 32, 35, 40, 45, 46, 95, 
	123, 9, 13, 48, 58, 65, 90, 97, 
	122, 45, 95, 48, 58, 65, 90, 97, 
	122, 10, 32, 35, 40, 46, 47, 95, 
	123, 9, 13, 45, 58, 65, 90, 97, 
	122, 45, 95, 48, 58, 65, 90, 97, 
	122, 10, 32, 35, 40, 46, 47, 95, 
	123, 9, 13, 45, 58, 65, 90, 97, 
	122, 10, 32, 47, 9, 13, 45, 95, 
	48, 58, 65, 90, 97, 122, 10, 32, 
	35, 40, 46, 47, 95, 123, 9, 13, 
	45, 58, 65, 90, 97, 122, 45, 95, 
	48, 58, 65, 90, 97, 122, 10, 32, 
	35, 40, 45, 46, 95, 123, 9, 13, 
	48, 58, 65, 90, 97, 122, 48, 57, 
	65, 90, 97, 122, 10, 32, 9, 13, 
	48, 57, 65, 90, 97, 122, 32, 45, 
	95, 9, 13, 48, 58, 65, 90, 97, 
	122, 32, 45, 61, 95, 9, 13, 48, 
	58, 65, 90, 97, 122, 32, 61, 9, 
	13, 32, 34, 36, 39, 95, 9, 13, 
	65, 90, 97, 122, 34, 32, 41, 9, 
	13, 32, 41, 45, 95, 9, 13, 48, 
	58, 65, 90, 97, 122, 32, 36, 41, 
	95, 9, 13, 48, 57, 65, 90, 97, 
	122, 39, 32, 34, 36, 39, 58, 95, 
	9, 13, 65, 90, 97, 122, 34, 32, 
	61, 9, 13, 32, 61, 9, 13, 62, 
	32, 34, 36, 39, 95, 9, 13, 65, 
	90, 97, 122, 34, 32, 44, 125, 9, 
	13, 32, 36, 44, 95, 125, 9, 13, 
	48, 57, 65, 90, 97, 122, 39, 36, 
	58, 95, 48, 57, 65, 90, 97, 122, 
	39, 36, 95, 65, 90, 97, 122, 32, 
	36, 61, 95, 9, 13, 48, 57, 65, 
	90, 97, 122, 9, 32, 33, 35, 37, 
	46, 58, 0
]

class << self
	attr_accessor :_rhaml_parser_single_lengths
	private :_rhaml_parser_single_lengths, :_rhaml_parser_single_lengths=
end
self._rhaml_parser_single_lengths = [
	0, 1, 1, 7, 1, 1, 2, 1, 
	1, 2, 8, 2, 8, 2, 8, 2, 
	8, 2, 8, 3, 2, 8, 2, 8, 
	0, 2, 3, 4, 2, 5, 1, 2, 
	4, 4, 1, 6, 1, 2, 2, 1, 
	5, 1, 3, 5, 1, 3, 1, 2, 
	4, 7, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_range_lengths
	private :_rhaml_parser_range_lengths, :_rhaml_parser_range_lengths=
end
self._rhaml_parser_range_lengths = [
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 3, 4, 3, 4, 3, 4, 3, 
	4, 3, 4, 1, 3, 4, 3, 4, 
	3, 4, 4, 4, 1, 3, 0, 1, 
	4, 4, 0, 3, 0, 1, 1, 0, 
	3, 0, 1, 4, 0, 3, 0, 2, 
	4, 0, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_index_offsets
	private :_rhaml_parser_index_offsets, :_rhaml_parser_index_offsets=
end
self._rhaml_parser_index_offsets = [
	0, 0, 2, 4, 12, 14, 16, 20, 
	22, 24, 30, 43, 49, 62, 68, 81, 
	87, 100, 106, 119, 124, 130, 143, 149, 
	162, 166, 173, 181, 190, 194, 203, 205, 
	209, 218, 227, 229, 239, 241, 245, 249, 
	251, 260, 262, 267, 277, 279, 286, 288, 
	293, 302, 310, 311
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
	21, 22, 23, 24, 23, 25, 19, 23, 
	23, 23, 1, 26, 26, 26, 26, 26, 
	1, 28, 27, 29, 30, 31, 32, 31, 
	33, 27, 31, 31, 31, 1, 34, 34, 
	34, 34, 34, 1, 36, 35, 37, 38, 
	39, 40, 39, 41, 35, 39, 39, 39, 
	1, 42, 42, 42, 42, 42, 1, 44, 
	43, 45, 46, 48, 49, 47, 50, 43, 
	47, 47, 47, 1, 51, 51, 51, 51, 
	51, 1, 28, 27, 52, 53, 55, 56, 
	54, 57, 27, 54, 54, 54, 1, 14, 
	13, 58, 13, 1, 59, 59, 59, 59, 
	59, 1, 36, 35, 60, 61, 63, 64, 
	62, 65, 35, 62, 62, 62, 1, 66, 
	66, 66, 66, 66, 1, 68, 67, 69, 
	70, 71, 72, 71, 73, 67, 71, 71, 
	71, 1, 74, 74, 74, 1, 76, 75, 
	75, 77, 77, 77, 1, 78, 79, 79, 
	78, 79, 79, 79, 1, 80, 81, 82, 
	81, 80, 81, 81, 81, 1, 83, 84, 
	83, 1, 84, 85, 86, 87, 86, 84, 
	86, 86, 1, 89, 88, 90, 91, 90, 
	1, 90, 91, 79, 79, 90, 79, 79, 
	79, 1, 90, 92, 91, 92, 90, 92, 
	92, 92, 1, 89, 93, 94, 95, 96, 
	97, 98, 96, 94, 96, 96, 1, 100, 
	99, 101, 102, 101, 1, 103, 104, 103, 
	1, 105, 1, 105, 106, 107, 108, 107, 
	105, 107, 107, 1, 110, 109, 111, 94, 
	112, 111, 1, 111, 113, 94, 113, 112, 
	111, 113, 113, 113, 1, 110, 114, 115, 
	116, 115, 115, 115, 115, 1, 100, 117, 
	118, 118, 118, 118, 1, 101, 119, 102, 
	119, 101, 119, 119, 119, 1, 4, 5, 
	6, 7, 8, 9, 10, 3, 1, 1, 
	0
]

class << self
	attr_accessor :_rhaml_parser_trans_targs
	private :_rhaml_parser_trans_targs, :_rhaml_parser_trans_targs=
end
self._rhaml_parser_trans_targs = [
	2, 0, 49, 1, 3, 3, 4, 9, 
	15, 22, 24, 5, 6, 7, 49, 8, 
	8, 49, 10, 7, 49, 11, 6, 10, 
	13, 6, 12, 7, 49, 11, 6, 12, 
	13, 6, 14, 7, 49, 11, 6, 14, 
	13, 6, 16, 7, 49, 17, 19, 16, 
	20, 6, 19, 18, 17, 19, 18, 20, 
	6, 19, 6, 21, 17, 19, 21, 20, 
	6, 19, 23, 7, 49, 11, 6, 23, 
	13, 6, 25, 7, 49, 25, 26, 27, 
	28, 27, 29, 28, 29, 30, 33, 34, 
	30, 31, 32, 50, 33, 34, 35, 36, 
	45, 46, 47, 36, 37, 38, 39, 38, 
	39, 40, 41, 43, 44, 41, 42, 42, 
	51, 43, 44, 45, 40, 46, 48, 48
]

class << self
	attr_accessor :_rhaml_parser_trans_actions
	private :_rhaml_parser_trans_actions, :_rhaml_parser_trans_actions=
end
self._rhaml_parser_trans_actions = [
	0, 0, 74, 27, 11, 13, 1, 0, 
	0, 0, 0, 0, 0, 0, 49, 7, 
	0, 65, 43, 45, 110, 45, 113, 0, 
	45, 116, 35, 37, 92, 37, 95, 0, 
	37, 98, 31, 33, 80, 33, 83, 0, 
	33, 86, 3, 5, 56, 5, 59, 0, 
	5, 53, 62, 35, 37, 95, 0, 37, 
	89, 98, 47, 31, 33, 83, 0, 33, 
	77, 86, 39, 41, 101, 41, 104, 0, 
	41, 107, 23, 25, 71, 0, 0, 15, 
	17, 0, 17, 0, 0, 19, 68, 19, 
	0, 21, 0, 51, 21, 0, 0, 15, 
	15, 15, 0, 0, 0, 17, 17, 0, 
	0, 0, 19, 68, 19, 0, 21, 0, 
	51, 21, 0, 0, 17, 0, 15, 0
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
	0, 0, 0, 0
]

class << self
	attr_accessor :rhaml_parser_start
end
self.rhaml_parser_start = 49;
class << self
	attr_accessor :rhaml_parser_first_final
end
self.rhaml_parser_first_final = 49;
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
self.rhaml_parser_en_main = 49;


# line 296 "lib/rhaml/parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = rhaml_parser_start
	top = 0
end

# line 304 "lib/rhaml/parser.rb"
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
# line 50 "lib/rhaml/parser.rl"
		begin
 __call(:on_element_slash, data, p) 		end
when 24 then
# line 52 "lib/rhaml/parser.rl"
		begin
 __call(:on_newline, data, p) 		end
when 25 then
# line 31 "lib/rhaml/parser_common.rl"
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
when 26 then
# line 32 "lib/rhaml/parser_common.rl"
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
when 27 then
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
# line 520 "lib/rhaml/parser.rb"
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
# line 580 "lib/rhaml/parser.rb"
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

# line 84 "lib/rhaml/parser.rl"

      
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
