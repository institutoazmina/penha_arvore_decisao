package Penhas;
use Mojo::Base 'Mojolicious';

use Penhas::Config;
use Penhas::Helpers;
use Penhas::Routes;
use Penhas::Logger;
use Penhas::Utils;
use Penhas::SchemaConnected;
use Penhas::Authentication;

sub startup {
    my $self = shift;

    # Config.
    Penhas::Config::setup($self);

    # Logger.
    undef $Penhas::Logger::instance;
    get_logger();
    $self->plugin('Log::Any' => {logger => 'Log::Log4perl'});

    # Helpers
    Penhas::Helpers::setup($self);

    my $schema = $self->schema;

    # Não precisa manter conexao no processo manager
    $self->schema->storage->dbh->disconnect if not $ENV{HARNESS_ACTIVE};

    # Plugins.
    $self->plugin('ParamLogger', filter => [qw(password senha senha_atual message)]);

    # Helpers.
    $self->controller_class('Penhas::Controller');

    # Routes.
    Penhas::Routes::register($self->routes);

    $self->hook(
        around_dispatch => sub {
            my ($next, $c) = @_;
            Log::Log4perl::NDC->remove;

            $next->();
        }
    );


}

1;
