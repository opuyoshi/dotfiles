#!/usr/bin/env perl

$latex = 'uplatex -synctex=1 -halt-on-error';
$latex_silent = 'uplatex -synctex=1 -halt-on-error -interaction=batchmode';
$bibtex = 'upbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode = 3;
$pvc_view_file_via_temporary = 0;
$pdf_previewer = 'start evince-synctex %S "echo go_to_%l"';
$clean_ext = "bbl synctex.gz dvi";
