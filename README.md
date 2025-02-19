# Balatro Mobile-EM-Edition (my initials) 
Fork of the original project by Blake502 but I am adding files to make everything easier because the wall of text in the github issues section is going to get someone lost. 

The goal of this project is simplify the installation of the modded *Balatro* apk  on their mobile devices and transfer their mods in the correct format.
Mods are not _officially_ supported, [but with my guide they are as easy to install as they are on PC](https://github.com/blake502/balatro-mobile-maker/issues/147#issuecomment-2652346316) 

**this link goes to my text writeup if you don't feel comfortable running my batch scripts^^**


## How to Start 
From my write up at https://github.com/blake502/balatro-mobile-maker/issues/147#issuecomment-2652346316
Run the game with mods on PC. Get to the splash screen and ALT+F4 the game, as long as it loads up with the mods to the title you're good.
Run balatro-mobile-maker with your phone plugged in. create the apk using your preferences from the terminal. (dont worry about external storage patch)

 - Download  [**balatro-mobile-maker**](https://github.com/blake502/balatro-mobile-maker/releases).
 - Leave it in downloads. (For real it doesn't matter. It assumes Balatro is installed at C:\Program Files (x86)\Steam\steamapps\common\Balatro)
 - Run **balatro-mobile-maker** from downloads folder
 ``` 
 Would you like to automatically clean up once complete? (y/n):
y
Would you like to enable extra logging information? (y/n):
n
Would you like to build for Android? (y/n):
y
Would you like to build for iOS (experimental)? (y/n):
n
```
 - Follow the prompts to apply optional patches. If you're unsure, always select "Y". My configurations are below the optional patch section 

 ## Optional Patches
- **FPS Cap** — Caps FPS to a desired number (set 60 or leave blank for your device's refresh rate)
- **Landscape Orientation** — Locks the game to landscape orientation (You're gonna almost certainly need this)
- **High DPI** — Enables [High DPI graphics mode in Love](https://love2d.org/wiki/love.window.setMode) (According to this link it is always enabled on android with Love so it doesn't matter)
- **CRT Shader Disable** — Disables the CRT Shader (REQUIRED for Pixel)
```
Would you like to apply the FPS cap patch? (y/n):
y
Please enter your desired FPS cap (or leave blank to set to device refresh rate):

Would you like to apply the landscape orientation patch (required for high DPI)? (y/n):
y
Would you like to apply the high DPI patch (recommended for devices with high resolution)? (y/n):
y
Would you like to apply the CRT shader disable patch? (Required for Pixel and some other devices!) (y/n):
y
```
# INSTALLING (it will install all tools required)
```
Would you like to automaticaly install balatro.apk on your Android device? (y/n):
y
Is your Android device connected to the host with USB Debugging enabled? (y/n):
y
Attempting to install. If prompted, please allow the USB Debugging connection on your Android device.
Would you like to transfer saves from your Steam copy of Balatro to your Android device? (y/n):


I WOULD RECOMMEND HITTING 'N' or PAUSING HERE
```
 ### For Android:
 The progrram will spit out a 'balatro.apk' into your downloads folder to which it will not delete if you choose to cleanup the files further into the mobile maker. 
 
 - if your mod folder is still in the "pc configuration" meaning you can run it on pc anytime you like without having to move/delete anything (no previous mobile maker formatting) then you should pause at the steam transfer stage and run the mobile makers save functions after the next few steps
 
 ## GETTING MODS IN ORDER (I have created TWO batch scripts to do EXACTLY these steps and have verified on my own PERSONAL main pc. I recommend using them but here is the process)
 
- Open file explorer, navigate to `C:\Users\[YOURNAME]\AppData\Roaming\Balatro\Mods\lovely\dump`

 - `CTRL+A` and then `CTRL+X` on the entire contents of the `\dump\` folder mentioned.

- go back to `C:\Users\[YOURNAME]\AppData\Roaming\Balatro\ `  `CTRL+V` all the files into that folder alongside/WITH the Mods folder not IN.
- The files `nativefs.lua` from `C:\Users\[YOURNAME]\AppData\Roaming\Balatro\Mods\smods\libs\nativefs` and  `json.lua` from `C:\Users\YOURNAME\AppData\Roaming\Balatro\Mods\smods\libs\json` move them to (i didnt copy i used `ctrl+x`) `C:\Users\[YOURNAME]\AppData\Roaming\Balatro` 
- Create a file in the same Balatro folder called "lovely.lua" and paste this  : 

```
 return {
  repo = "https://github.com/ethangreen-dev/lovely-injector",
  version = "0.7.1",
  mod_dir = "/data/data/com.unofficial.balatro/files/save/game/Mods",
}
```

I just changed the version to the latest and directed it to this folder which worked for me^^
- `ctrl+x`  the file  `version.lua` from your `C:\Users\YOURNAME\AppData\Roaming\Balatro\Mods\smods` then  the go to `C:\Users\YOURNAME\AppData\Roaming\Balatro` creating a few folder called `SMODS` all caps and paste the file into that SMODS folder. 

- Make sure you remember the [balatro mobile compat mod](https://github.com/eeve-lyn/BalatroMobileCompat)

IF YOU DON'T USE TALISMAN SKIP TO THE NEXT STEP AFTER THIS \/

- if you have any mods that use talisman then you need to create a folder under `C:\Users\YOURNAME\AppData\Roaming\Balatro\`  called  `nativefs`  and  `CTRL+X`  the nativefs.lua from `C:\Users\Ethan\AppData\Roaming\Balatro\Mods\Talisman`  into the new  `C:\Users\YOURNAME\AppData\Roaming\Balatro\nativefs`  folder. 

*At this point, all of the files are in the correct location on PC. YOU SHOULD NOW BE READY TO TRANSFER YOUR SAVES FROM THE TERMINAL OF MOBILE MAKER.*



 ## Recogition (in no particular order)
 - Aurelius7309 for [their initial writeup](https://github.com/blake502/balatro-mobile-maker/issues/137#issue-2773913522) (mine had different mod locations on android so that messed me up)
 - Eeve-lyn for their [Mobile-compat mod](https://github.com/eeve-lyn/BalatroMobileCompat) (this applies all patches made by the mobile maker to the game, loaded from the mod folder since the mods create overrides)
 - ChromaPIE for their input on the [Lovely dumps](https://github.com/blake502/balatro-mobile-maker/issues/83#issuecomment-2132778187)
 - DaemonFerns for their [Betmma Mobile Patch](https://github.com/blake502/balatro-mobile-maker/issues/137#issuecomment-2651800303) and various other support
 - [Every contributor](https://github.com/blake502/balatro-mobile-maker/)
 - Developers of [uber-apk-signer](https://github.com/patrickfav/uber-apk-signer)
 - Anyone else I bothered and missed mentioning in the github issue thread #137 or discord
 - MOTHER FUCKIN CHATGPT holy shit I can't tell you how clutch this thing came for debugging crashes and suggesting file changes. 



## Notes
 - This script assumes that **Balatro.exe** or **Game.love** is located in the default *Steam* directory. ~If it is not, simply copy your **Balatro.exe** or **Game.love** to the same folder as **balatro-mobile-maker**~ please don't do this lol just let it run from assumed locations
 - This script will automatically download [7-Zip](https://www.7-zip.org/)
 ### For Android:
 - This script will automatically download [OpenJDK](https://www.microsoft.com/openjdk)
 - This script will automatically download [APK Tool](https://apktool.org/)
 - This script will automatically download [uber-apk-signer](https://github.com/patrickfav/uber-apk-signer/)
 - This script will automatically download [love-11.5-android-embed.apk](https://github.com/love2d/love-android/)
 - This script will automatically download [Balatro-APK-Patch](https://github.com/blake502/balatro-mobile-maker/releases/tag/Additional-Tools-1.0)
 - This script can automatically download [Android Developer Bridge](https://developer.android.com/tools/adb) (optional)
 ## License
 - [7-Zip](https://github.com/ip7z/7zip/blob/main/DOC/License.txt) is licensed under the GNU LGPL license.
 - This project uses [APKTool](https://github.com/iBotPeaches/Apktool/blob/master/LICENSE.md)
 - This project uses [uber-apk-signer](https://github.com/patrickfav/uber-apk-signer/blob/main/LICENSE)
 - This project uses [LÖVE](https://github.com/love2d/love/blob/main/license.txt)
 - This project uses [OpenJDK](https://www.microsoft.com/openjdk)
