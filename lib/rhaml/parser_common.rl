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

  tag_name = (alnum | [:-_])+ ;

  tag = "%" tag_name >start_tag %/finish_tag %finish_tag ;

  element = header | tag;

  inline_text = nonl+>start_inline_text %/finish_inline_text %finish_inline_text ;

  line =
    indent* element wp* <: inline_text? nl ;

  main := line*;
}%%
