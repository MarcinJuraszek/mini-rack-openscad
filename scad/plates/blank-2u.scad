$fa = 5;
$fs = 0.01;

module blank2u() {

    PLATE_W = 250;
    PLATE_H = 88;
    PLATE_D = 3;
    CORNER_RADIUS = 3;

    CUTOUT_R = 3;
    CUTOUT_L = 2;
    CUTOUT_E = 3;

    CORNERS = [[1, 1], [1, -1], [-1, 1], [-1, -1]];

    difference()
    {
        // the plate
        linear_extrude( PLATE_D )
            offset(r=CORNER_RADIUS) 
                square( [PLATE_W, PLATE_H], center=true );

        // cutouts for screws
        for (corner = CORNERS) {
            #translate([corner[0] * (PLATE_W /2 - CUTOUT_L * 1.5 - CUTOUT_E), corner[1] * (PLATE_H / 2 - CUTOUT_E), 0])
                translate([0,0, - PLATE_D * 2])
                    linear_extrude( PLATE_D * 4 )
                        offset(r = CUTOUT_R) 
                            square( [CUTOUT_R * CUTOUT_L, 0.0001], center=true );
        }
    }
}

blank2u();