require 'formula'

class AppleGcc42 < Formula
  homepage 'http://www.opensource.apple.com/source/gcc/gcc-5666.3/'
  url 'http://www.opensource.apple.com/tarballs/gcc/gcc-5666.3.tar.gz'
  version '4.2.1-5666.3'
  sha1 '292a0cfcfdc061cb083658efd9a3812a120a1f50'

  option 'with-gfortran-symlink', 'Provide gfortran symlinks'

  depends_on :macos => :lion

  def install
    ENV.j1
    inreplace 'build_gcc', '--enable-werror', '' if ENV.compiler == :clang
    hosts = "x86_64"
    targets = "i386 x86_64"
    system "./build_gcc", hosts, targets, Dir.pwd, HOMEBREW_PREFIX

    if build.include? 'with-gfortran-symlink'
      system "ln -sf #{bin}/gfortran-4.2 #{bin}/gfortran"
      system "ln -sf #{man1}/gfortran-4.2.1 #{man1}/gfortran.1"
    end
  end

  def caveats
    <<-EOS.undent
      NOTE:
      This formula provides components that were removed from XCode in the 4.2
      release. There is no reason to install this formula if you are using a
      version of XCode prior to 4.2.

      All compilers have a `-4.2` suffix. A GFortran compiler is also included.
    EOS
  end
end
