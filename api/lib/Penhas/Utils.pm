package Penhas::Utils;
use strict;
use warnings;
use JSON;
use v5.10;
use Mojo::URL;
use Crypt::PRNG qw(random_string random_string_from);
use Encode qw/encode_utf8/;
use Digest::SHA qw/sha256_hex/;
use Digest::MD5 qw/md5_hex/;
use File::Path qw(make_path);
use Carp;
use Time::HiRes qw//;
use Text::Xslate;
use POSIX ();
use utf8;
use vars qw(@ISA @EXPORT);

use DateTime::Format::Pg;

state $text_xslate = Text::Xslate->new(
    syntax => 'TTerse',
    module => ['Text::Xslate::Bridge::TT2Like'],
);

@ISA    = (qw(Exporter));
@EXPORT = qw(
  random_string
  random_string_from

  is_test
  env
  tt_test_condition
  tt_render
  trunc_to_meter
);


sub is_test {
    if ($ENV{HARNESS_ACTIVE} || $0 =~ m{forkprove}) {
        return 1;
    }
    return 0;
}

sub env { return $ENV{${\shift}} }

sub tt_test_condition {
    my ($template, $vars) = @_;

    croak '$template is undef' unless defined $template;

    $template = "[% $template %]";
    my $ret = $text_xslate->render_string($template, $vars);
    $ret =~ /^\s+/;
    $ret =~ /\s+$/;

    #use DDP; p [$template, $vars, $ret];
    return $ret ? 1 : 0;
}

sub tt_render {
    my ($template, $vars) = @_;

    return '' unless $template;

    my $ret = $text_xslate->render_string($template, $vars);
    $ret =~ /^\s+/;
    $ret =~ /\s+$/;

    #use DDP; p [$template, $vars, $ret];
    return $ret;
}


sub _nearest_floor {
    my $targ = abs(shift);
    my @res  = map { $targ * POSIX::ceil(($_ - 0.50000000000008 * $targ) / $targ) } @_;

    return wantarray ? @res : $res[0];
}

# semelhante a sprintf( '%0.5f', shift ) porem tem mais chance de cair em hit do cache
sub trunc_to_meter ($) {
    return &_nearest_floor(0.00009, shift);
}

1;
