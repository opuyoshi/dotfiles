#!/usr/bin/env perl

$latex = 'uplatex -synctex=1 -halt-on-error';
$latex_silent = 'uplatex -synctex=1 -halt-on-error -interaction=batchmode';
$bibtex = 'upbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode = 3;
$pvc_view_file_via_temporary = 0;
# prevew
if ($^O  eq 'linux'){
    $pdf_previewer = 'start evince-synctex %S "echo go_to_%l"';
}
elsif ($^O eq 'MSWin32'){
    # My Lab PC (Windows)
    $pdf_previewer = 'C:\Users\STUDENT\AppData\Local\SumatraPDF\SumatraPDF.exe -reuse-instance %O %S';
}
$clean_ext = "bbl synctex.gz dvi";
