use v5.37.9;
use experimental qw( class try builtin );
use builtin qw( true false trim );

package VLC::XS;
class VLC::XS;

our $VERSION = 0.4;

require XSLoader;

XSLoader::load( __PACKAGE__ , $VERSION );

field $instance = VLC::XS::custom_instance();

# TODO: add $instance to method arguments who require it comparing with Engine.pm

method release ( ) {
  VLC::XS::_release_( $instance );
}

method vlc_version ( ) {
  VLC::XS::_version_();
}

method set_media ( $url ) {
  VLC::XS::_set_media_( $instance , $url );
}

method set_media_list ( $url ) {
  VLC::XS::_set_media_list_( $instance , $url );
}

method set_location ( $url ) # TODO: Add POD for the method
{
  VLC::XS::_set_location( $instance , $url );
}

method parsing_media ( ) {
  VLC::XS::_parse_media_();
}

method get_duration {
  return VLC::XS::_get_duration_();
}

method play {
  VLC::XS::_play_();
}

method play_list {
  VLC::XS::_play_list_();
}

method play_next {
  return VLC::XS::_media_list_player_next_();
}

method play_previous {
  return VLC::XS::_media_list_player_previous_();
}

method pause {
  VLC::XS::_pause_();
}

method stop {
  VLC::XS::_stop_();
}

method pause_list {
  VLC::XS::_pause_list_();
}

method stop_list {
  VLC::XS::_stop_list_();
}

method set_volume ( $volume ) {
  return VLC::XS::_set_volume_( $volume ) if defined $volume;
}

method get_volume {
  return VLC::XS::_get_volume_();
}

method set_mute ( $status ) {
  VLC::XS::_set_mute_( $status ) if ( defined $status );
}

method get_mute {
  VLC::XS::_get_mute_();
}

method get_state {
  return VLC::XS::_get_state_();
}

method event_manager {
  return VLC::XS::_event_manager_();
}

method event_attach ( $manager , $i_event_type , $f_callback ) {
  if ( defined $manager && defined $i_event_type && defined $f_callback ) {
    VLC::XS::_event_attach_( $manager , $i_event_type , $f_callback );
  }
}

method get_meta ( $value ) {
  return VLC::XS::_get_meta_( $value ) if ( defined $value );
}

method set_meta ( $meta , $value ) {
  VLC::XS::_set_meta_( $meta , $value ) if ( defined $value && defined $meta );
}

method save_meta {
  return VLC::XS::_save_meta_();
}

method media_parse_async {
  return VLC::XS::_media_parse_async_();
}

1;

__END__

=encoding utf-8

=head1 NAME

VLC::XS - bindings for perl

=head1 VERSION

version 0.004

=head1 SYNOPSIS

  use VLC::XS;
  my $player = VLC::XS->new();
  $player->set_media("your_media");
  $player->play();
  sleep(30);
  $player->stop()
  $player->release();

=head1 DESCRIPTION

VLC is a free and open source cross-platform multimedia 
player and framework that plays most multimedia files as 
well as DVDs,Audio CDs, VCDs, and various streaming protocols.

=head1 METHODS

=head2 new

    my $player = VLC::XS->new();
    #or with options
    my $options = ["--no-video", "--no-xlib"];
    my $player = VLC::XS->new($options);

This constructor returns a new C<VLC::XS> object. Optional attributes
include: Vlc options, you can get more info if you type vlc -H .

=head2 vlc_version

    $player->vlc_version();

This method is used to get the version of Vlc.

=head2 set_media

    $player->set_media("your_media");

This method is used to set your media (from local or from network is possible also).

=head2 play

    $player->play();

This method is used to start playing your media.

=head2 pause

    $player->pause();

This method is used to pause your player.

=head2 stop

    $player->stop();

This method is used to stop your player. 

=head2 set_volume

    $player->set_volume(70);

This method is used to set volume.

=head2 get_volume

    my $volume = $player->get_volume();

This method is used to get volume.

=head2 set_mute

    $player->set_mute(1);

This method is used to set mute false or true, 0 is false and 1 is true.

=head2 get_mute

    my $mute_status = $player->get_mute();

This method is used to get mute status.

=head2 parsing_media

    $player->parsing_media();

This method is used to parse your media, it will help to get 
duration and more info ( you should run it before play).

=head2 parsing_media_async

    $player->parsing_media_async();

This method is used to parse your media with asynv, it will help to get
duration and more info ( you should run it before play).

=head2 get_duration

    $player->get_duration();

This method will help you to get duration of your media by ms.

