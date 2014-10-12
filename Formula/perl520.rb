require 'formula'

class Perl520 < Formula
  homepage 'http://www.perl.org/'
  url "http://www.cpan.org/src/5.0/perl-5.20.1.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/p/perl/perl_5.20.1.orig.tar.bz2"
  sha1 "cd424d1520ba2686fe5d4422565aaf880e9467f6"

  head "git://perl5.git.perl.org/perl.git", :branch => "blead"

  keg_only 'System provides Perl. Also conflicts with other Perl versions.'

  option 'use-dtrace', 'Build with DTrace probes'
  option 'no-test', 'Don\'t do a make test prior to install'

  def install
    args = [
      '-des',
      "-Dprefix=#{prefix}",
      "-Dman1dir=#{man1}",
      "-Dman3dir=#{man3}",
      '-Duseshrplib',
      '-Duselargefiles',
      '-Dusethreads'
    ]

    args << '-Dusedtrace' if build.include? 'use-dtrace'

    system './Configure', *args
    system "make"
    system "make test" unless build.include? 'no-test'
    system "make install"
  end
end
