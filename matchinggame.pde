int x, y = 5;	// position of reset button
int w = 50;		// width of reset button
int h = 20;		// height of reset button
int cx = 20;    // position x of tiles
int cy = 35;    // position y of tiles
int cw = 800;   // width of tiles
int ch = 100;   // height of tiles
boolean restart = false;    // for testing of reset button

void setup() {
    size(840, 150);
    background(255);
    resetButtonColor = color(221, 160, 221);
    cardsColor = color(147, 112, 219);
} 

void draw() { 
    // reset button
    fill(resetButtonColor);
    stroke(255);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    fill(color(0));
    text("Reset", x + (w / 2), y + (h / 2));
    
    // cards
    fill(cardsColor);
    rect(cx, cy, cw, ch);

    // test reset button
    if(restart) {
        fill(color(255));
    }
    rect(cx, cy, cw, ch);
}

void mousePressed() {
	if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
		newGame();
	}
}

void newGame() {
    restart = true; 
}