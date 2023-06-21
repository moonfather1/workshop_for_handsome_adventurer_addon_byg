package moonfather.workshop_for_handsome_adventurer_addon_byg;

import moonfather.workshop_for_handsome_adventurer.blocks.*;
import moonfather.workshop_for_handsome_adventurer.items.BlockItemEx;
import moonfather.workshop_for_handsome_adventurer.items.WorkstationPlacerItem;
import moonfather.workshop_for_handsome_adventurer.other.CreativeTab;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.block.Block;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.RegistryObject;

import java.util.ArrayList;
import java.util.List;


public class Registration {
    ////////////////////////////////////////////////////////////////////////////////////////
    public static final String[] woodTypes = { "redwood", "skyris", "willow", "witch_hazel", "zelkova", "sythian", "embur" };
    ///// you should only change the line above. rest is paste-it-and-leave it. //////////
    //////////////////////////////////////////////////////////////////////////////////////

    private static final DeferredRegister<Block> BLOCKS = DeferredRegister.create(ForgeRegistries.BLOCKS, Constants.MODID);
    private static final DeferredRegister<Item> ITEMS = DeferredRegister.create(ForgeRegistries.ITEMS, Constants.MODID);

    public static final List<RegistryObject<Block>> blocks_table1 = new ArrayList<>();
    public static final List<RegistryObject<Block>> blocks_table2 = new ArrayList<>();
    public static final List<RegistryObject<Block>> blocks_rack = new ArrayList<>();
    public static final List<RegistryObject<Block>> blocks_shelf = new ArrayList<>();
    public static final List<RegistryObject<Item>> items_table1 = new ArrayList<>();
    public static final List<RegistryObject<Item>> items_table2 = new ArrayList<>(); // because of sorting in creative tabs, we can't just dump into one list
    public static final List<RegistryObject<Item>> items_rack1 = new ArrayList<>();
    public static final List<RegistryObject<Item>> items_rack2 = new ArrayList<>();
    public static final List<RegistryObject<Item>> items_rack3 = new ArrayList<>();
    public static final List<RegistryObject<Item>> items_rack4 = new ArrayList<>();
    public static final List<RegistryObject<Item>> items_shelf = new ArrayList<>();

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // static initialization
    static {
        // small tables
        for (String woodType: Registration.woodTypes) {
            RegistryObject<Block> block = BLOCKS.register("simple_table_" + woodType, () -> new SimpleTable());
            blocks_table1.add(block);
            items_table1.add(FromBlock(block));
        }
        // dual tables
        for (String woodType: Registration.woodTypes) {
            RegistryObject<Block> primary = BLOCKS.register("dual_table_bottom_left_" + woodType, () -> new AdvancedTableBottomPrimary());
            BLOCKS.register("dual_table_bottom_right_" + woodType, () -> new AdvancedTableBottomSecondary());
            BLOCKS.register("dual_table_top_left_" + woodType, () -> new AdvancedTableTopSecondary());
            BLOCKS.register("dual_table_top_right_" + woodType, () -> new AdvancedTableTopSecondary());
            RegistryObject<Item> placer = ITEMS.register("workstation_placer_" + woodType, () -> new WorkstationPlacerItem(woodType));
            items_table2.add(placer);
            blocks_table2.add(primary);
        }
        // toolracks
        for (String woodType: Registration.woodTypes) {
            RegistryObject<Block> rack;
            rack = BLOCKS.register("tool_rack_single_" + woodType, () -> new ToolRack(2, "single"));
            items_rack1.add(FromBlock(rack));
            blocks_rack.add(rack);
            rack = BLOCKS.register("tool_rack_framed_" + woodType, () -> new DualToolRack(6, "framed"));
            items_rack2.add(FromBlock(rack));
            blocks_rack.add(rack);
            rack = BLOCKS.register("tool_rack_pframed_" + woodType, () -> new DualToolRack(6, "pframed"));
            items_rack3.add(FromBlock(rack));
            blocks_rack.add(rack);
            rack = BLOCKS.register("tool_rack_double_" + woodType, () -> new DualToolRack(6, "double"));
            items_rack4.add(FromBlock(rack));
            blocks_rack.add(rack);
        }
        // potion shelves
        for (String woodType: Registration.woodTypes) {
            RegistryObject<Block> shelf = BLOCKS.register("potion_shelf_" + woodType, () -> new PotionShelf());
            items_shelf.add(FromBlock(shelf));
            blocks_shelf.add(shelf);
        }
    }


    private static RegistryObject<Item> FromBlock(RegistryObject<Block> block)
    {
        Item.Properties properties = new Item.Properties().tab(CreativeTab.TAB_WORKSHOP);
        return ITEMS.register(block.getId().getPath(), () -> new BlockItemEx(block.get(), properties));
    }

    private static Block[] ListToArray(List<RegistryObject<Block>> list) {
        Block[] result = new Block[list.size()];
        for (int i = 0; i < list.size(); i++) {
            result[i] = list.get(i).get();
        }
        return result;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    public static void init() {
        BLOCKS.register(FMLJavaModLoadingContext.get().getModEventBus());
        ITEMS.register(FMLJavaModLoadingContext.get().getModEventBus());
    }

}
