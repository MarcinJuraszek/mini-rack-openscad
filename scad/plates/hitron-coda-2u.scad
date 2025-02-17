use <blank-2u.scad>;
use <../components/rj45keystone.scad>

module hitronCoda2u() {

    PLATE_W = 250;
    PLATE_H = 88;
    PLATE_D = 3;

    MODEM_W = 173;
    MODEM_H = 51;
    MODEM_D = 173;

    SHELVE_T = 3;
    SHELVE_O = 15;

    // cut out things from 2u plate
    difference() {
        // start with a blank 2u plate
        blank2u();

        // remove block for rj45 connector
        translate([ -9, -12.5, 0]) // center first
            translate([119 - 25, 0, 0]) // move to 25mm from the last border
                rj45VolumeBlock();  // rj45 block

        // remove block for the modem itself
        translate([- (PLATE_W - MODEM_W) / 2 + 20, 0 ])
            cube([MODEM_W, MODEM_H, 10], center = true);
    }

    // add rj45 keystone
        rotate([0,180,0])  // rotate
            translate([ -9, -12.5, 0]) // center
                translate([- 119 + 25, 0, -10]) // move to 25mm from the last border, and flush with the top face
                    rj45Receiver();

    // add shelve for the modem to sit on
    translate([-18.5, -28, 91])
        difference() {
            cube([ MODEM_W + SHELVE_T * 2, 5, MODEM_D + SHELVE_T], center = true);
            translate([0, 0, - SHELVE_T])
                cube([ MODEM_W - SHELVE_O * 2, 15, MODEM_D - SHELVE_O * 2], center = true);
        }

    // add sides to the shelve, with cutouts
    translate([69.5, 0, MODEM_D / 2 + SHELVE_T])
        difference() {
            cube([SHELVE_T, MODEM_H, MODEM_D], center = true);
            cube([SHELVE_T * 2, MODEM_H - SHELVE_O, MODEM_D - SHELVE_O], center = true);
        }
    translate([-106.5, 0, MODEM_D / 2 + SHELVE_T])
        difference() {
            cube([SHELVE_T, MODEM_H, MODEM_D], center = true);
            cube([SHELVE_T * 2, MODEM_H - SHELVE_O, MODEM_D - SHELVE_O], center = true);
        }

    // add back to the shelve, bottom lip only to let the cables go through
    translate([-18.5, 0, MODEM_D + SHELVE_T * 1.5])
        difference() {
            cube([MODEM_W + SHELVE_T * 2, MODEM_H, SHELVE_T], center = true);
            translate([0, SHELVE_O / 2, 0])
                cube([MODEM_W - SHELVE_O * 2, MODEM_H, SHELVE_T * 2], center = true);
        }
}

hitronCoda2u();