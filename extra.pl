#!/usr/bin/env perl
use warnings;
use strict;

use File::Path;
use feature qw(say);

my $home;

sub main
{
    $home = $ENV{HOME};
    fonts();
    vim();
    vimplugins();
}

sub fonts
{
    if (-d "$home/.fonts/source-code-pro-1.017R"){
        say("already installed");
        return;
    }
    mkpath("$home/.fonts");
    if (system("curl -LSso $home/.fonts/1.017R.tar.gz ".
        "https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz"))
    {
        die "failed download";
    }
    chdir("$home/.fonts");
    system("tar xvf 1.017R.tar.gz");
    system("sudo fc-cache -f -v");
    system("rm 1.017R.tar.gz");
}

sub vim
{
    my $pathogen = -f "$home/.vim/autoload/pathogen.vim";
    if ($pathogen){
        say("all done");
        return;
    }
    mkpath("$home/.vim/autoload");
    mkpath("$home/.vim/bundle");
    system("curl -LSso $home/.vim/autoload/pathogen.vim ".
        "https://tpo.pe/pathogen.vim");
}

sub getplugin
{
    my ($author, $name) = @_;
    chdir("$home/.vim/bundle");
    if (-d $name){
        say("already exists $name");
        return;
    }
    system("git clone https://github.com/$author/$name.git");
}

sub vimplugins
{
    getplugin("flazz", "vim-colorschemes");
    getplugin("mileszs", "ack.vim");
    getplugin("othree", "html5.vim");
    getplugin("Shutnik", "jshint2.vim");
    getplugin("Shougo", "neocomplete");
    getplugin("vogre", "dirman-vim");
    getplugin("rust-lang", "rust.vim");
    getplugin("tpope", "vim-dispatch");
    getplugin("tpope", "vim-fireplace");
    getplugin("tpope", "vim-surround");
    getplugin("tikhomirov", "vim-glsl");
    getplugin("jelera", "vim-javascript-syntax");
    getplugin("embear", "vim-localvimrc");
    getplugin("yegappan", "mru");
    getplugin("derekwyatt", "vim-scala");
    getplugin("wincent", "command-t");
    getplugin("kana", "vim-textobj-user");
    getplugin("sgur", "vim-textobj-parameter");
    getplugin("rhysd", "rust-doc.vim");
    getplugin("mhinz", "vim-startify");
}

main();
