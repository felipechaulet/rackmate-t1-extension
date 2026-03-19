// ============================================================
//  DeskPi RackMate T1 — Corner Post Extension  v9
//  Part 1: corner_post()   — print × 2 (one per side)
//  Part 2: side_crossbar() — print × 2
// ============================================================

/* [★ USER PARAMETERS ★] */
ext_U         = 3;       // rack units of extension height
crossbar_span = 140.0;   // front-to-back between post outer faces *** MEASURE ***
mirror_post   = true;   // false = left post (holes near wall C), true = right post (holes near wall B)

/* [T1 extrusion — measured] */
leg_len       = 30.0;
leg_t         = 10.0;

/* [Cradle walls] */
wall_t        = 6.0;
wall_h        = 25.0;

/* [Rack holes — #10-32] */
one_U        = 44.45;
hole_A       = 15.875;
first_hole   = 6.35;
rack_hole_d  = 4.8;
rack_hole_cx = 12.7;    // hole depth
screw_head_d = 9.0;     // #10-32 flat-head diameter
screw_cs_angle = 41;    // half-angle (82°/2)

/* [Post body] */
post_w = leg_len + wall_t;        // 36 mm  — X: wall_A + T1_leg
post_d = leg_len + wall_t * 2;    // 42 mm  — Y: wall_B + T1_leg + wall_C

/* [Dovetail channel — on inner X face, open toward +X] */
ch_mouth_w   = 12.0;   // width at open face
ch_floor_w   = 20.0;   // width inside (wider = locking)
ch_depth     = 15.0;   // inset depth into post (X direction)
ch_height    = 5.0;    // slot height from base (Z)
ch_clearance = 0.3;    // fit clearance

/* [T1 alignment screw — countersunk hole in cradle wall, aligns with T1 bottom rack hole] */
t1_screw_z    = 12.5;  // distance above ext_h to screw centre (mm) ← TUNE THIS

/* [Crossbar body] */
crossbar_h = 12.0;

/* [M3 crossbar lock screw] */
lock_d        = 3.6;
lock_head_d   = 8.0;
lock_cs_angle = 45;

/* [Rubber feet on crossbar] */
foot_od     = 12.0;
foot_recess = 2.0;

$fn = 64;
eps = 0.01;

// ── Derived ──────────────────────────────────────────────────
ext_h  = ext_U * one_U;

// Rack hole Y position on X face:
//   false (left post)  → near wall C (inner Y) = post_d - wall_t - 5.5
//   true  (right post) → near wall B (outer Y) = wall_t + 5.5
hole_y = mirror_post ? wall_t + 5.5 : post_d - wall_t - 5.5;

function rack_hole_z(u, s) = (u-1)*one_U + first_hole + s*hole_A;

// Top hole = U=ext_U, s=2
top_hole_z = rack_hole_z(ext_U, 2);

// ============================================================
//  MODULE: flat-head countersunk hole (along +X after rotate)
// ============================================================
module cs_hole(length, hole_d, head_d, cs_angle) {
    cone_h = (head_d/2 - hole_d/2) / tan(cs_angle);
    cylinder(r1=head_d/2, r2=hole_d/2, h=cone_h);
    translate([0, 0, cone_h - eps])
        cylinder(d=hole_d, h=length - cone_h + eps*2);
}

// ============================================================
//  MODULE: dovetail channel — inner X face (X=post_w)
//  Narrow at open face, wide inside. ch_height tall at base.
// ============================================================
module channel_cut() {
    hull() {
        translate([post_w - eps, post_d/2 - ch_mouth_w/2, -eps])
            cube([eps, ch_mouth_w, ch_height + eps]);
        translate([post_w - ch_depth, post_d/2 - ch_floor_w/2, -eps])
            cube([eps, ch_floor_w, ch_height + eps]);
    }
}

