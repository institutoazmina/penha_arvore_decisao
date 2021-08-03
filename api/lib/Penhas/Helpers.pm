package Penhas::Helpers;
use Mojo::Base -base;
use Penhas::SchemaConnected;
use Penhas::Controller;

use Penhas::Helpers::Quiz;
use Penhas::Helpers::AnonQuiz;
use Penhas::KeyValueStorage;

use Penhas::Helpers::Geolocation;
use Penhas::Helpers::GeolocationCached;

use Carp qw/croak confess/;

sub setup {
    my $c = shift;

    Penhas::Helpers::Quiz::setup($c);
    Penhas::Helpers::AnonQuiz::setup($c);
    Penhas::Helpers::Geolocation::setup($c);
    Penhas::Helpers::GeolocationCached::setup($c);

    state $kv = Penhas::KeyValueStorage->instance;
    $c->helper(kv                    => sub {$kv});
    $c->helper(schema                => \&Penhas::SchemaConnected::get_schema);

    $c->helper('reply.exception' => sub { Penhas::Controller::reply_exception(@_) });
    $c->helper('reply.not_found' => sub { Penhas::Controller::reply_not_found(@_) });
    $c->helper('user_not_found'  => sub { Penhas::Controller::reply_not_found(@_, type => 'user_not_found') });

    $c->helper('reply_invalid_param' => sub { Penhas::Controller::reply_invalid_param(@_) });

    $c->helper(respond_to_if_web => \&respond_to_if_web);
}

sub respond_to_if_web {
    my $c = shift;

    my $accept = $c->req->headers->header('accept');
    if (($c->stash('template') || $c->stash('use_flash_return')) && $accept && $accept =~ /html/) {
        my $ref_header = $c->req->headers->header('referer');
        if ($c->stash('use_flash_return')) {
            if (!$ref_header) {
                goto JSON;
            }
            else {
                my (%keys) = @_;
                my $html = $keys{html};
                if (defined $html && ref $html eq 'HASH') {
                    $c->log->debug("saving to flash " . to_json($html));

                    $html->{params} = $c->req->params->to_hash;

                    $c->flash_to_redis($html);

                    return $c->redirect_to($ref_header);
                }
            }
        }

        $c->respond_to(@_);
    }
    else {
      JSON:
        my %opts = %{{@_}->{json}};
        die 'missing object json' unless $opts{json};
        $c->render(%opts);
    }
}


1;
