#!/usr/bin/env perl
use warnings;
use strict;

use File::Path;
use feature qw(say);

my $home;

sub main
{
    $home = $ENV{HOME};
    vim();
    vimplugins();
}

sub vim
{
    mkpath("$home/.vim/pack/plugins/start");
    mkpath("$home/.vim/pack/plugins/opt");
}

sub getplugin
{
    my ($author, $name, $opt) = @_;
    $opt = $opt || 'start';
    chdir("$home/.vim/pack/plugins/$opt");
    if (-d $name){
        say("already exists $name");
        return;
    }
    system("git clone https://github.com/$author/$name.git");
}

sub vimplugins
{
    getplugin("flazz", "vim-colorschemes", 'opt');
    getplugin("mileszs", "ack.vim");
    getplugin("othree", "html5.vim");
    getplugin("Shutnik", "jshint2.vim");
    getplugin("rust-lang", "rust.vim");
    getplugin("rhysd", "rust-doc.vim");
    getplugin("tpope", "vim-dispatch");
    getplugin("tpope", "vim-fireplace");
    getplugin("tpope", "vim-surround");
    getplugin("tikhomirov", "vim-glsl");
    getplugin("derekwyatt", "vim-scala");
    getplugin("wincent", "command-t");
    getplugin("kana", "vim-textobj-user");
    getplugin("sgur", "vim-textobj-parameter");
    getplugin("mhinz", "vim-startify");
    getplugin("chrisbra", "NrrwRgn");
    getplugin("w0rp", "ale");
}

main();
