%%{
  machine rhaml_common;

  nl = [\n];
  rwp = (space -- nl)+ ;
  nowp = any - space;
  nonl = any - nl;

  header_type = rwp nowp>start_header_type nonl* %finish_header_type;

  header =
    "!!!" >new_header
    header_type?
    ;

  haml = header;

  main := haml;
}%%
