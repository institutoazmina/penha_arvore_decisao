package Penhas::Routes;
use Mojo::Base -strict;

sub register {
    my $r = shift;

    # quiz anônimo
    my $anon_quiz = $r->under('anon-questionnaires')->to(controller => 'AnonQuestionnaire', action => 'verify_anon_token');
    $anon_quiz->get('config')->to(action => 'aq_config_get');
    $anon_quiz->get()->to(action => 'aq_list_get');
    $anon_quiz->post('new')->to(action => 'aq_list_post');
    $anon_quiz->get('history')->to(action => 'aq_history_get');
    $anon_quiz->post('process')->to(action => 'aq_process_post');

}

1;
