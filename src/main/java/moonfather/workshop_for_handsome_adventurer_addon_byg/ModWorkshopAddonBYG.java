package moonfather.workshop_for_handsome_adventurer_addon_byg;

import net.minecraft.world.level.block.Block;
import net.minecraftforge.fml.InterModComms;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.event.lifecycle.FMLCommonSetupEvent;
import net.minecraftforge.fml.event.lifecycle.InterModEnqueueEvent;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import net.minecraftforge.registries.RegistryObject;

import java.util.HashSet;

import static moonfather.workshop_for_handsome_adventurer.initialization.Registration.*;


@Mod(Constants.MODID)
public class ModWorkshopAddonBYG
{
    public ModWorkshopAddonBYG()
    {
        FMLJavaModLoadingContext.get().getModEventBus().addListener(this::enqueueIMC);
        FMLJavaModLoadingContext.get().getModEventBus().addListener(this::commonSetup);
        Registration.init();
    }


    private void commonSetup(final FMLCommonSetupEvent event)
    {
        TOOL_RACK_BE.get().validBlocks = new HashSet<>(TOOL_RACK_BE.get().validBlocks);
        for (RegistryObject<Block> block : Registration.blocks_rack)
        {
            TOOL_RACK_BE.get().validBlocks.add(block.get());
        }
        POTION_SHELF_BE.get().validBlocks = new HashSet<>(POTION_SHELF_BE.get().validBlocks);
        for (RegistryObject<Block> block : Registration.blocks_shelf)
        {
            POTION_SHELF_BE.get().validBlocks.add(block.get());
        }
        SIMPLE_TABLE_BE.get().validBlocks = new HashSet<>(SIMPLE_TABLE_BE.get().validBlocks);
        for (RegistryObject<Block> block : Registration.blocks_table1)
        {
            SIMPLE_TABLE_BE.get().validBlocks.add(block.get());
        }
        DUAL_TABLE_BE.get().validBlocks = new HashSet<>(DUAL_TABLE_BE.get().validBlocks);
        for (RegistryObject<Block> block : Registration.blocks_table2)
        {
            DUAL_TABLE_BE.get().validBlocks.add(block.get());
        }
    }

    private void enqueueIMC(final InterModEnqueueEvent event)
    {
        for (String woodType: Registration.woodTypes)
        {
            InterModComms.sendTo("carryon", "blacklistBlock", () -> Constants.MODID + ":tool_rack_double_" + woodType);
            InterModComms.sendTo("carryon", "blacklistBlock", () -> Constants.MODID + ":tool_rack_framed_" + woodType);
            InterModComms.sendTo("carryon", "blacklistBlock", () -> Constants.MODID + ":tool_rack_pframed_" + woodType);
            InterModComms.sendTo("carryon", "blacklistBlock", () -> Constants.MODID + ":dual_table_bottom_left_" + woodType);
            InterModComms.sendTo("carryon", "blacklistBlock", () -> Constants.MODID + ":dual_table_bottom_right_" + woodType);
            InterModComms.sendTo("carryon", "blacklistBlock", () -> Constants.MODID + ":dual_table_top_left_" + woodType);
            InterModComms.sendTo("carryon", "blacklistBlock", () -> Constants.MODID + ":dual_table_top_right_" + woodType);
        }
    }
}
