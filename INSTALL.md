## Installation

Please let us know if these instructions are insufficient or if you needed to
do any installation steps not listed explicitly.

We recommend using Linux or OSX on a computer with at least 1 GB of memory.

On Ubuntu, if the K Framework has already been installed (from here:
<https://github.com/kframework/k/releases/tag/latest>), the
installation process for our C semantics can be summarized as:
```
$ cd ~
$ git clone --depth=1 https://github.com/kframework/c-semantics.git
$ sudo apt-get install build-essential libxml-libxml-perl libstring-escape-perl ocaml graphviz
$ sudo cpan -i Text::Diff DBI Getopt::Declare
$ cd c-semantics
$ make
$ export PATH=$PATH:~/c-semantics/dist
```

### 1. Install basic dependencies.
- The GNU C compiler (GCC) and Make. On OSX, these programs are generally part
  of XCode. On Ubuntu, these programs are part of the "build-essential" package
  and can be installed with the following:
```
$ sudo apt-get install build-essential
```
- If using Windows, you'll probably want to install cygwin.

### 2. Install Perl 5 and required modules.
- Perl 5 will likely already be installed on most Linux and Mac OS X machines.
  But if not, use your package manager to install it.
- For Windows, see here: <http://www.perl.org/get.html>
- Install the following Perl modules using `cpan` (or `ppm` with ActiveState
  Perl in Windows):
    - Getopt::Declare
    - MIME::Base64
    - XML::LibXML::Reader
    - String::Escape

To install these modules using cpan:
```
$ sudo cpan -i Text::Diff DBI Getopt::Declare
```

We also need the XML::LibXML::Reader Perl module. The easiest way to install
this module seems to be through the package manager. On Ubuntu:
```
$ sudo apt-get install libxml-libxml-perl
```

### 3. Install OCaml.
- We use a modified version of the C parser from the CIL project, which is
  written in OCaml.
- We also now default to using O'Caml to execute the C semantics.

For execution the unreleased 4.03 is required, and compiling the semantics
uses ocamlfind to locate require O'Caml packages.
This is most easily managed with opam - https://opam.ocaml.org/
The required O'Caml version can be installed with `opam switch 4.03+trunk`,
then switch to that environment  by logging back in or running
`` eval `opam config env` ``, and install further dependencies with

    opam install ocamlfind
    opam install zarith

Finally, you need to install the mlgmp library by asking Dwight Guth for updated sources which support some extra functions (this will hopefully be merged upstream soon).

To check if OCaml is installed:
```
$ ocamlfind ocamlopt -version
        Objective Caml version 4.03.0+dev10-2015-07-29

# 
```

(Press ctrl-d to exit.)

(For the parser alone versions 3.11, 3.12, and 4.00 all work, probably many
more as well, and no special dependency handling is required.
Installing with your OS package manger or from https://ocaml.org/ will work.
On Ubuntu, `apt-get install ocaml`)

For modifying the semantics, compilation times can be reduced further by
modifying the O'Caml compiler to lower some hardcoded optimization settings.
Please contact Dwight Guth or ask the project members for details.

### 4. Install K.
- This version of the C semantics should be compatible with the latest version
  of the K Framework (<https://github.com/kframework/k>). See
  <http://kframework.org> for download and installation details.

### 5. Install optional packages.
- You may want to install Graphviz (dot), for generating images of the state
  space when searching programs.
- You can probably do this with your package manager. On Ubuntu:
```
$ sudo apt-get install graphviz
```

To check if dot is installed:
```
$ which dot
/usr/bin/dot
```

### 6. Download our C semantics.
Use the following command if `git` is installed:
```
$ git clone --depth=1 https://github.com/kframework/c-semantics.git
```
Otherwise, download the latest stable version from github here:
<https://github.com/kframework/c-semantics/releases/tag/latest>

### 7. Build our C tool.
- Ensure `kompile` and `krun` are included in your `$PATH`. For example, if you
  downloaded the K Framework to `~/k` (and add this to your `~/.bashrc` to make
  this permanent):
```
$ export PATH=$PATH:~/k/dist/bin
```
- Run `make` in the project root directory.
- This should take between 1 and 5 minutes on non-windows machines, and up to
  10 minutes on windows.
- The `make` process creates a `dist/` directory which you can copy elsewhere
  to install the C tool, or simply leave it where it is. Either way, you will
  probably want to add it to your `$PATH`:
```
$ export PATH=$PATH:/path/to/c-semantics/dist
```
      
To check if kcc is behaving correctly:
```
$ dist/kcc tests/unitTests/helloworld.c
$ ./a.out 
Hello world
```

See [README.md](README.md) for a summary of the features supported by the `kcc`
tool.

