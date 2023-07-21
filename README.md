# mpv config

![mpv logo](https://raw.githubusercontent.com/mpv-player/mpv.io/master/source/images/mpv-logo-128.png)

## Overview

**mpv** is a free (as in freedom and free beer), open-source, and cross-platform media player. It supports
a wide variety of media file formats, audio and video codecs, and subtitle types.

This repo contains my personal mpv configurations and scripts that I use and are significantly better than default mpv, VLC, and MPC. Before installing, please take your time to read this whole README as common issues can be easily solved by simply reading carefully.


## Preview

[![preview.png](https://i.postimg.cc/0QYzwWPn/preview.png)](https://postimg.cc/DJzfVcW4)

## Installation

### Windows

Here are the steps to install mpv and to use my configuration files on Windows:
* Download the latest 64bit mpv Windows build by shinchiro from [mpv.io/installation](https://mpv.io/installation/) or directly from [here](https://sourceforge.net/projects/mpv-player-windows/files/) and extract it wherever you please. This is now your mpv folder
* Run `mpv-install.bat`, which is located in `installer` folder, with administrator priviledges by right-clicking and selecting Run as administrator
* Download the `mpv-config-windows.zip` file from this repo's [latest release](https://github.com/noelsimbolon/mpv-config/releases/latest) and extract it to your mpv folder. Make sure the configuration folder name is `portable_config` (**this is important**) and is located at the same directory as `mpv.exe`
* To make some scripts work, you need to modify them from the release a little bit:
  * In order for the `mpv-gif.lua` script to work, it requires [FFmpeg](https://ffmpeg.org/) with libass enabled and accessible via terminal. See the [installation instructions](https://github.com/Scheliux/mpv-gif-generator#installation) from the script's source repository for further info.
  * **(Optional)** By default, the `mpv-gif.lua` script saves GIFs to `C:/Program Files/mpv/gifs`. To modify this, open `gif.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `dir`, which is output directory for GIFs, as you please. For example `dir="C:/Users/USERNAME/Pictures/mpv-gifs"`.
* **(Optional)** Make your own mpv configuration. You can do that by modifying my configuration files and/or making your own from scratch or modifying others' configurations. Check out the [useful links](#useful-links) section for mpv configuration guides.
* You're all set up. Go watch some videos!

### Linux

Here are the steps to install mpv and to use my configuration files on Linux:

* Install mpv and xclip (clipboard CLI interface) using the package manager that comes with your Linux distribution. xclip is needed for [copy-time.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/copy-time.lua) and [seek-to.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/seek-to.lua) scripts to work properly. The package name for mpv and xclip might also vary depending on your Linux distribution. Here, I will make Arch Linux, that comes with `pacman` as its package manager, as an example
  
  ```
  sudo pacman -S mpv xclip
  ```

  If you, for example, use Fedora Linux, that comes with `dnf` as its package manager, you can install mpv and xclip with the following command instead.
  ```
  sudo dnf install mpv xclip
  ```

  If you use other Linux distributions, please refer to the documentation of your Linux distribution's package manager on how to install packages.

* Download the `mpv-config-linux.zip` file from this repo's [latest release](https://github.com/noelsimbolon/mpv-config/releases/latest) and extract it to your standard mpv configuration directory which is `~/.config/mpv`
* To make some scripts work, you need to modify them from the release a little bit:
  * In order for the `mpv-gif.lua` script to work, it requires [FFmpeg](https://ffmpeg.org/) with libass enabled and accessible via terminal. See the [installation instructions](https://github.com/Scheliux/mpv-gif-generator#installation) from the script's source repository for further info.
  * **(Optional)** By default, the `mpv-gif.lua` script saves GIFs to `~/Videos/mpv-gifs`. To modify this, open `gif.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `dir`, which is output directory for GIFs, as you please. For example `dir="~/Videos"`.
* **(Optional)** Make your own mpv configuration. You can do that by modifying my configuration files and/or making your own from scratch or modifying others' configurations. Check out the [useful links](#useful-links) section for mpv configuration guides.
* You're all set up. Go watch some videos!

## Scripts

Scripts used:
* [audio-visualizer.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/audio_visualizer.lua) —
  [source](https://github.com/mfcc64/mpv-scripts#visualizerlua)\
  Various audio visualization. It only works if you open audio files.
  
* [autoload.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/autoload.lua) —
  [source](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua)\
  Automatically load playlist entries before and after the currently playing file, by scanning the directory.

* [copy-time.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/copy-time.lua) — [source](https://github.com/linguisticmind/mpv-scripts/tree/master/copy-time)\
  Copies current timecode in HH:MM:SS.MS format to clipboard. Cross-platform (Mac, Windows, Linux).

* [cycle-commands.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/cycle-commands.lua) —
  [source](https://github.com/CogentRedTester/mpv-scripts#cycle-commands)\
  Cycles through a series of commands on a keypress. Each iteration of the cycle can contain as many commands as one wants. Syntax details are at the top of the file.

* [cycle-profile.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/cycle-profile.lua) —
  [source](https://github.com/CogentRedTester/mpv-scripts#cycle-profile)\
  Cycles through a list of profiles sent via a script message and prints the profile-desc to the OSD. More details at the top of the file.

* [mordenx.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/mordenx.lua) —
  [source](https://github.com/cyl0/mpv-osc-morden-x)\
  A modern OSC UI replacement for MPV that retains the functionality of the default OSC.

* [mpv-gif.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/mpv-gif.lua) —
  [source](https://github.com/Scheliux/mpv-gif-generator)\
  Script to generate GIFs from video playback. Requires FFmpeg with libass enabled. The exporting GIFs with subtitled currently doesn't work properly.

* [playlistmanager.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/playlistmanager.lua) —
  [source](https://github.com/jonniek/mpv-playlistmanager)\
  Allows you to see and interact with your paylist in an intuitive way.

* [seek-to.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/seek-to.lua) —
  [source](https://github.com/dexeonify/mpv-config/blob/main/scripts/seek-to.lua)\
  Seek to an absolute timestamp specified via keyboard input or pasted from clipboard.

* [sponsorblock-minimal.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/sponsorblock-minimal.lua) — [source](https://codeberg.org/jouni/mpv_sponsorblock_minimal)\
  Skip sponsor segments in YouTube videos.

* [thumbfast.lua](https://github.com/noelsimbolon/mpv-config/blob/linux/scripts/thumbfast.lua) — [source](https://github.com/po5/thumbfast)\
  High-performance on-the-fly thumbnailer for mpv. **The script does not display thumbnails on its own**, it is meant to be used alongside a UI script that calls thumbfast.

Configuration files for these scripts can be found in the `script-opts` folder. I also modified some of these scripts' default keybindings. To see my modifications, look for script keybindings in `input.conf`.

## Shaders

The shaders included in the `shaders` folder:

* [FSRCNNX_x2_16-0-4-1](https://github.com/noelsimbolon/mpv-config/blob/main/shaders/FSRCNNX_x2_16-0-4-1.glsl) — [source](https://github.com/igv/FSRCNN-TensorFlow/releases)\
  Used for luma upscaling.
  
* [nnedi3-nns256-win8x4](https://github.com/noelsimbolon/mpv-config/blob/main/shaders/nnedi3-nns256-win8x4.hook) — [source](https://github.com/bjin/mpv-prescalers/tree/master)\
  Used for luma upscaling.

* [nnedi3-nns128-win8x4](https://github.com/noelsimbolon/mpv-config/blob/main/shaders/nnedi3-nns128-win8x4.hook) — [source](https://github.com/bjin/mpv-prescalers/tree/master)\
  Used for luma upscaling.
  
* [SSimDownscaler](https://github.com/noelsimbolon/mpv-config/blob/main/shaders/SSimDownscaler.glsl) —
  [source](https://gist.github.com/igv)\
  Used for luma downscaling.

* [KrigBilateral](https://github.com/noelsimbolon/mpv-config/blob/main/shaders/KrigBilateral.glsl) —
  [source](https://gist.github.com/igv)\
  Used for chroma upscaling and downscaling.

Use shaders based on your preference and system capabilities. For more info about shaders, read the resources in the [useful links](#useful-links) section.

## Useful Links

* [mpv manual](https://mpv.io/manual/master/)\
  Extremely useful for knowing what certain options do and what to put in `mpv.conf`
* [mpv User Scripts](https://github.com/mpv-player/mpv/wiki/User-Scripts)\
  Compilation of useful community-published scripts to be used with mpv
* [mpv.conf guide](https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/) by iamscum\
  I personally recommend this one over Kokomins'
* [mpv Configuration Guide for Watching Videos](https://kokomins.wordpress.com/2019/10/14/mpv-config-guide/) by Kokomins
* [Mathematically Evaluating mpv's Upscaling Algorithms](https://artoriuz.github.io/blog/mpv_upscaling.html) by João Vitor Chrisóstomo

## Official Links

* [mpv homepage](https://mpv.io/)  
* [mpv wiki](https://github.com/mpv-player/mpv/wiki)
* [mpv FAQ](https://github.com/mpv-player/mpv/wiki/FAQ)
* [mpv manual](https://mpv.io/manual/stable/)

## To Do

- [x] Create a branch for configurations to be used in linux-based machines
