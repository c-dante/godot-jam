# Dev Notes
Following a pattern of:
- Parent Node
  - Script component w/ name matching class
  - If the component contributes to a group
  - The component augments functionality of the parent

### Snippets
```js
// Access resource enum
const Res = preload("res://src/Resources.gd")

// Check if running from editor
OS.has_feature("editor")
```

## Physics / Collisions
- Layer 1 is for all things
- Layer 2 is checked by attacks, so things that can take damage (Killable)
- Layer 5 is for interactables
- Layer 20 is for just the floors/walls

## Groups
See `Global` for the enum of groups and their meaning.
In general, using groups to create a "component" system where class scripts as children
add functionality and assumptions to the parent (Killable, Movement, etc.)
<!-- - `resource` - Anything that can be mined. See `src/Resources.gd` for the enum
  - Attach a `Gatherable` script to the resource
  - Must be on collision layer 5
- Gatherers
  - Must be on collision layer 5 -->