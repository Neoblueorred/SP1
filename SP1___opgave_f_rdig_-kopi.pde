ArrayList<Ball> balls = new ArrayList<Ball>(); // Here, I  am creating an ArrayList. It specifies a collection that can contain elements of type 'Ball'.
float ballRadius = 10; // here, I am specifying the size of the ball.
float platformX, platformWidth = 100, platformHeight = 20; // Here, I am specifying the size of the flatform.
int hitCount = 0; // Counts how many times the ball has been hit.


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// In void setup, I set the size of the canvas as well as the position of the ball and the platform.
void setup() {
  size(600, 600);
  balls.add(new Ball(width / 2, height / 3, 2, 3)); 
  platformX = width / 2 - platformWidth / 2; 
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//In void draw, I set the background color and create a "for-each loop". I do this to avoid -
// the error code "ConcurrentModificationException", which can occur if you try to add or remove elements while it's being iterated.
// Which I do because of my ArrayList.
void draw() {
  background(0);
  for (Ball ball : new ArrayList<Ball>(balls)) { 
    ball.update();
    ball.display();
    if (ball.hitsPlatform()) {
      hitCount++;
      if (hitCount % 10 == 0 && balls.size() < 10) {
        balls.add(new Ball(width / 2, height / 3, random(-3, 3), random(-3, -1)));
      }
    }
  }
  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Drawing a rectangle. In order to draw it I use the the parameter x, y, platformHeight, platformWidth.
  rect(platformX, height - platformHeight - 10, platformWidth, platformHeight);
  
// Hit count board og balls in the air.
  fill(255);
  textSize(16);
  text("hits: " + hitCount, 10, 20);
  text("balls in the air: " + balls.size(), width - 120, 20);
  
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  // Here I setup the text for when the ball hits the bottom.
  if (balls.isEmpty()) {
    textSize(26); 
    fill(255, 0, 0); 
    text("Press ENTER for new game", width / 2 - 145, height / 2);
  }
  
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  

  // Here I setup the controls of the platform. That includes left and right keys and speed of the platform.
  if (keyPressed) {
    if (keyCode == LEFT) platformX -= 10;
    if (keyCode == RIGHT) platformX += 10;
  }
  
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  

// I ensure the ball stays within the boundaries. I do this with a 'constrian'.
  platformX = constrain(platformX, 0, width - platformWidth); 
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// I would like the game to be restartable without having to close the program and open it again. Therefore, I thought -
//it would be really cool if pressing Enter could spawn a new ball. For the purpose, im using the 'keyPressed' method and creating -
// an 'if' statment where i set the ENTER key to act as a reset botton. This effectively remove all the balss, adds a new one, and resets the counter.
void keyPressed() {
  
  if (keyCode == ENTER || keyCode == RETURN) {
    balls.clear(); 
    balls.add(new Ball(width / 2, height / 3, 2, 3));
    hitCount = 0; 
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Here I define the 'ball' class and declare the variables 'float x' and 'y', and 'float speedX' and 'speedY'.
class Ball {
  float x, y;
  float speedX, speedY;

  Ball(float x, float y, float speedX, float speedY) {
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
// Here, I define the 'update'method. its purpose is to control how one of the balls, in the case, update its state.
// That is how a balls position on the screen is updated in relation to its speed and collision with the screen edges.
  void update() {
    x += speedX;
    y += speedY;
   
    if (x < ballRadius || x > width - ballRadius) {
      speedX *= -1;
      x += speedX;
    }
    if (y < ballRadius) {
      speedY *= -1;
      y += speedY;
    }

    if (y > height) {
      balls.remove(this); 
    }
  }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Here, I define the 'display' method. This method is called after the void update method to continuously display the ball -
// moving within my game.
  void display() {
    ellipse(x, y, ballRadius * 2, ballRadius * 2);
  }
  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// I use a boolean expression "boolean hitsPlatform()" to tell the program that the ball has hit the platform.
// I do this by comparing the ball's y-position with the game area's height, minus the platform's height, minus the ball's radius minus a margin of 10 pixels -
// to datermine the ball actually touches the platform.
//If the ball ball is detected to hit the platform, the y-direction speed (speedY *= 1; is inverted to simulate -
// a reflection, and the ball's y-position is adjusted to just above the platform.
// so all it comes down to the boolean expression, true or false.
  boolean hitsPlatform() {
    if (y > height - platformHeight - ballRadius - 10 && x > platformX && x < platformX + platformWidth) {
      speedY *= -1;
      y = height - platformHeight - ballRadius - 10;
      return true;
    }
    return false;
  }
  
}