// ============================================================
//  CORNER POST
// ============================================================
module corner_post() {
    difference() {
        union() {
            // Post body
            cube([post_w, post_d, ext_h]);
            // Wall A — outer X face (X=0)
            translate([0, 0, ext_h])
                cube([wall_t, post_d, wall_h]);
            // Wall B — outer Y face (Y=0)
            translate([0, 0, ext_h])
                cube([post_w, wall_t, wall_h]);
            // Wall C — inner Y face, closes the U
            translate([0, post_d - wall_t, ext_h])
                cube([post_w, wall_t, wall_h]);
        }

        // Dovetail channel on inner X face
        channel_cut();

        // M3 receiver hole in bottom face — centred in dovetail slot (X and Y)
        translate([post_w - ch_depth/2, post_d/2, -eps])
            cylinder(d=lock_d, h=10 + eps);

        // Rack holes on outer X face (X=0) — all plain
        for (u = [1:ext_U]) {
            for (s = [0,1,2]) {
                z = rack_hole_z(u, s);
                translate([-eps, hole_y, z])
                    rotate([0, 90, 0])
                        cylinder(d=rack_hole_d, h=rack_hole_cx + eps);
            }
        }

        // Top countersunk hole — aligns with T1's bottom rack hole
        // Tune t1_screw_z to fine-align with T1
        translate([-eps, hole_y, ext_h + t1_screw_z])
            rotate([0, 90, 0])
                cs_hole(wall_t, rack_hole_d, screw_head_d, screw_cs_angle);
    }
}

// ============================================================
//  SIDE CROSSBAR
// ============================================================
module side_crossbar() {
    tm = ch_mouth_w - ch_clearance;
    tf = ch_floor_w - ch_clearance;
    td = ch_depth   - ch_clearance;
    th = ch_height  - ch_clearance;

    module dovetail_end() {
        hull() {
            translate([post_w - eps, post_d/2 - tm/2, 0])
                cube([eps, tm, th]);
            translate([post_w - td, post_d/2 - tf/2, 0])
                cube([eps, tf, th]);
        }
    }

    difference() {
        union() {
            translate([0, post_d, 0])
                cube([post_w, crossbar_span - 2*post_d, crossbar_h]);
            dovetail_end();
            translate([0, crossbar_span - post_d, 0])
                dovetail_end();
        }

        translate([-eps, post_d/2, crossbar_h/2])
            rotate([0, 90, 0])
                cs_hole(post_w, lock_d, lock_head_d, lock_cs_angle);

        translate([-eps, crossbar_span - post_d/2, crossbar_h/2])
            rotate([0, 90, 0])
                cs_hole(post_w, lock_d, lock_head_d, lock_cs_angle);

        translate([post_w/2, post_d/2, -eps])
            cylinder(d=foot_od, h=foot_recess + eps);
        translate([post_w/2, crossbar_span - post_d/2, -eps])
            cylinder(d=foot_od, h=foot_recess + eps);
    }
}

// ============================================================
//  RENDER
//  Set mirror_post=false for left, mirror_post=true for right
// ============================================================

corner_post();

// Uncomment to preview crossbar:
// translate([50, 0, 0]) side_crossbar();

// ============================================================
//  HARDWARE BOM:
//    2× #10-32 flat-head (82°) — top rack hole countersink screws
//    4× M3 flat-head + nuts    — crossbar lock screws
//    4× rubber stick-on feet Ø12mm — crossbar base ends
//
//  PRINT SETTINGS:
//    PETG or ASA | 6 perimeters | 50% gyroid infill
//    Posts × 2 pairs — upright, no supports
//    Crossbars × 2   — flat, no supports
//
//  ASSEMBLY:
//    1. Slide crossbar dovetail ends UP into post inner-face slots
//    2. Tighten M3 lock screws through post face into dovetail
//    3. Drop T1 corners into cradle from above
//    4. Install rack panels using #10-32 screws (top hole countersunk)
// ============================================================
