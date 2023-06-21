
# Workshop for handsome adventurer - addon sample

So, you have a mod that adds new wood types to Minecraft. Obviously, you want to support an amazing mod that is [Workshop for handsome adventurer](https://modrinth.com/mod/workshop-for-handsome-adventurer). Good call.

Do not worry, it's super easy.

Prerequisites: bash-like terminal (if you're on windows, you have one that comes with git or just install mingw), sed and tr.

Steps:
1. make a copy of [this mod](https://github.com/moonfather1/workshop_for_handsome_adventurer_addon_sample)'s source code as your addon mod.
   1. change mod id in build.gradle (on 1.18 and 1.19; it's in build.properties on 1.20 onward)
   2. change mod id in constants.java
   3. change mod id in mods.toml (on 1.18 and 1.19)
   4. add a dependency to target mod (the one that adds woods). if you don't know how to do it find WfHA author on discord.
2. in registration.java there is a line saying woodTypes = { "acacia" }  or something like that. edit it to remove acacia and add your wood types (short names only). do not worry - we are done editing the source code.
3. delete everything from assets and data directories inside resources directory. we will generate everything.
4. get **wood_script.tar** from this repository. unpack the archive into this mod's directory (next to src subdirectory).
5. run **make_wood.sh** with three parameters:
   - short wood name, like oak or mangrove. no quotes.
   - addon id (your mod id)
   - wood mod id (where logs and planks are)  
example 1: this is how we added acacia:  ./make_wood acacia workshop_for_handsome_adventurer_addon_sample minecraft  
example 2: this is how we added zelkova: ./make_wood zelkova workshop_for_handsome_adventurer_addon_byg byg
6. done. hopefully. 
   - check json files and run the game to test things....
   - if a texture is missing, open the model json file and change "log" to "stem".
   - delete two sample directories and shell script that you unpacked in step 4.
8. if english isn't your primary language, please provide translations for that language (both for the addon and the main mod). it would be most appreciated.
