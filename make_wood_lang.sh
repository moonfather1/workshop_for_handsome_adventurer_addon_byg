

if [[ "$1" == "" || "$1" == "help" || "$1" == "--help" || "$1" == "-h" || "$1" == "/?" ]];
  then echo "Parameter 1: short wood name (example oak or mangrove)"
  exit
fi
shortname="$1"

if [[ "$2" == "" ]];
  then echo "Parameter 2: addon mod id (your mod)"
  exit
fi
addon_modid="$2"

if [[ "$3" == "" ]];
  then echo "Parameter 3: wood mod id (where the planks come from)"
  exit
fi
wood_modid="$3"


# language. only english will work right, others obviously need manual edits.

mkdir -p src/main/resources/assets/${addon_modid}/lang
if [[ -e "src/main/resources/assets/${addon_modid}/lang/en_us.json" ]];
  then
    content="	\"item.workshop_for_handsome_adventurer.workstation_placer_birch\": \"Workstation (birch)\",||	\"block.workshop_for_handsome_adventurer.simple_table_birch\": \"Crafting Table (birch)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_double_birch\": \"Tool Rack (birch, triple)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_framed_birch\": \"Tool Rack (birch, framed)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_pframed_birch\": \"Tool Rack (birch, partly framed)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_single_birch\": \"Tool Rack (birch, single)\",|	\"block.workshop_for_handsome_adventurer.potion_shelf_birch\": \"Potion Shelf (birch)\""
	content="${content//birch/$shortname}"
    sed "s/\"$/\",||    $content/g" src/main/resources/assets/${addon_modid}/lang/en_us.json  | tr '|' '\n' > src/main/resources/assets/${addon_modid}/lang/en_us.json1; mv -f src/main/resources/assets/${addon_modid}/lang/en_us.json1 src/main/resources/assets/${addon_modid}/lang/en_us.json
	unset content
  else
    cp sample-assets/lang.json src/main/resources/assets/${addon_modid}/lang/en_us.json
    sed -i "s/birch/${shortname}/g" src/main/resources/assets/${addon_modid}/lang/en_us.json
    sed -i "s/workshop_for_handsome_adventurer/${addon_modid}/g" src/main/resources/assets/${addon_modid}/lang/en_us.json
fi



echo "done"






