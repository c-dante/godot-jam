# Dev Notes

Access resource enum:
```js
const Res = preload("res://src/Resources.gd")
```

## Physics / Collisions
Layer 1 is for all things

Layer 5 is for interactables

Layer 20 is for just the floors/walls

## Groups
- `resource` - Anything that can be mined. See `src/Resources.gd` for the enum
  - Attach a `Gatherable` script to the resource
  - Must be on collision layer 5
- Gatherers
  - Must be on collision layer 5