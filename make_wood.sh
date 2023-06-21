

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

# simple table tags

mkdir -p src/main/resources/data/forge/tags/blocks
mkdir -p src/main/resources/data/forge/tags/items
if [[ -e "src/main/resources/data/forge/tags/blocks/workbench.json" ]];
  then sed "s/\"$/\",|    \"${addon_modid}:simple_table_${shortname}\"/g" src/main/resources/data/forge/tags/blocks/workbench.json  | tr '|' '\n' > src/main/resources/data/forge/tags/blocks/workbench.json1; mv src/main/resources/data/forge/tags/blocks/workbench.json1 src/main/resources/data/forge/tags/blocks/workbench.json
  else echo "{|  \"replace\": false,|  \"values\": [|    \"${addon_modid}:simple_table_${shortname}\"|  ]|}" | tr '|' '\n' > src/main/resources/data/forge/tags/blocks/workbench.json
fi
if [[ -e "src/main/resources/data/forge/tags/items/workbench.json" ]];
  then sed "s/\"$/\",|    \"${addon_modid}:simple_table_${shortname}\"/g" src/main/resources/data/forge/tags/items/workbench.json  | tr '|' '\n' > src/main/resources/data/forge/tags/items/workbench.json1; mv src/main/resources/data/forge/tags/items/workbench.json1 src/main/resources/data/forge/tags/items/workbench.json
  else echo "{|  \"replace\": false,|  \"values\": [|    \"${addon_modid}:simple_table_${shortname}\"|  ]|}" | tr '|' '\n' > src/main/resources/data/forge/tags/items/workbench.json
fi

# mineable by axe

mkdir -p src/main/resources/data/minecraft/tags/blocks/mineable
blocklist="		\"${addon_modid}:simple_table_${shortname}\",|		\"${addon_modid}:dual_table_bottom_left_${shortname}\",|		\"${addon_modid}:dual_table_bottom_right_${shortname}\",|		\"${addon_modid}:dual_table_top_left_${shortname}\",|		\"${addon_modid}:dual_table_top_right_${shortname}\",|		\"${addon_modid}:tool_rack_single_${shortname}\",|		\"${addon_modid}:tool_rack_double_${shortname}\",|		\"${addon_modid}:tool_rack_pframed_${shortname}\",|		\"${addon_modid}:tool_rack_framed_${shortname}\",|		\"${addon_modid}:potion_shelf_${shortname}\""
if [[ -e "src/main/resources/data/minecraft/tags/blocks/mineable/axe.json" ]];
  then sed "s/\"$/\",||${blocklist}/g" src/main/resources/data/minecraft/tags/blocks/mineable/axe.json  | tr '|' '\n' > src/main/resources/data/minecraft/tags/blocks/mineable/axe.json1; mv src/main/resources/data/minecraft/tags/blocks/mineable/axe.json1 src/main/resources/data/minecraft/tags/blocks/mineable/axe.json
  else echo "{|  \"replace\": false,|  \"values\": [|${blocklist}|  ]|}" | tr '|' '\n' > src/main/resources/data/minecraft/tags/blocks/mineable/axe.json
fi
unset blocklist

# block loottables

mkdir -p src/main/resources/data/${addon_modid}/loot_tables/blocks

simple_loot_table="{|  \"type\": \"minecraft:block\",|  \"pools\": [|    {|      \"rolls\": 1.0,|      \"entries\": [|        {|          \"type\": \"minecraft:item\",|          \"conditions\": [ { \"condition\": \"minecraft:survives_explosion\" } ],|          \"name\": \"%MOD%:%BLOCK%_%WOOD%\"|		}|      ]|    }|  ],|  \"functions\": [ { \"function\": \"minecraft:explosion_decay\" } ]|}"
simple_loot_table="${simple_loot_table/\%MOD\%/$2}"
simple_loot_table="${simple_loot_table/\%WOOD\%/$shortname}"

temp="${simple_loot_table}"
temp="${temp/\%BLOCK\%/workstation_placer}"
echo "${temp}" | tr '|' '\n' > src/main/resources/data/${addon_modid}/loot_tables/blocks/dual_table_primary_${shortname}.json

temp="${simple_loot_table}"
temp="${temp/\%BLOCK\%/potion_shelf}"
echo "${temp}" | tr '|' '\n' > src/main/resources/data/${addon_modid}/loot_tables/blocks/potion_shelf_${shortname}.json

temp="${simple_loot_table}"
temp="${temp/\%BLOCK\%/simple_table}"
echo "${temp}" | tr '|' '\n' > src/main/resources/data/${addon_modid}/loot_tables/blocks/simple_table_${shortname}.json

temp="${simple_loot_table}"
temp="${temp/\%BLOCK\%/tool_rack_single}"
echo "${temp}" | tr '|' '\n' > src/main/resources/data/${addon_modid}/loot_tables/blocks/tool_rack_single_${shortname}.json

