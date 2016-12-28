class Docopts < Formula
  include Language::Python::Virtualenv

  desc "Shell interpreter for docopt, the CLI description language."
  homepage "https://github.com/docopt/docopts"
  head "https://github.com/docopt/docopts.git"

  devel do
    # Requested addition of a tag in:
    # https://github.com/docopt/docopts/issues/10
    url "https://github.com/docopt/docopts.git",
      :revision => "4c8b652998a5ffda5068197f002b5ab5735761d6"
    version "0.6.1+fix"
  end

  depends_on :python

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/ec/6d/8ef19316f3b06c15ac648c857d18f171a65b50319f0a6c782392ad62d942/docopt-0.6.1.tar.gz"
    sha256 "71ad940a773fbc23be6093e9476ad57b2ecec446946a28d30127501f3b29aa35"
  end

  resource "docopts-tester" do
    url "https://github.com/docopt/docopts.git"
  end

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install resource("docopt")

    system "#{libexec}/bin/python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/docopts"]
  end

  test do
    resource("docopts-tester").stage do
      # Run tests using the tester provided by docopts: specify PYTHON executable
      # as specified in the documentation, then
      #
      # 163 tests pass, 1 test fail
      # See:
      # https://github.com/docopt/docopts/issues/6
      assert_match shell_output("PYTHON=#{libexec}/bin/python ./language_agnostic_tester.py ./testee.sh | \
            tail -n1 | tr -cd '.' | wc -c").to_s.chomp.to_i, 163
    end
  end
end
