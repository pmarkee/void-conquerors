# Void Conquerors

A little game inspired by Space Invaders.

# How should I use it?

You can try it here: https://pmarkee.github.io/void-conquerors

Alternatively you can import the project in the Godot editor and play it from there or export it to whatever you want.

1. [Download Godot](https://godotengine.org/download/)
2. Import the project from the Godot editor.
3. Once it has loaded, you can either:
  * hit F5 to run the game
  * [export the project](https://docs.godotengine.org/en/3.1/getting_started/step_by_step/exporting.html) into whatever format you want and play it that way.

## Rules of this game

The player controls the little spaceship at the bottom of the screen. The goal is to shoot down all the aliens before they reach the Earth. If they all die, you win, otherwise you lose.

The aliens start at the top of the screen and move in sort of an S-shape. They will make some amount of horizontal moves. After that, they will step down vertically, then move horizontally again, but this time in the other direction. The fewer of them there are, the faster they move. They will also be able to shoot projectiles at the player in the future, but currently they do not. (The exact details such as how many of them there are and the rules of their movement are subject to change later.)

Controls:
* movement: left and right arrows
* shoot: space