=head2 set_meta

    $player->get_meta('your_meta_param', 'value');

This method is used to modify meta. 

=head2 save_meta

     $player->save_meta();

This method is used to save meata that you changed.

=head2 get_meta

     $player->get_meta('your_meta_param');

This method will help you to get info about your media by using params.

=over 4

=item *

title - Get the title of your track

=item *

artist - Get the artist.

=item *

genre - Get the genre.

=item *

album - Get the Album.

=item *

copyright - Get the copyright.

=item *

track_number - Get track number.

=item *

description  - Get description.

=item *

rating - Get rating.

=item *

date - Get date.

=item *

setting - Get setting.

=item *

url - Get url.

=item *

language - Get language.

=item *

now_playinge - Get now playinge.

=item *

publisher - Get publisher.

=item *

encoded_by - Get encoded by.

=item *

artwork_url - Get artwork url.

=item *

track_id - Get track id.

=item *

track_total - Get track total.

=item *

director - Get director.

=item *

season - Get season.

=item *

episode - Get episode.

=item *

show_name - Show name

=item *

actors - Get actors.

=back

=head2 get_state

    my $state = $player->get_state();

This method is used to get state of your player.

=head2 event_manager

    my $event_manager = $player->event_manager();

This method is used to get an instance of event manager.

=head2 event_attach

    $player->event_attach($manager, 'media_player_playing', \&play);

This method is used to run a function when your player get a specifc event.
$manager is an event_manager instance 'media_player_playing' is an event, 
play( is a function. Here are some events that you can check:

=over 4

=item *

media_player_playing

=item *

media_player_stopped

=item *

media_meta_changed

=item *

media_sub_item_added

=item *

media_duration_changed

=item *

media_parsed_changed

=item *

media_freed

=item *

media_state_changed

=item *

media_subItem_tree_added

=item *

media_player_media_changed

=item *

media_player_nothing_special

=item *

media_player_buffering

=item *

media_player_paused

=item *

media_player_forward

=item *

media_player_backward

=item *

media_player_end_reached

=item *

media_player_encountered_error

=item *

media_player_time_changed

=item *

media_player_position_changed

=item *

media_player_seekable_changed

=item *

media_player_pausable_changed

=item *

media_player_title_changed

=item *

media_player_snapshot_taken

=item *

media_player_length_changed

=item *

media_player_vout

=item *

media_player_scrambled_changed

=item *

media_player_corked

=item *

media_player_uncorked

=item *

media_player_muted

=item *

MediaPlayerUnmuted

=item *

media_player_audio_volume

=item *

media_list_item_added

=item *

media_list_will_add_item

=item *

media_list_view_will_add_item

=item *

media_list_item_deleted

=item *

media_list_will_delete_item

=item *

media_list_view_will_delete_item

=item *

media_list_player_played

=item *

media_list_player_next_item_set

=item *

media_list_player_stopped

=item *

media_discoverer_started

=item *

media_discoverer_ended

=item *

vlm_media_added

=item *

vlm_media_removed

=item *

vlm_media_changed

=item *

vlm_media_instance_started

=item *

vlm_media_instance_stopped

=item *

vlm_media_instance_status_init

=item *

vlm_media_instance_status_opening

=item *

vlm_media_instance_status_playing

=item *

vlm_media_instance_status_pause

=item *

vlm_media_instance_status_playing

=item *

vlm_media_instance_status_end

=item *

vlm_media_instance_status_error

=back

=head2 set_media_list

    $player->set_media_list("your_first_media");
    $player->set_media_list("your_second_media");

This method is used to set list (from local or from network is possible also).

=head2 play_list

    $player->play_list();

This method is used to play list or medias.

=head2 play_next

    $player->play_next();

This method is used to play next media in the list.

=head2 play_previous

    $player->play_previous();

This method is used to play previous media, in the list.

=head2 pause_list

    $player->pause_list();

This method is used to pause playing your list.

=head2 stop_list

    $player->stop_list();

This method is used to stop playing a list.

=head1 SEE ALSO

For more information, please visit L<VLC|https://www.videolan.org/developers/vlc/doc/doxygen/html/group__libvlc.html/>.

=head1 AUTHOR

James Axl, E<lt>jamesaxl@falseking.orgE<gt>

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests on my email or create a ticket here

L<https://fossil.falseking.org/vlc-engine/flk>

=head2 Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

L<https://fossil.falseking.org/vlc-engine/flk>

=head1 COPYLEFT AND LICENSE

Copyleft (C) 2017 by James Axl For the love of the community

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.24.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
