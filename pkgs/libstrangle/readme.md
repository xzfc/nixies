# Notes

The utility provides single executable that handles both i686 and x86_64 binaries.

This can be convinient for the user, but there is a drawback: the utility is only buildable on x86_64.

So, for nixpkgs packaging purposes, maybe it is a good idea to build a single derivation per architecture (i686, x86_64, aarch64, etc) instead.

I'm not interested in doing this at the moment, but maybe someone will take it up.

# Testing

Check if it works both on i686 and x86_64 binaries:

```sh
THIS="with import <nixpkgs> {}; callPackage ./default.nix { }"
nix-shell -p glxinfo "$THIS" --run 'strangle 6 glxgears'
nix-shell -p '(import <nixpkgs> {system="i686-linux";}).glxinfo' "$THIS" --run 'strangle 6 glxgears'
```
