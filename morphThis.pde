//morphThis (RGB morpher) 
//This sketch takes a folder of images and morphes them together by making the pixels wander from image to image to the next colorwise
//Each pixel starts out black and then gets changed step by step until it matches the color of the pixel with the same position in the first input image. 
//Then it continues until it matches the second images pixel color, than the the third and so on.
//Since each pixel has  a different 'distance' to go from on color to the next trippy 'inbetween' images get created.


File[] files;
String filenames[];
PImage canvas;
PImage inputImages [];
int pixelCount[];


void setup() {


  size(800, 800);

  background(0);


  files = listFiles("data/emojiExample/"); //the directory containing the input images you want to morph
  filenames = new String[files.length];

  //load the paths of the input images into an array
  for (int i = 0; i < files.length; i++) {
    filenames[i] = files[i].getAbsolutePath();
  }

  inputImages = new PImage[files.length];      
  for (int i = 0; i < inputImages.length-1; i++) { 
    inputImages[i]= loadImage(filenames[i]);    //load all the images of the folder into an Array of images
    inputImages[i].resize(width, height);      //all images get resized to the same resolution to avoid out of bounds errors
  }

  pixelCount = new int [width*height];    // an array of counter for each of the canvas' pixel to pointing to the desired
  for (int i = 0; i < pixelCount.length; i++) {
    pixelCount[i]=0;
  }
  canvas = createImage(width, height, RGB); // Not necessary, the morphed output could be drawn directly to the display window but using a PImage makes it more convenient to continue working with the morph imo.
}


void draw() {
  canvas.loadPixels();                    //load the pixel arrays of our canvas and the input images
  for (int i = 0; i < inputImages.length-1; i++) {  
    inputImages[i].loadPixels();
  }



  for (int x = 0; x < inputImages[1].width; x++) {    
    for (int y = 0; y < inputImages[1].height; y++) {      
      // Calculate the 1D location from a 2D grid
      int loc = x + y * inputImages[0].width;

      float r = red(canvas.pixels[loc]);  //get the current color of each of the canvas' pixel
      float g= green(canvas.pixels[loc]);
      float b = blue(canvas.pixels[loc]);

      float r2 = red(inputImages[pixelCount[loc]].pixels[loc]); //get the color of the desired image
      float g2= green(inputImages[pixelCount[loc]].pixels[loc]);
      float b2 = blue(inputImages[pixelCount[loc]].pixels[loc]);

      //the current color of the pixel get changed one step at until it matches the desired color
      if (r < r2) r++;   
      if (r > r2)r--;
      if (g < g2) g++;
      if (g > g2)g--;
      if (b < b2) b++;
      if (b > b2)b--;


      //if the color of the canvas' pixel matches the one desired, the individual counter of that pixel gets incereased to the next 
      if (r==r2 && g==g2 && b ==b2) {
        pixelCount[loc]++;
      }



      //set the counter back to zero once an pixel reached the last input image
      if (pixelCount[loc] == inputImages.length-1) {
        pixelCount[loc] = 0;
      }


      canvas.pixels[loc] = color (r, g, b);
    }
  }
  canvas.updatePixels();
  image(canvas, 0, 0);
}
