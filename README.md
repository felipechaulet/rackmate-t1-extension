# GeekPi RackMate T1 — Corner Post & Beam Extension

OpenSCAD parametric extension parts for the **GeekPi RackMate T1** 10-inch desktop rack. Adds rack-unit height below or between the T1 chassis using printable corner posts and horizontal beams, all locked with dovetail joints and M3 screws.

## Files

| File | What it produces |
|---|---|
| `rackmate_t1_post.scad` | Corner post (print 4 — two left, two right) |
| `rackmate_t1_beam.scad` | Crossbar / horizontal beam connecting two corner posts (print 2)|

---

## Parts overview

### Corner post (`rackmate_t1_post.scad`)

Extends the height of the rack by a configurable number of U (rack units). Each post has:

- A **solid body** that fills one rack-unit height per `ext_U`.
- A three-walled **cradle** at the top that the T1 chassis corners drop into.
- **#10-32 rack holes** on the outer face (EIA-310 spacing: 15.875 mm between pairs, 6.35 mm first-hole offset).
- A **countersunk top hole** that aligns with the T1's bottom mounting point — secured with an M4 countersink screw and nut.
- A **dovetail channel** on the bottom that accepts the crossbar/beam; the channel is sized for an M3 heated insert, locked with an M3 screw.

Print **2** — one with `mirror_post = false` (left), one with `mirror_post = true` (right).

### Crossbar / Beam (`rackmate_t1_beam.scad`)

Runs between two corner posts (front-to-back or left-to-right). Dovetail ends slot into the post channels and are secured by the M3 heated insert + screw in each post.

Print as many as needed.

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
| 2 | M4 countersink screw + nut | Top cradle — attaches post to T1 chassis |
| 2× per beam | M3 heated insert | Press into dovetail channel on each post |
| 2× per beam | M3 screw | Locks beam dovetail into post |
| 4 | Rubber stick-on feet or felt pads | Base of posts (optional) |

---

## Print settings

| Setting | Recommendation |
|---|---|
| Material | PLA (or better) |
| Walls / Perimeters | 3 minimum — more for 2U and 3U posts |
| Infill | 25% minimum — increase for taller posts |
| Supports | Not required, but recommended for the dovetail cutout |

---

## Assembly

1. **Print** 2 corner posts (one left, one right) and the required beams/crossbars.
2. **Press** an M3 heated insert into the dovetail channel at the bottom of each post.
3. **Slide** the beam dovetail ends into the post channels, then drive an M3 screw through the channel to lock each joint.
4. *(Optional)* **Attach** rubber feet or felt pads to the base of each post.
5. **Place** the T1 chassis corners into the top cradle of each post.
6. **Secure** the top with an M4 countersink screw and nut through the cradle hole into the T1's bottom mounting point.

---

## Compatibility

- Designed for the **GeekPi RackMate T1** 10-inch desktop rack.
- Dovetail channel dimensions (`ch_mouth_w`, `ch_floor_w`, `ch_depth`) are shared between the post and beam files — keep them in sync if you tune the fit.
- Rack holes follow **EIA-310** #10-32 spacing.

## License

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) — share and adapt with attribution.
