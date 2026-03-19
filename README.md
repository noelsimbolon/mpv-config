# mpv config

![mpv logo](https://raw.githubusercontent.com/mpv-player/mpv.io/master/source/images/mpv-logo-128.png)

## Overview

**mpv** is a free (as in freedom and free beer), open-source, and cross-platform media player. It supports
a wide variety of media file formats, audio and video codecs, and subtitle types.

This repo contains my personal mpv configurations and scripts that I use and are significantly better than default mpv, VLC, and MPC. Before installing, please take your time to read this whole README as common issues can be easily solved by simply reading carefully.


## Preview

[![preview.png](https://i.postimg.cc/8zNHHPHy/preview.png)](https://postimg.cc/VdZnsw2M)

## Installation

### Windows

Here are the steps to install mpv and to use my configuration files on Windows:
* Download the latest 64bit mpv Windows build by shinchiro from [mpv.io/installation](https://mpv.io/installation/) or directly from [here](https://sourceforge.net/projects/mpv-player-windows/files/) and extract it wherever you please. This is now your mpv folder
* Run `mpv-install.bat`, which is located in `installer` folder, with administrator priviledges by right-clicking and selecting Run as administrator
* Download this repository as a ZIP file (or you can clone it using git)
* Create a folder named `portable_config` (**this is important**), located at the same directory as `mpv.exe`
* Extract or copy the contents of this repository that you have downloaded to the `portable_config` folder
* To make some scripts work, you need to modify them from the release a little bit:
  * In order for the `mpv-gif.lua` script to work, it requires [FFmpeg](https://ffmpeg.org/) with libass enabled and accessible via terminal. See the [installation instructions](https://github.com/Scheliux/mpv-gif-generator#installation) from the script's source repository for further info.
  * **(Optional)** By default, the `mpv-gif.lua` script saves GIFs to `C:/Program Files/mpv/gifs`. To modify this, open `gif.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `dir`, which is output directory for GIFs, as you please. For example `dir="C:/Users/USERNAME/Pictures/mpv-gifs"`.
* **(Optional)** Make your own mpv configuration. You can do that by modifying my configuration files and/or making your own from scratch or modifying others' configurations. Check out the [useful links](#useful-links) section for mpv configuration guides.
* You're all set up.

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

* Download this repository as a ZIP file (or you can clone it using git) and extract/copy it to your standard mpv configuration directory which is `~/.config/mpv`
* Some things to highlight:
  * In order for the `mpv-gif.lua` script to work, it requires [FFmpeg](https://ffmpeg.org/) with libass enabled and accessible via terminal. See the [installation instructions](https://github.com/Scheliux/mpv-gif-generator#installation) from the script's source repository for further info.
  * **(Optional)** By default, the `mpv-gif.lua` script saves GIFs to `~/Videos/mpv-gifs`. To modify this, open `gif.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `dir`, which is output directory for GIFs, as you please. For example `dir="~/Videos"`.
* **(Optional)** Make your own mpv configuration. You can do that by modifying my configuration files and/or making your own from scratch or modifying others' configurations. Check out the [useful links](#useful-links) section for mpv configuration guides.
* You're all set up.

## Scripts

Scripts from external sources:

* audio-visualizer.lua ([source](https://github.com/mfcc64/mpv-scripts#visualizerlua))\
  Various audio visualization. It only works if you open audio files.
  
* autoload.lua ([source](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua))\
  Automatically load playlist entries before and after the currently playing file, by scanning the directory.

* copy-timestamp.lua ([source](https://github.com/linguisticmind/mpv-scripts/tree/master/copy-timestamp))\
  Copies current timecode in HH:MM:SS.MS format to clipboard. Cross-platform (Mac, Windows, Linux).

* cycle-commands.lua ([source](https://github.com/CogentRedTester/mpv-scripts#cycle-commands))\
  Cycles through a series of commands on a keypress. Each iteration of the cycle can contain as many commands as one wants. Syntax details are at the top of the file.

* cycle-profile.lua ([source](https://github.com/CogentRedTester/mpv-scripts#cycle-profile))\
  Cycles through a list of profiles sent via a script message and prints the profile-desc to the OSD. More details at the top of the file.

* modernz.lua ([source](https://github.com/Samillion/ModernZ))\
  A modern OSC UI replacement for MPV that retains the functionality of the default OSC.

* mpv-gif.lua ([source](https://github.com/Scheliux/mpv-gif-generator))\
  Script to generate GIFs from video playback. Requires FFmpeg with libass enabled. The exporting GIFs with subtitled currently doesn't work properly.

* playlistmanager.lua ([source](https://github.com/jonniek/mpv-playlistmanager))\
  Allows you to see and interact with your playlist in an intuitive way.

* seek-to.lua ([source](https://github.com/dexeonify/mpv-config/blob/main/scripts/seek-to.lua))\
  Seek to an absolute timestamp specified via keyboard input or pasted from clipboard.

* sponsorblock-minimal.lua ([source](https://codeberg.org/jouni/mpv_sponsorblock_minimal))\
  Skip sponsor segments in YouTube videos.

* thumbfast.lua ([source](https://github.com/po5/thumbfast))\
  High-performance on-the-fly thumbnailer for mpv. **The script does not display thumbnails on its own**, it is meant to be used alongside a UI script that calls thumbfast.

Configuration files for these scripts can be found in the `script-opts` folder. I also modified some of these scripts' default keybindings. To see my modifications, look for script keybindings in `input.conf`.

## Shaders

The shaders included in the `shaders` folder:

* ArtCNN_C4F32 ([source](https://github.com/Artoriuz/ArtCNN/blob/main/GLSL/ArtCNN_C4F32.glsl))\
  Used for luma upscaling.

* nnedi3-nns128-win8x4 ([source](https://github.com/bjin/mpv-prescalers/tree/master))\
  Used for luma upscaling.

Use shaders based on your preference and system capabilities. For more info about shaders, read the resources in the [useful links](#useful-links) section.

## Useful Links

* [mpv tutorial](https://thewiki.moe/tutorials/mpv/) by The Wiki
* [mpv.conf guide](https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/) by iamscum
* [mpv Configuration Guide for Watching Videos](https://kokomins.wordpress.com/2019/10/14/mpv-config-guide/) by Kokomins
* [mpv Resampling](https://artoriuz.github.io/blog/mpv_upscaling.html) by João Vitor Chrisóstomo

## Official Links

* [mpv homepage](https://mpv.io/)  
* [mpv wiki](https://github.com/mpv-player/mpv/wiki)
* [mpv FAQ](https://github.com/mpv-player/mpv/wiki/FAQ)
* [mpv manual](https://mpv.io/manual/stable/)
* [mpv User Scripts](https://github.com/mpv-player/mpv/wiki/User-Scripts)
