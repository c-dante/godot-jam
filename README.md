A game jam project! [Stop waiting for godot](https://itch.io/jam/stop-waiting-for-godot)

## Controls
- WASD to move
- Q, E to rotate the player cam
- Mouse to aim
- Shift to sprint
- ...

Some notes and a todo and resources for now:

## Design
- Twinstick!!
- The demo I have is there -- great starting place and a couple nice addons

## BUGS
- Scripts that track by a map of instance id are a hard pattern
  - Abstract the "enter/exit" area and map of in-area logic as a helper
  - This is used by enemies for AOE attacking as well as gatherables!!


### Work / TODO
- **DONE** Basic twinstick impl going
  - Movement of PC, WASD + mouse for now, controllers later
  - **DONE**: WASD move relative to camera, face mouse projected to plane
- **DONE** Resource collection
  - Get a couple different resource types and passively harvest when nearby
  - **DONE**: We have rocks and trees
- Building things?
  - **DONE** Make a miner
- Firing a weapon (build it first!)
  - **DONE**
- Enemies / AI
  - **DONE** Something to break miners -- and you
  - Track how many attackers + spread out more to disrupt
- Make a survival loop + score + death/restart
  - **DONE** Player health (time instead?)
  - **Done** Score - Resources mined, enemies killed, time survived, resources spent (?)
  - **DONE**death screen
  - **DONE** Restart
- UX
  - Player, enemy, miner health bars?
  - **Done** Resource gathering
  - Miner state
  - Weapon / equipment state
  - Build menu cleanup
  - Pause menu
  - **Done** Newgame / death screen
  - Save/Load (no)
- Juice
  - **DONE** Arrow flight, fire, despawn, hit feedback
  - **DONE** Enemy attack, damage, death feedback
  - **DONE** Player attack, damage, death feedback
  - Miner attack, damage, death feedback
  - Miner mining feedback
- Gameplay
  - **Done** Score
  - **Done** Player death
  - Safe/Danger cycle
  - Expand the map and playable area
  - Weapon upgrades and types
  - More enemey attack patterns
  - Instead of health a "time" bar?

## HACK FIXES
- Gatherable assumes only player
- `ui.gd` has the game over logic xD
- Stats collected in `Player.gd` and same is used for game over display ui

## Resources
- [Some docs](https://docs.godotengine.org/en/stable/tutorials/physics/rigid_body.html)
- Downloaded a TON of addons
  - Review addons plz
  - Lots of state machines -- will def wanna use them!
- Saving games
  - https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
-	Shaders
- [Making tilt shift](https://www.youtube.com/watch?v=TZxsssoLwM8) https://godotshaders.com/shader/tilt-shift-shader/
