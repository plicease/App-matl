# matl [![Build Status](https://travis-ci.org/plicease/App-matl.svg)](http://travis-ci.org/plicease/App-matl)

Perl mathy REPL

# SYNOPSIS

```
% matl
matl> 1+2
3
matl> [1,2,3]
-
  - 1
  - 2
  - 3
matl> 
```

# DESCRIPTION

`matl` is a little REPL that turns on some things that are handy for doing mathy things with
arbitrary position integers or floats as appropriate.  For simple non reference defined values
(strings and numbers) the result is printed out.  For more complicated data structures, output
is displayed using [YAML](https://metacpan.org/pod/YAML) with `$YAML::Stringify` turned on.  Stringification is turned on
so that big number classes [Math::BigInt](https://metacpan.org/pod/Math::BigInt) and [Math::BigFloat](https://metacpan.org/pod/Math::BigFloat) are easy to read.  These
classes are used by default via the [bignum](https://metacpan.org/pod/bignum) pragma for integer and floating point values.

The `@_` is set to the previous line's result and `$_` is set to the previous line first value.

Press ^D (or whatever `EOF` is on your platform) to quit.  Input is `eval`'d in the `main` namespace.

- [autodie](https://metacpan.org/pod/autodie) `:all` is imported
- [List::SomeUtils](https://metacpan.org/pod/List::SomeUtils) `:all` is imported
- The `cpanm` function is provided to install modules from the REPL.
- The `_` function returns the value of $\_, and thus is a shortcut for the previous line's value.

# SEE ALSO

- [Shell::Perl](https://metacpan.org/pod/Shell::Perl)
- [perldebug](https://metacpan.org/pod/perldebug)
- ... plus too many other REPLs to name in such a small space

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