tall_block_loot_table="{|  \"type\": \"minecraft:block\",|  \"pools\": [|    {|      \"rolls\": 1.0,|      \"entries\": [|        {|          \"type\": \"minecraft:item\",|          \"conditions\": [|            {|              \"condition\": \"minecraft:block_state_property\",|              \"block\": \"%MOD%:%BLOCK%_%WOOD%\",|              \"properties\": { \"half\": \"upper\" }|            },|            { \"condition\": \"minecraft:survives_explosion\" }|          ],|          \"name\": \"%MOD%:%BLOCK%_%WOOD%\"|        }|      ]|    }|  ],|  \"functions\": [ { \"function\": \"minecraft:explosion_decay\" } ]|}"
tall_block_loot_table="${tall_block_loot_table//\%MOD\%/$2}"
tall_block_loot_table="${tall_block_loot_table//\%WOOD\%/$shortname}"

temp="${tall_block_loot_table}"
temp="${temp//\%BLOCK\%/tool_rack_double}"
echo "${temp}" | tr '|' '\n' > src/main/resources/data/${addon_modid}/loot_tables/blocks/tool_rack_double_${shortname}.json

temp="${tall_block_loot_table}"
temp="${temp//\%BLOCK\%/tool_rack_framed}"
echo "${temp}" | tr '|' '\n' > src/main/resources/data/${addon_modid}/loot_tables/blocks/tool_rack_framed_${shortname}.json

temp="${tall_block_loot_table}"
temp="${temp//\%BLOCK\%/tool_rack_pframed}"
echo "${temp}" | tr '|' '\n' > src/main/resources/data/${addon_modid}/loot_tables/blocks/tool_rack_pframed_${shortname}.json

# recipes

mkdir -p src/main/resources/data/${addon_modid}/recipes
recipe_files=('potion_shelf_birch.json' 'simple_table_normal_birch.json' 'simple_table_replacement_birch.json' 'tool_rack_double_birch.json' 'tool_rack_framed_birch.json' 'tool_rack_pframed_birch.json' 'tool_rack_single_birch.json' 'tool_rack_single_from_multi_birch.json' 'workstation_placer_birch.json')


for recipe in "${recipe_files[@]}"; do
  #echo ${recipe/birch/$shortname}
  cp sample-recipes/${recipe} src/main/resources/data/${addon_modid}/recipes/${recipe/birch/$shortname}
  sed -i "s/minecraft:birch/${wood_modid}:birch/g" src/main/resources/data/${addon_modid}/recipes/${recipe/birch/$shortname}
  sed -i "s/minecraft:stripped/${wood_modid}:stripped/g" src/main/resources/data/${addon_modid}/recipes/${recipe/birch/$shortname}
  sed -i "s/birch/${shortname}/g" src/main/resources/data/${addon_modid}/recipes/${recipe/birch/$shortname}
  sed -i "s/item\": \"workshop_for_handsome_adventurer/item\": \"${addon_modid}/g" src/main/resources/data/${addon_modid}/recipes/${recipe/birch/$shortname}
done

# supported planks (unsupported form a vanilla table in crafting grid)

mkdir -p src/main/resources/data/workshop_for_handsome_adventurer/tags/items
if [[ -e "src/main/resources/data/workshop_for_handsome_adventurer/tags/items/supported_planks.json" ]];
  then sed "s/\"$/\",|    \"${wood_modid}:${shortname}_planks\"/g" src/main/resources/data/workshop_for_handsome_adventurer/tags/items/supported_planks.json  | tr '|' '\n' > src/main/resources/data/workshop_for_handsome_adventurer/tags/items/supported_planks.json
  else echo "{|  \"replace\": false,|  \"values\": [|    \"${wood_modid}:${shortname}_planks\"|  ]|}" | tr '|' '\n' > src/main/resources/data/workshop_for_handsome_adventurer/tags/items/supported_planks.json1; mv src/main/resources/data/workshop_for_handsome_adventurer/tags/items/supported_planks.json1 src/main/resources/data/workshop_for_handsome_adventurer/tags/items/supported_planks.json
fi

# language. only english will work right, others obviously need manual edits.

