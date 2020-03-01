# morphThis

This is a simple processing sketch that morphes images into each other by letting the pixels shift from color to color. 
Each pixel of the canvas starts out as black and then starts to shift step by step to the color of the first image of the array. Once the color has been reached the pixel continues to shift to the color of the next image in the array. Each pixel changes independently from the rest and since the 'distance' between the RGB values of each pixelposition and image differ the canvas is always inbetween images.

#example images

![emoji example](emojiExample.jpg)
