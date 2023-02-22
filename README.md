# Personal website: louis.feuvrier.org

I'll be honest, it would be weird for you to work on this if you're not me...
but since you're here: you'll need [nix](https://nixos.org/download.html) for
this build system to work out of the box. Once you have it:

To build the website, try:

```
$ nix build
```

You can build the resume only with `$ nix build .#resume` but that would make
little sense since it is recursively built for use by the website. If said
website is at `result/`, the resume is at `result/louis_feuvrier-resume.pdf`

To hot-reload the website in your browser while iterating on it, try:

```
$ nix develop
$ cd web/
$ zola serve &
$ $BROWSER http://127.0.0.1:1111
```
