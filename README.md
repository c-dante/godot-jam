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
- Spawner sometimes picks bad spots?

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
  - Something to break miners -- and you
  - Track how many attackers + spread out more to disrupt
- Make a survival loop + score + death/restart
  - Player health (time instead?)
  - Score - Resources mined, enemies killed, time survived, resources spent (?)
  - death screen
  - **DONE** Restart
- Ux
  - Player, enemy, miner health bars
  - Resource gathering
  - Miner state
  - Weapon / equipment state
  - Build menu cleanup
  - Pause menu
  - Newgame / death screen
  - Save/Load (no)
- Juice
  - Arrow flight, fire, despawn, hit feedback
  - Enemy attack, damage, death feedback
  - Miner attack, damage, death feedback
  - Player attack, damage, death feedback
  - Miner mining feedback
  - Mining feedback!
- Gameplay
  - Score
  - Player death
  - Expand the map and playable area
  - Weapon upgrades and types
  - More enemey attack patterns
  - **DONE** Safe/Danger cycle
    - Can be better, but for now a timer
  - Instead of health a "time" bar?

## Resources
- [Some docs](https://docs.godotengine.org/en/stable/tutorials/physics/rigid_body.html)
- Downloaded a TON of addons
  - Review addons plz
  - Lots of state machines -- will def wanna use them!
- Saving games
  - https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
-	Shaders
- [Making tilt shift](https://www.youtube.com/watch?v=TZxsssoLwM8) https://godotshaders.com/shader/tilt-shift-shader/
