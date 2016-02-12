
# line 1 "lib/rhaml/parser.rl"

# line 43 "lib/rhaml/parser.rl"


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

      
# line 36 "lib/rhaml/parser.rb"
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
	21, 2, 2, 19, 2, 2, 20, 2, 
	8, 9, 2, 9, 10, 2, 16, 19, 
	2, 16, 20, 2, 18, 19, 2, 18, 
	20, 3, 8, 9, 10
]

class << self
	attr_accessor :_rhaml_parser_key_offsets
	private :_rhaml_parser_key_offsets, :_rhaml_parser_key_offsets=
end
self._rhaml_parser_key_offsets = [
	0, 0, 1, 2, 11, 12, 13, 17, 
	18, 19, 27, 39, 47, 63, 71, 87, 
	95, 111, 119, 131, 137, 147, 158, 170, 
	174, 185, 186, 190, 202, 214, 215, 227, 
	228, 239, 250, 251, 256, 269, 270, 279, 
	280, 286, 298, 302, 303, 312, 312
]

class << self
	attr_accessor :_rhaml_parser_trans_keys
	private :_rhaml_parser_trans_keys, :_rhaml_parser_trans_keys=
end
self._rhaml_parser_trans_keys = [
	10, 10, 9, 32, 33, 35, 37, 46, 
	58, 10, 13, 33, 33, 10, 32, 9, 
	13, 10, 10, 45, 95, 48, 58, 65, 
	90, 97, 122, 10, 32, 45, 95, 9, 
	13, 48, 58, 65, 90, 97, 122, 45, 
	95, 48, 58, 65, 90, 97, 122, 10, 
	32, 35, 40, 45, 46, 95, 123, 9, 
	13, 48, 58, 65, 90, 97, 122, 45, 
	95, 48, 58, 65, 90, 97, 122, 10, 
	32, 35, 40, 45, 46, 95, 123, 9, 
	13, 48, 58, 65, 90, 97, 122, 45, 
	95, 48, 58, 65, 90, 97, 122, 10, 
	32, 35, 40, 45, 46, 95, 123, 9, 
	13, 48, 58, 65, 90, 97, 122, 45, 
	95, 48, 58, 65, 90, 97, 122, 10, 
	32, 45, 95, 9, 13, 48, 58, 65, 
	90, 97, 122, 48, 57, 65, 90, 97, 
	122, 10, 32, 9, 13, 48, 57, 65, 
	90, 97, 122, 32, 45, 95, 9, 13, 
	48, 58, 65, 90, 97, 122, 32, 45, 
	61, 95, 9, 13, 48, 58, 65, 90, 
	97, 122, 32, 61, 9, 13, 32, 34, 
	36, 39, 95, 9, 13, 65, 90, 97, 
	122, 34, 32, 41, 9, 13, 32, 41, 
	45, 95, 9, 13, 48, 58, 65, 90, 
	97, 122, 32, 36, 41, 95, 9, 13, 
	48, 57, 65, 90, 97, 122, 39, 32, 
	34, 36, 39, 58, 95, 9, 13, 65, 
	90, 97, 122, 34, 32, 34, 36, 39, 
	95, 9, 13, 65, 90, 97, 122, 32, 
	34, 36, 39, 95, 9, 13, 65, 90, 
	97, 122, 34, 32, 44, 125, 9, 13, 
	32, 36, 44, 95, 125, 9, 13, 48, 
	57, 65, 90, 97, 122, 39, 36, 58, 
	95, 48, 57, 65, 90, 97, 122, 39, 
	36, 95, 65, 90, 97, 122, 32, 36, 
	61, 95, 9, 13, 48, 57, 65, 90, 
	97, 122, 32, 61, 9, 13, 62, 9, 
	32, 33, 35, 37, 46, 58, 10, 13, 
	0
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
	0, 0, 0, 1, 0, 0, 1, 0, 
	0, 3, 4, 3, 4, 3, 4, 3, 
	4, 3, 4, 3, 4, 4, 4, 1, 
	3, 0, 1, 4, 4, 0, 3, 0, 
	3, 3, 0, 1, 4, 0, 3, 0, 
	2, 4, 1, 0, 1, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_index_offsets
	private :_rhaml_parser_index_offsets, :_rhaml_parser_index_offsets=
end
self._rhaml_parser_index_offsets = [
	0, 0, 2, 4, 13, 15, 17, 21, 
	23, 25, 31, 40, 46, 59, 65, 78, 
	84, 97, 103, 112, 116, 123, 131, 140, 
	144, 153, 155, 159, 168, 177, 179, 189, 
	191, 200, 209, 211, 216, 226, 228, 235, 
	237, 242, 251, 255, 257, 266, 267
]

class << self
	attr_accessor :_rhaml_parser_indicies
	private :_rhaml_parser_indicies, :_rhaml_parser_indicies=
end
self._rhaml_parser_indicies = [
	1, 0, 2, 0, 4, 5, 6, 7, 
	8, 9, 10, 1, 3, 11, 1, 12, 
	1, 14, 13, 13, 1, 1, 15, 17, 
	16, 18, 18, 18, 18, 18, 1, 20, 
	19, 21, 21, 19, 21, 21, 21, 1, 
	22, 22, 22, 22, 22, 1, 24, 23, 
	25, 26, 27, 28, 27, 29, 23, 27, 
	27, 27, 1, 30, 30, 30, 30, 30, 
	1, 20, 19, 31, 32, 33, 34, 33, 
	35, 19, 33, 33, 33, 1, 36, 36, 
	36, 36, 36, 1, 38, 37, 39, 40, 
	41, 42, 41, 43, 37, 41, 41, 41, 
	1, 44, 44, 44, 44, 44, 1, 38, 
	37, 45, 45, 37, 45, 45, 45, 1, 
	46, 46, 46, 1, 48, 47, 47, 49, 
	49, 49, 1, 50, 51, 51, 50, 51, 
	51, 51, 1, 52, 53, 54, 53, 52, 
	53, 53, 53, 1, 55, 56, 55, 1, 
	56, 57, 58, 59, 58, 56, 58, 58, 
	1, 61, 60, 62, 63, 62, 1, 62, 
	63, 51, 51, 62, 51, 51, 51, 1, 
	62, 64, 63, 64, 62, 64, 64, 64, 
	1, 61, 65, 66, 67, 68, 69, 70, 
	68, 66, 68, 68, 1, 72, 71, 73, 
	74, 75, 76, 75, 73, 75, 75, 1, 
	77, 78, 79, 80, 79, 77, 79, 79, 
	1, 82, 81, 83, 66, 84, 83, 1, 
	83, 85, 66, 85, 84, 83, 85, 85, 
	85, 1, 82, 86, 87, 73, 87, 87, 
	87, 87, 1, 72, 88, 89, 89, 89, 
	89, 1, 90, 91, 92, 91, 90, 91, 
	91, 91, 1, 93, 94, 93, 1, 77, 
	1, 4, 5, 6, 7, 8, 9, 10, 
	1, 3, 1, 1, 0
]

class << self
	attr_accessor :_rhaml_parser_trans_targs
	private :_rhaml_parser_trans_targs, :_rhaml_parser_trans_targs=
end
self._rhaml_parser_trans_targs = [
	2, 0, 44, 1, 3, 3, 4, 9, 
	11, 17, 19, 5, 6, 7, 44, 8, 
	8, 44, 10, 7, 44, 10, 12, 7, 
	44, 13, 6, 12, 15, 6, 14, 13, 
	6, 14, 15, 6, 16, 7, 44, 13, 
	6, 16, 15, 6, 18, 18, 20, 7, 
	44, 20, 21, 22, 23, 22, 24, 23, 
	24, 25, 28, 29, 25, 26, 27, 45, 
	28, 29, 30, 31, 38, 39, 40, 31, 
	32, 33, 34, 36, 37, 33, 34, 36, 
	37, 34, 35, 35, 46, 36, 37, 38, 
	39, 41, 42, 41, 43, 42, 43
]

class << self
	attr_accessor :_rhaml_parser_trans_actions
	private :_rhaml_parser_trans_actions, :_rhaml_parser_trans_actions=
end
self._rhaml_parser_trans_actions = [
	0, 0, 29, 27, 11, 13, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 7, 
	0, 9, 35, 37, 37, 0, 3, 5, 
	5, 5, 41, 0, 5, 44, 35, 37, 
	59, 0, 37, 62, 31, 33, 33, 33, 
	53, 0, 33, 56, 31, 0, 23, 25, 
	25, 0, 0, 15, 17, 0, 17, 0, 
	0, 19, 50, 19, 0, 21, 0, 39, 
	21, 0, 0, 15, 15, 15, 0, 0, 
	0, 17, 47, 65, 47, 0, 19, 50, 
	19, 0, 21, 0, 39, 21, 0, 0, 
	0, 15, 17, 0, 17, 0, 0
]

class << self
	attr_accessor :_rhaml_parser_eof_actions
	private :_rhaml_parser_eof_actions, :_rhaml_parser_eof_actions=
end
self._rhaml_parser_eof_actions = [
	0, 0, 29, 0, 0, 0, 0, 0, 
	9, 0, 37, 0, 5, 0, 37, 0, 
	33, 0, 33, 0, 25, 0, 0, 0, 
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


# line 271 "lib/rhaml/parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = rhaml_parser_start
	top = 0
end

# line 279 "lib/rhaml/parser.rb"
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
 @callbacks[:on_new_header].call(data, p) 		end
when 1 then
# line 6 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_tag].call(data, p) 		end
when 2 then
# line 8 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_tag].call(data, p == eof ? p : p-1) 		end
when 3 then
# line 10 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_inline_text].call(data, p) 		end
when 4 then
# line 12 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_inline_text].call(data, p == eof ? p : p-1) 		end
when 5 then
# line 14 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_tab_indent].call(data, p) 		end
when 6 then
# line 16 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_space_indent].call(data, p) 		end
when 7 then
# line 18 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_attr_name].call(data, p) 		end
when 8 then
# line 20 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_attr_name].call(data, p-1) 		end
when 9 then
# line 22 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_attr_val].call(data, p) 		end
when 10 then
# line 24 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_attr_val].call(data, p) 		end
when 11 then
# line 26 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_filter].call(data, p) 		end
when 12 then
# line 28 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_filter].call(data, p) 		end
when 13 then
# line 30 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_text].call(data, p) 		end
when 14 then
# line 32 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_text].call(data, p) 		end
when 15 then
# line 34 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_class].call(data, p) 		end
when 16 then
# line 36 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_class].call(data, p == eof ? p : p-1) 		end
when 17 then
# line 38 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_start_id].call(data, p) 		end
when 18 then
# line 40 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_id].call(data, p == eof ? p : p-1) 		end
when 19 then
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
when 20 then
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
when 21 then
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
# line 471 "lib/rhaml/parser.rb"
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
 @callbacks[:on_finish_tag].call(data, p == eof ? p : p-1) 		end
when 4 then
# line 12 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_inline_text].call(data, p == eof ? p : p-1) 		end
when 12 then
# line 28 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_filter].call(data, p) 		end
when 14 then
# line 32 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_text].call(data, p) 		end
when 16 then
# line 36 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_class].call(data, p == eof ? p : p-1) 		end
when 18 then
# line 40 "lib/rhaml/parser.rl"
		begin
 @callbacks[:on_finish_id].call(data, p == eof ? p : p-1) 		end
# line 523 "lib/rhaml/parser.rb"
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

# line 76 "lib/rhaml/parser.rl"

      
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
