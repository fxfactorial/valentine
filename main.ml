open StdLabels
open Cmdliner

let did_error = ref false

let oops msg =
  print_endline "You have a mistake in your HTML";
  Printf.sprintf "\027[31m%s\027[m" msg
  |> print_endline

let html_files =
  let doc = "List of html files to validate" in
  Arg.(non_empty & pos_all file [] & info [] ~docv:"HTML file(s)" ~doc)

let do_parse html_file =
  Markup.(
    file html_file
    |> fun (stream, closer) ->
    stream
    |> parse_html
      ~report:(fun location e ->
          did_error := true;
          Markup.Error.to_string ~location e |> oops)
    |> signals
    |> write_html
    |> to_string
    |> fun _ -> closer ()
  )

let begin_program
    html_files =
  html_files |> List.iter ~f:do_parse;
  exit (if !did_error then 1 else 0)

let entry_point =
  Term.(pure
          begin_program
       $ html_files)

let top_level_info =
  let doc = "Validate your HTML according to HTML spec" in
  let man = [`S "DESCRIPTION"] in
  Term.info ~version:"0.9.0" ~doc ~man "valentine"

let () =
  Term.eval (entry_point, top_level_info)
  |> ignore
