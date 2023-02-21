use v5.37.9;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME          => 'VLC::XS' ,
  ABSTRACT      => 'An embedded for VLC Player' ,
  VERSION_FROM  => 'lib/VLC/XS.pm' ,
  PREREQ_PM     => {
    'strict'      => 0 ,
    'warnings'    => 0 ,
    'URI::Escape' => 0 ,
  } ,
  TEST_REQUIRES => { 'Test::More' => 0 , } ,
  ABSTRACT_FROM => 'lib/VLC/XS.pm' ,
  AUTHOR        => 'James Axl <jamesaxl@falseking.org>' ,
  # TODO: Modify into authors list
  LICENSE       => 'perl' ,
  test          => { 'TESTS' => 't/*.t' , } ,
  LIBS          => [ '-lvlc' ] ,
  DEFINE        => '' ,
  INC           => '-I.' ,
);
