# mpv config

![mpv logo](https://raw.githubusercontent.com/mpv-player/mpv.io/master/source/images/mpv-logo-128.png)

## Overview

**mpv** is a free (as in freedom and free beer), open-source, and cross-platform media player. It supports
a wide variety of media file formats, audio and video codecs, and subtitle types.

These are my personal configurations and scripts that are significantly better than default mpv, VLC, and MPC. Before installing, please take your time to read this whole README as common issues can be easily solved by doing this.

## Preview

[![preview.png](https://i.postimg.cc/8PpZnf4D/preview.png)](https://postimg.cc/MXL0nTgr)

## Installation (on Windows)

Here are the steps to install mpv and to use my configuration files on Windows:
* Download the latest 64bit mpv Windows build by shinchiro from [mpv.io/installation](https://mpv.io/installation/) or directly from [here](https://sourceforge.net/projects/mpv-player-windows/files/) and extract it wherever you please. This is now your mpv folder
* Run `mpv-install.bat`, which is located in `installer` folder, with administrator priviledges by right-clicking and selecting Run as administrator
* Download the `windows.zip` file from this repo's [latest release](https://github.com/noelsimbolon/mpv-config/releases/latest) and extract it to your mpv folder. Make sure the configuration folder name is `portable_config` (**this is important**) and is located at the same directory as `mpv.exe`
* To make some scripts work, you need to modify them from the release a little bit:
  * For `discord.lua` to work, open `discord.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `binary_path` which is the full path (not a relative path) to `mpv-discord.exe`. For example `binary_path=C:\YOUR\MPV\FOLDER\PATH\portable_config\bin\mpv-discord.exe`. Make sure you're not using any quotation marks before and after the path.
  * In order for the `mpv-gif.lua` script to work, it requires [FFmpeg](https://ffmpeg.org/) with libass enabled and accessible via terminal. See the [installation instructions](https://github.com/Scheliux/mpv-gif-generator#installation) from the script's source repository for further info.
  * **(Optional)** By default, the `mpv-gif.lua` script saves GIFs to `C:/Program Files/mpv/gifs`. To modify this, open `gif.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `dir`, which is output directory for GIFs, as you please. For example `dir="C:/Users/USERNAME/Pictures/mpv-gifs"`.
* **(Optional)** Make your own mpv configuration. You can do that by modifying my configuration files and/or making your own from scratch or modifying others' configurations. Check out the [useful links](#useful-links) section for mpv configuration guides.
* You are now a proud user of the best media player

After following the steps above (without any optional steps), your mpv folder should have this structure (on Windows):

```
├── doc
│   ├── manual.pdf
│   └── mpbindings.png
│
├── installer
│   ├── configure-opengl-hq.bat
│   ├── mpv-icon.ico
│   ├── mpv-install.bat                       # Run this with administrator priviledges to install mpv
│   ├── mpv-uninstall.bat                     # Run this with administrator priviledges to uninstall mpv
│   └── updater.ps1
│
├── mpv
│   └── fonts.conf
│
├── portable_config                           # This is where this repository goes
│   ├── bin
│   │   └── mpv-discord.exe                   # mpv-discord binary
│   │
│   ├── fonts
│   │   └── Material-Design-Iconic-Font.ttf
│   │
│   ├── script-opts                           # Contains configuration files for scripts
│   │   ├── discord.conf
│   │   ├── gif.conf
│   │   └── osc.conf
│   │
│   ├── scripts
│   │   ├── audio_visualizer.lua              # Script to visualize audio playback when playing audio files
│   │   ├── autoload.lua
│   │   ├── copy-time.lua
│   │   ├── cycle-commands.lua
│   │   ├── cycle-profile.lua
│   │   ├── discord.lua                       # Script for Discord rich presence
│   │   ├── mordenx.lua                       # Script for modern OSC UI
│   │   ├── mpv-gif.lua                       # Script to create GIFs
│   │   ├── playlistmanager.lua
│   │   └── seek-to.lua
│   │
│   ├── shaders                               # Contains external shaders
│   │   ├── cache                             # Cause of gpu-shader-cache-dir='~~/shaders/cache' in mpv.conf (might not show at first)
│   │   │   └── ...
│   │   ├── FSRCNNX_x2_16-0-4-1.glsl
│   │   ├── KrigBilateral.glsl
│   │   ├── nnedi3-nns256-win8x4.hook
│   │   └── SSimDownscaler.glsl
│   │
│   ├── input.conf
│   └── mpv.conf
│
├── d3dcompiler_43.dll
├── mpv.com
├── mpv.exe                                   # The mpv executable file
└── updater.bat                               # Run this with administrator priviledges to update your mpv to the latest version
```

## Installation (on Arch Linux)

Here are the steps to install mpv and to use my configuration files on Arch Linux:
* To install mpv, use the package manager that comes with your Linux distribution. The package name for mpv might also vary depending on your Linux distribution. Here, I will make Arch Linux, which comes with `pacman` as its package manager, as an example
* Install mpv using `pacman`
  ```
  sudo pacman -S mpv
  ```
* Download the `linux.zip` file from this repo's [latest release](https://github.com/noelsimbolon/mpv-config/releases/latest) and extract it to your standard mpv configuration directory which is `~/.config/mpv`
* To make some scripts work, you need to modify them from the release a little bit:
  * For `discord.lua` to work, open `discord.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `binary_path` which is the full path (not a relative path) to `mpv-discord` executable binary. For example `binary_path=/home/USER/.config/mpv/bin/mpv-discord`. Make sure you're not using any quotation marks before and after the path.
  * In order for the `mpv-gif.lua` script to work, it requires [FFmpeg](https://ffmpeg.org/) with libass enabled and accessible via terminal. See the [installation instructions](https://github.com/Scheliux/mpv-gif-generator#installation) from the script's source repository for further info.
  * **(Optional)** By default, the `mpv-gif.lua` script saves GIFs to `~/Videos/mpv-gifs`. To modify this, open `gif.conf`, which is located in `portable_config/script-opts` folder, with a text editor and specify the `dir`, which is output directory for GIFs, as you please. For example `dir="~/Videos"`.
* **(Optional)** Make your own mpv configuration. You can do that by modifying my configuration files and/or making your own from scratch or modifying others' configurations. Check out the [useful links](#useful-links) section for mpv configuration guides.
* You are now a proud user of the best media player

## Scripts

Scripts used:
* [audio-visualizer.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/audio_visualizer.lua) —
  [source](https://github.com/mfcc64/mpv-scripts#visualizerlua)\
  Various audio visualization. The default keybind to cycle visualizer is <kbd>c</kbd>. It only works if you open audio files.
  
* [autoload.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/autoload.lua) —
  [source](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua)\
  Automatically load playlist entries before and after the currently playing file, by scanning the directory.

* [copy-time.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/copy-time.lua) — [source](https://github.com/linguisticmind/mpv-scripts/tree/master/copy-time)\
  Copies current timecode in HH:MM:SS.MS format to clipboard. Cross-platform (Mac, Windows, Linux).

* [cycle-commands.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/cycle-commands.lua) —
  [source](https://github.com/CogentRedTester/mpv-scripts#cycle-commands)\
  Cycles through a series of commands on a keypress. Each iteration of the cycle can contain as many commands as one wants. Syntax details are at the top of the file.

* [cycle-profile.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/cycle-profile.lua) —
  [source](https://github.com/CogentRedTester/mpv-scripts#cycle-profile)\
  Cycles through a list of profiles sent via a script message and prints the profile-desc to the OSD. More details at the top of the file.

* [mpv-discord.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/discord.lua) —
  [source](https://github.com/tnychn/mpv-discord)\
  A cross-platform Discord Rich Presence integration for mpv with no external dependencies. Consists of a Go binary for updating the presence and a Lua script for launching it.

* [mordenx.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/mordenx.lua) —
  [source](https://github.com/cyl0/mpv-osc-morden-x)\
  A modern OSC UI replacement for MPV that retains the functionality of the default OSC.

* [mpv-gif.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/mpv-gif.lua) —
  [source](https://github.com/Scheliux/mpv-gif-generator)\
  Script to generate GIFs from video playback. Requires FFmpeg with libass enabled. The exporting GIFs with subtitled currently doesn't work properly.

* [playlistmanager.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/playlistmanager.lua) —
  [source](https://github.com/jonniek/mpv-playlistmanager)\
  Allows you to see and interact with your paylist in an intuitive way.

* [seek-to.lua](https://github.com/noelsimbolon/mpv-config/blob/main/scripts/seek-to.lua) —
  [source](https://github.com/dexeonify/mpv-config/blob/main/scripts/seek-to.lua)\
  Seek to an absolute timestamp specified via keyboard input or pasted from clipboard.

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
* [mpv manual](https://mpv.io/manual/master/)

## To Do

- [x] Create a branch for configurations to be used in linux-based machines