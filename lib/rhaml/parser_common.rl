%%{
  machine rhaml_common;

  nl = [\n];
  wp = space -- nl;
  rwp = wp+ ;
  nowp = ^space;
  nonl = ^nl;

  tabi = [\t] $tab_indent;
  spi = " " $space_indent;
  indent = tabi | spi;

  header = "!!!" >new_header ;

  name = (alnum | ":" | "-" | "_")+ ;

  attr_name = name;

  tag_name = name;

  squoted = "'" ((any -- "'") | "\'")* :>> "'" ;
  dquoted = '"' ((any -- '"') | '\"')* :>> '"' ;

  quoted = squoted | dquoted;

  var = (alpha | "_" | "$") (alnum | "_" | "$")*;

  attr_val = var | quoted;

  action call_html_attrs { fcall html_attrs; }
  action call_ruby_attrs { fcall ruby_attrs; }
  action ret { fret; }

  html_attr =
    space*
    attr_name >start_attr_name
              %finish_attr_name
    space*
    "="
    space*
    attr_val >start_attr_val
             @finish_attr_val
    ;

  html_attrs := html_attr (space+ html_attr)* space* ")" $ret;

  ruby_var_name = var;

  ruby_attr_name = 
    (":" ruby_var_name >start_attr_name %finish_attr_name space* "=>") |
    (ruby_var_name >start_attr_name %finish_attr_name ":") |
    quoted >start_attr_name %finish_attr_name ;

  ruby_attr =
    space*
    ruby_attr_name
    space*
    attr_val >start_attr_val @finish_attr_val ;

  ruby_attrs := ruby_attr (space* "," space* ruby_attr)* space* "}" $ret;

  attrs = "(" $call_html_attrs | "{" $call_ruby_attrs ;

  class =
    "." tag_name
      >start_class
      %/finish_class
      %finish_class ;

  id =
    "#" tag_name >start_id %/finish_id %finish_id;

  div =
    class | id;

  tag =
    "%" tag_name >start_tag
                 %/finish_tag
                 %finish_tag
    (div)*
    attrs?
    ;

  filter =
    ":" alnum+ >start_filter %/finish_filter %finish_filter ;

  element = header | tag | div | filter;

  inline_text = wp nonl+>start_inline_text %/finish_inline_text %finish_inline_text ;

  text = ^(space | ":" | "!" | "%" | "." | "#" ) >start_text nonl+ %/finish_text %finish_text;

  line =
    indent* ((element inline_text?) | text) nl ;

  main := line*;
}%%
