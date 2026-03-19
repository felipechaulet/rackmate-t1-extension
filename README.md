# GeekPi RackMate T1 — Corner Post & Beam Extension

OpenSCAD parametric extension parts for the **GeekPi RackMate T1** 10-inch desktop rack. Adds rack-unit height below or between the T1 chassis using printable corner posts and horizontal beams, all locked with dovetail joints and M3 screws.

## Files

| File | What it produces |
|---|---|
| `rackmate_t1_post.scad` | Corner post + side crossbar (print 2 posts, 2 crossbars) |
| `rackmate_t1_beam.scad` | Horizontal pole connecting two corner posts front-to-back |

---

## Parts overview

### Corner post (`rackmate_t1_post.scad`)

Extends the height of the rack by a configurable number of U (rack units). Each post has:

- A **solid body** that fills one rack-unit height per `ext_U`.
- A three-walled **cradle** at the top that the T1 chassis corners drop into.
- **#10-32 rack holes** on the outer face (EIA-310 spacing: 15.875 mm between pairs, 6.35 mm first-hole offset).
- A **countersunk top hole** that aligns with the T1's bottom rack hole.
- A **dovetail channel** on the inner face that accepts the side crossbar or horizontal beam.

Print **2 pairs** — one mirrored for left/right (`mirror_post = false/true`).

### Side crossbar (`rackmate_t1_post.scad` — `side_crossbar()` module)

Runs front-to-back between two corner posts. Dovetail ends slide up into the post channels and are locked with M3 flat-head screws. Rubber feet recesses on the underside keep the assembly stable on a desk.

Print **2**.

### Horizontal beam (`rackmate_t1_beam.scad`)

Runs left-to-right between two corner posts (or any two posts with a matching dovetail channel). Dovetail on both ends, each locked with a countersunk M3 flat-head screw from below.

Print as many as needed to span the rack width.

---

## Key parameters

### `rackmate_t1_post.scad`

| Parameter | Default | Description |
|---|---|---|
| `ext_U` | `1` | Extension height in rack units |
| `crossbar_span` | `140.0 mm` | Front-to-back distance between post outer faces — **measure your setup** |
| `mirror_post` | `true` | `false` = left post, `true` = right post |
| `t1_screw_z` | `12.5 mm` | Height of the T1 alignment screw above `ext_h` — tune per print |

### `rackmate_t1_beam.scad`

| Parameter | Default | Description |
|---|---|---|
| `pole_length` | `10.0 mm` | Gap between the two post inner faces — **measure your setup** |
| `dovetail_h_left` | `15.0 mm` | Insertion depth into left post |
| `dovetail_h_right` | `15.0 mm` | Insertion depth into right post |
| `pole_height` | `10.0 mm` | Vertical thickness of the pole body |
| `dovetail_height` | `5.0 mm` | Vertical thickness of the dovetail sections |

---

## Hardware BOM

| Qty | Part | Used for |
|---|---|---|
| 2 | #10-32 flat-head 82° screw | Top rack hole countersink on corner posts |
| 4 | M3 flat-head screw + nut | Side crossbar lock screws (one per dovetail end) |
| 2 | M3 flat-head screw + nut | Horizontal beam lock screws (one per dovetail end) |
| 4 | Rubber stick-on feet Ø12 mm | Crossbar base ends |

---

## Print settings

| Setting | Posts | Crossbars / Beams |
|---|---|---|
| Material | PETG or ASA | PETG or ASA |
| Perimeters | 6 | 4 |
| Infill | 50% gyroid | 30% |
| Orientation | Upright, no supports | Flat, no supports |

---

## Assembly

1. **Print** 2 corner posts (one with `mirror_post=false`, one with `mirror_post=true`) and 2 side crossbars.
2. **Slide** the crossbar dovetail ends **upward** into the post inner-face channels.
3. **Tighten** the M3 lock screws through the post face into each dovetail to secure the crossbars.
4. **Drop** the T1 chassis corners into the cradle from above.
5. **Install** rack panels using #10-32 screws; the top hole is countersunk for a flush fit.
6. *(Optional)* **Insert** horizontal beams between posts for additional lateral rigidity or cable management rails.

---

## Compatibility

- Designed for the **GeekPi RackMate T1** 10-inch desktop rack.
- Dovetail channel dimensions (`ch_mouth_w`, `ch_floor_w`, `ch_depth`) are shared between the post and beam files — keep them in sync if you tune the fit.
- Rack holes follow **EIA-310** #10-32 spacing.

## License

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) — share and adapt with attribution.
