// ============================================================
//  DeskPi RackMate T1 — Horizontal Pole
//  Connects two corner posts horizontally.
//  Dovetail on both ends with countersunk lock screw from bottom.
// ============================================================

/* [★ USER PARAMETERS ★] */
pole_length      = 140.0;  // distance between the two post inner faces (mm) *** MEASURE ***
dovetail_h_left  =  15.0;  // insertion depth of left dovetail into post (mm)
dovetail_h_right =  15.0;  // insertion depth of right dovetail into post (mm)
pole_height      =  10.0;  // vertical thickness of the pole body (mm)
dovetail_height  =  4.9;  // vertical thickness of the dovetail sections (mm)

/* [Lock screw — M3 flat-head, countersunk from bottom] */
lock_d        = 3.4;   // M3 clearance
lock_head_d   = 6.0;   // M3 flat-head diameter
lock_cs_angle = 45;    // half-angle

/* [Dovetail dimensions — must match corner post v9] */
ch_mouth_w   = 12.0;
ch_floor_w   = 20.0;
ch_depth     = 15.0;
ch_clearance =  0.3;

/* [Post reference] */
post_d = 42.0;

$fn = 64;
eps = 0.01;

// ── Derived ──────────────────────────────────────────────────
tm = ch_mouth_w - ch_clearance;
tf = ch_floor_w - ch_clearance;
td = ch_depth   - ch_clearance;
cy = post_d / 2;
total_length = dovetail_h_left + pole_length + dovetail_h_right;

// Lock screw X position: centred in dovetail depth
lock_x_offset = td / 2;  // centred in dovetail depth, matches post receiver hole

// ============================================================
//  MODULE: countersunk hole, oriented along +Z
// ============================================================
module cs_hole(length, hole_d, head_d, cs_angle) {
    cone_h = (head_d/2 - hole_d/2) / tan(cs_angle);
    cylinder(r1=head_d/2, r2=hole_d/2, h=cone_h);
    translate([0, 0, cone_h - eps])
        cylinder(d=hole_d, h=length - cone_h + eps*2);
}

// ============================================================
//  MODULE: single dovetail end
//  Wide at mouth (X=0), narrows to tip (X=depth).
// ============================================================
module dovetail_end(depth) {
    hull() {
        translate([0,         cy - tf/2, 0]) cube([eps, tf, dovetail_height]);
        translate([depth-eps, cy - tm/2, 0]) cube([eps, tm, dovetail_height]);
    }
}

// ============================================================
//  FULL POLE
// ============================================================
difference() {
    union() {
        // Left dovetail
        dovetail_end(dovetail_h_left);

        // Pole body
        translate([dovetail_h_left, cy - tf/2, 0])
            cube([pole_length, tf, pole_height]);

        // Right dovetail
        translate([total_length, 0, 0])
            mirror([1, 0, 0])
                dovetail_end(dovetail_h_right);
    }

    // Lock screw on left dovetail — countersunk from bottom (Z=0)
    translate([lock_x_offset, cy, -eps])
        cs_hole(dovetail_height + eps*2, lock_d, lock_head_d, lock_cs_angle);

    // Lock screw on right dovetail — countersunk from bottom (Z=0)
    translate([total_length - lock_x_offset, cy, -eps])
        cs_hole(dovetail_height + eps*2, lock_d, lock_head_d, lock_cs_angle);
}

// ============================================================
//  PARAMETERS:
//    pole_length      — gap between the two post inner faces (mm)
//    dovetail_h_left  — insertion depth into left post (mm)
//    dovetail_h_right — insertion depth into right post (mm)
//    pole_height      — vertical thickness of pole body (mm)
//    dovetail_height  — vertical thickness of dovetail sections (mm)
//
//  HARDWARE: 2× M3 flat-head screws + nuts (one per dovetail)
//
//  PRINT SETTINGS:
//    PETG or ASA | 4 perimeters | 30% infill
//    Print flat, no supports needed
// ============================================================
