class Rebar3 < Formula
  desc "Erlang build tool"
  homepage "http://www.rebar3.org"

  devel do
    url "https://github.com/rebar/rebar3/archive/beta-1.tar.gz"
    version "3.0.0-beta-1"
    sha256 "94525dab9e3a50a126be60c86671f35a73dec960eac52b79b03003f692f69864"

    depends_on "erlang"
  end

  def install
    system "./bootstrap"
    bin.install "rebar3"
  end

  test do
    system bin/"rebar3", "--version"
  end
end