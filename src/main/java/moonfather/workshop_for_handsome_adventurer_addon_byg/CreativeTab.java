package moonfather.workshop_for_handsome_adventurer_addon_byg;

import net.minecraftforge.event.CreativeModeTabEvent;

public class CreativeTab {

    public static void OnCreativeTabPopulation(CreativeModeTabEvent.BuildContents event) {
        if (event.getTab() == moonfather.workshop_for_handsome_adventurer.other.CreativeTab.TAB_WORKSHOP) {
            for (int i = 0; i < Registration.woodTypes.length; i++) {
                event.accept(Registration.items_table1.get(i));
                event.accept(Registration.items_table2.get(i));
                event.accept(Registration.items_rack1.get(i));
                event.accept(Registration.items_rack2.get(i));
                event.accept(Registration.items_rack3.get(i));
                event.accept(Registration.items_rack4.get(i));
                event.accept(Registration.items_shelf.get(i));
            }
        }
    }
}
