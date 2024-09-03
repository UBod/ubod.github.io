#!/usr/bin/perl -w

use strict;
use warnings;

my $headerfile = "Template_Header.html";
my $footerfile = "Template_Footer.html";
my $bibfile = "./BodenhoferPub.bib";
#my $bibtohtml = "~/Downloads/bibtex2html-1.96-linux/bibtex2html";
my $bibtohtml = "bibtex2html";

die "Could not open BIB file $bibfile"
    unless (open(BIBFILE, "<$bibfile"));

my @exclude = qw/Books Theses Editorial/;

my %sectionhash;
my $line;
my $section = "";

my %excludehash;

$excludehash{$_} = 1 foreach (@exclude);

while ($line = <BIBFILE>)
{
    chomp $line;

    if ($line =~ /^\#SECTION\|(.+)\|(.+)$/)
    {
        $section = $1;

	unless (exists($sectionhash{$section}))
	{
	    $sectionhash{$section} = {name => $2, list => []};
	}
    }
    elsif ($line =~ /^\@(\w+)\{([\w\-]+\d\d[a-z]?)\,/)
    {
        push(@{$sectionhash{$section}{list}}, $2);
    }
}

close(BIBFILE);

local $/;

die "Could not open header file $headerfile\n"
    unless (open(HEADER, "<$headerfile"));

my $header = <HEADER>;

close(HEADER);

die "Could not open footer file $footerfile\n"
    unless (open(FOOTER, "<$footerfile"));

my $footer = <FOOTER>;

close(FOOTER);

foreach $section (keys(%sectionhash))
{
    if (open(OUTPUT, ">$section.cite"))
    {
        print OUTPUT join("\n", @{$sectionhash{$section}{list}});

	close(OUTPUT);

	system("$bibtohtml -nodoc -noheader -u -r --revkeys -m macros.tex " .
	       "-citefile $section.cite -o $section\_RAW $bibfile");

	unless (exists($excludehash{$section}))
	{
	    PostProcess("$section\_RAW.html", "all");
	}

	PostProcess("$section\_RAW\_bib.html", "");
    }
    else
    {
        warn "Could not open outputfile >$section.cite";
    }
}

chdir("pdf");

system("$bibtohtml -m ../macros.tex " .
       "--header \"<h1>Ulrich Bodenhofer\'s Publications</h1>\" " .
       "--style-sheet 'http://ulrich.bodenhofer.com/css/ulrich.css' " .
       "-o index $bibfile");


sub PostProcess
{
    my ($inputfile, $outputfile, $type) = ($_[0], $_[0], $_[1]);

    $outputfile =~ s/\_RAW//;

    $section = $outputfile;
    $section =~ s/\.html//;
    $section =~ s/\_bib//;

    unless (open(INPUT, "<$inputfile"))
    {
        warn "Could not open input file $inputfile\n";

	return;
    }

    my $content = <INPUT>;

    $content =~ s/\<h1\>.*\<\/h1\>//ig;
    $content =~ s/\<hr\>.*$//is;
    $content =~ s/\_RAW//g;
    $content =~ s/U\.(\&nbsp| )\;Bodenhofer/\<b\>U\.\&nbsp\;Bodenhofer\<\/b\>/g;
    $content =~ s/The(\&nbsp|\s+)QSTAR(\&nbsp|\s+)Consortium/\<b\>The QSTAR Consortium\<\/b\>/g;
    $content =~ s/\<a href=\"http(.*)\>(.*)\<\/a\>/\<a href=\"http$1 target=\"_blank\"\>$2\<\/a\>/g;

    if ($type eq "all")
    {
        $content =~ s/---/\&\#8212;/g;
        $content =~ s/--/\&\#8211;/g;
        $content =~ s/http:\/\/dx.doi.org/https:\/\/doi.org/g;
    }

    close(INPUT);

    unless (open(OUTPUT, ">$outputfile"))
    {
        warn "Could not open input file $inputfile\n";

	return;
    }

    print OUTPUT $header,
                 "\n<h3>",
		 $sectionhash{$section}{name},
		 "</h3>\n",
		 $content, "\n",
		 $footer;

    close(OUTPUT);
}
