#!/usr/bin/env perl
use utf8;
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
#plugin 'PODRenderer';
app->config(hypnotoad => {listen => ['http://*:3001']});

get '/' => sub {
  my $self = shift;
  $self->render('kondo');
};

post '/' => sub{
    my $self = shift;
    my $kantou = $self->param('kantou');
    my $henkan = $self->param('henkan');
    my $str;
    if ($henkan eq '関西風'){
       if ($kantou eq 'つぎ'){
           $str = 'つぎ　の電車は「次発」です。';
       }else{
           $str = 'こんど　の電車は「先発」です。';
       };
    }elsif ($henkan eq 'English'){
       if ($kantou eq 'つぎ'){
           $str = 'つぎ is the second to depart'
       }else{
           $str = 'こんど is the first to depart'
       };
    }else{
    };
    $self->stash('str' => $str);
    $self->render('transration');
};


app->start;
__DATA__

@@ kondo.html.ep
% layout 'default';
% title '東京の電車';
%= form_for '/' => method => 'post' => begin
    %= select_field 'kantou' =>[qw/こんど つぎ/]
    の電車を
    %= select_field 'henkan' =>[qw/関西風 English/]
    で表現すると
    %= submit_button '変換(Tranceration))'
% end

@@ transration.html.ep
% layout 'default';
% title '東京の電車';
<%= $str %>
%= form_for '/' => method => 'get' => begin
    %= submit_button '戻る'
% end
</br>
このサービスは全て、<a href="http://www.perl-entrance.org/">Perl入学式</a>で学習した内容で作成されています。

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