mkdir -p src/main/resources/assets/${addon_modid}/lang
if [[ -e "src/main/resources/assets/${addon_modid}/lang/en_us.json" ]];
  then
    content="	\"item.workshop_for_handsome_adventurer.workstation_placer_birch\": \"Workstation (birch)\",||	\"block.workshop_for_handsome_adventurer.simple_table_birch\": \"Crafting Table (birch)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_double_birch\": \"Tool Rack (birch, triple)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_framed_birch\": \"Tool Rack (birch, framed)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_pframed_birch\": \"Tool Rack (birch, partly framed)\",|	\"block.workshop_for_handsome_adventurer.tool_rack_single_birch\": \"Tool Rack (birch, single)\",|	\"block.workshop_for_handsome_adventurer.potion_shelf_birch\": \"Potion Shelf (birch)\""
	content="${content//birch/$shortname}"
	content="${content//workshop_for_handsome_adventurer/$addon_modid}"
    sed "s/\"$/\",||    $content/g" src/main/resources/assets/${addon_modid}/lang/en_us.json  | tr '|' '\n' > src/main/resources/assets/${addon_modid}/lang/en_us.json1; mv -f src/main/resources/assets/${addon_modid}/lang/en_us.json1 src/main/resources/assets/${addon_modid}/lang/en_us.json
	unset content
  else
    cp sample-assets/lang.json src/main/resources/assets/${addon_modid}/lang/en_us.json
    sed -i "s/birch/${shortname}/g" src/main/resources/assets/${addon_modid}/lang/en_us.json
    sed -i "s/workshop_for_handsome_adventurer/${addon_modid}/g" src/main/resources/assets/${addon_modid}/lang/en_us.json
fi

# models / inventory

file_list=('workstation_placer_birch.json' 'potion_shelf_birch.json' 'tool_rack_framed_birch.json' 'tool_rack_pframed_birch.json' 'simple_table_birch.json' 'tool_rack_single_birch.json' 'tool_rack_double_birch.json')
mkdir -p src/main/resources/assets/${addon_modid}/models/item
for model in "${file_list[@]}"; do
  cp sample-assets/models-item/${model} src/main/resources/assets/${addon_modid}/models/item/${model/birch/$shortname}
  sed -i "s/minecraft:block\/birch/${wood_modid}:block\/$shortname/g" src/main/resources/assets/${addon_modid}/models/item/${model/birch/$shortname}
  sed -i "s/minecraft:block\/stripped_birch/${wood_modid}:block\/stripped_$shortname/g" src/main/resources/assets/${addon_modid}/models/item/${model/birch/$shortname}
  sed -i "s/workshop_for_handsome_adventurer:block\/${model%.json}/${addon_modid}:block\/${model/birch/$shortname}/g" src/main/resources/assets/${addon_modid}/models/item/${model/birch/$shortname}
  sed -i "s/\.json//g" src/main/resources/assets/${addon_modid}/models/item/${model/birch/$shortname}
  sed -i "s/workshop_for_handsome_adventurer:block\/dual_table_full_birch/${addon_modid}:block\/dual_table_full_${shortname}/g" src/main/resources/assets/${addon_modid}/models/item/${model/birch/$shortname}
done

# models / block

file_list=('dual_rack_bottom_birch.json' 'dual_rack_top_birch.json' 'dual_table_full_birch.json' 'dual_table_part_bottom_left_birch.json' 'dual_table_part_bottom_right_birch.json' 'dual_table_part_top_left_birch.json' 'dual_table_part_top_left2_birch.json' 'dual_table_part_top_right_birch.json' 'dual_table_part_top_right2_birch.json' 'framed_rack_full_bottom_birch.json' 'framed_rack_full_top_birch.json' 'framed_rack_hollow_bottom_birch.json' 'framed_rack_hollow_top_birch.json' 'mini_rack_birch.json' 'potion_shelf_birch.json' 'simple_table_birch.json' 'simple_table_with_drawer_birch.json')
mkdir -p src/main/resources/assets/${addon_modid}/models/block
for model in "${file_list[@]}"; do
  cp sample-assets/models-block/${model} src/main/resources/assets/${addon_modid}/models/block/${model/birch/$shortname}
  sed -i "s/minecraft:block\/birch/${wood_modid}:block\/$shortname/g" src/main/resources/assets/${addon_modid}/models/block/${model/birch/$shortname}
  sed -i "s/minecraft:block\/stripped_birch/${wood_modid}:block\/stripped_$shortname/g" src/main/resources/assets/${addon_modid}/models/block/${model/birch/$shortname}
done

# blockstates

file_list=('dual_table_bottom_left_birch.json' 'dual_table_bottom_right_birch.json' 'dual_table_top_left_birch.json' 'dual_table_top_right_birch.json' 'potion_shelf_birch.json' 'simple_table_birch.json' 'tool_rack_double_birch.json' 'tool_rack_framed_birch.json' 'tool_rack_pframed_birch.json' 'tool_rack_single_birch.json')
mkdir -p src/main/resources/assets/${addon_modid}/blockstates
for blockstate in "${file_list[@]}"; do
  cp sample-assets/blockstates/${blockstate} src/main/resources/assets/${addon_modid}/blockstates/${blockstate/birch/$shortname}
  sed -i "s/birch/$shortname/g" src/main/resources/assets/${addon_modid}/blockstates/${blockstate/birch/$shortname}
  sed -i "s/workshop_for_handsome_adventurer/${addon_modid}/g" src/main/resources/assets/${addon_modid}/blockstates/${blockstate/birch/$shortname}
done


echo "done"






