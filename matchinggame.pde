int x, y = 5;	// position of reset button
int w = 50;		// width of reset button
int h = 20;		// height of reset button
int cx = 20;    // position x of tiles
int cy = 35;    // position y of tiles
int cw = 800;   // width of tiles
int ch = 100;   // height of tiles
int numTurns = 0;   // number of turns
boolean restart = false;    // for testing of reset button
int[] list1 = {};
int[] list2 = {};
int[] deck = {};

void setup() {
    size(840, 150);
    resetButtonColor = color(221, 160, 221);
    cardsColor = color(147, 112, 219);
    for (int i = 0; i < 8; i = i+1) {
        append(list1, i);
        append(list2, i);
    }
    deck = concat(list1, list2);
} 

void draw() { 
    background(255);
    // reset button
    fill(resetButtonColor);
    stroke(255);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    fill(color(0));
    text("Reset", x + (w / 2), y + (h / 2));
    textAlign(CENTER, CENTER);
    text("Turns = " + numTurns, x + (w + 40), y + (h / 2));
    
    // cards
    fill(cardsColor);
    rect(cx, cy, cw, ch);

    // test reset button
    if(restart) {
        fill(color(255));
    }
    rect(cx, cy, cw, ch);

    text(list1[0], 5, height/2);
    text(deck.length, 5, height/3);
}

void mousePressed() {
	if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
		newGame();
	}
    //text(numTurns, x + (w + 70), y + (h / 2));
}

void newGame() {
    restart = true; 
    numTurns = numTurns + 10;
}
