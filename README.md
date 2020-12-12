# Final-Project-NMD211
## 1.
Below is a picture of all the wiring involved for the GY-521 Module. The vcc gets 5V power, the gnd is connected to ground, the SCL on the GY-521 connects to the SCL on the Arduino, likewise the SDA is connected on both boards.
<img src="images/wiring-controller.jpg" width = 640>

When using the “controller”, the side of the GY-521 board with the pins needs to point to the right side of the monitor. The VCC pin on the GY-521 needs to be closer to the user and away from the monitor. This gives us the proper orientation and will make the penguin move in the direction desired. A picture of this is below.
<img src="images/controller-orientation.jpg" height = 640>

## 2.
The game code already has the Arduino implementation code in it. There are two lines of code that need to be uncommented however. Instructions are in the comments of the game as well as a video explanation [HERE](). At the beginning of the game there is a window that explains the basics of the game contoles. I did not go into extensive detail on how exact movements or key presses affect the character. This was intinchanal. The game is meant as a speedrun type of game. Part of the fun and strategy is learning how the controls affect the charter for the fastest run times.

## 3.
As far as the code is concerned, I think I made the Arduino connection as smooth as possible. The Arduino only sends data when the game asks for it. The game only reads from the Serial port when it sees the newline character (\n). The data from the Arduino is sent across as one string with only the needed information plus a tab character (\t) to separate the data making it easier for the game to distinguish between the two data values sent.

The controller itself has nothing fancy to it. It is simply just sitting in a breadboard with the wires coming off the side. If I were to make a fancy housing for the board, I would probably make a rectangle roughly the same size as the iceberg in the game. The wires would also come out the back of the housing so that they are out of the way as much as possible. In a supper fancy world I would have the housing completely wireless using bluetooth to send the data. This would allow for complete freedom from wires getting in the way.
