int x, y = 5;       // position of reset button
int w = 50;         // width of reset button
int h = 20;         // height of reset button
int cx = 20;        // position x of tiles
int cy = 35;        // position y of tiles
int cw = 800;       // width of tiles
int ch = 100;       // height of tiles
int width = 50;     // width of single tile
boolean restart = false;    // for testing of reset button
int[] deck = {};
boolean[] exposed = {};         // currently exposed cards
boolean[] matched = {};         // matched cards
int N = 16;         // length of deck
int turns;      // number of turns
int state;      // track num cards revealed

void setup() {
    size(840, 150);
    resetButtonColor = color(221, 160, 221);
    initializeDeck();
    newGame();
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
    text("Turns = " + turns, x + (w + 40), y + (h / 2));
    
    // cards
    fill(cardsColor);
    rect(cx, cy, cw, ch);

    // test clicked cards
    if(restart) {
        fill(color(255))
        rect(cx, cy, cw, ch);
    }

    // display already matched or currently exposed cards only
    fill(color(255));
    for (int i = 0; i < N; i++){
        if (matched[i]){
            text(deck[i], (cx + (width*i) + (width/2)), cy + (ch / 2));
        }
        else if (exposed[i]){
            text(deck[i], (cx + (width*i) + (width/2)), cy + (ch / 2));
        }
        line((cx + (width*i) + (width)), cy, (cx + (width*i) + (width)), cy + ch);
    }    
}

void mousePressed() {
    // start new game if reset clicked
    if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
        newGame();
    }

    // track revealed and matched cards
    if (mouseX >= cx && mouseX <= cx+cw && mouseY >= cy && mouseY <= cy+ch) {
        restart = true; 
    }
}

void newGame() {
    
    //numTurns = numTurns + 10;
    state = 0;
    turns = 0;
    shuffle();

    // reset matched or exposed cards
    for (int e = 0; e < N; e++){
        append(exposed, "True");
        append(matched, "True");
    }    
}

void initializeDeck() {
    // create deck with matchable cards
    cardsColor = color(147, 112, 219);
    for (int j = 0; j < 2; j++){
        for (int i = 0; i < (N/2); i++){
            append(deck, i);
        }
    }
    // for use in iteration of deck
    N = deck.length;
}

void shuffle(){  
    // randomize deck
    for (int i = 0; i < N; i++){ 
      int r = i + (int) (Math.random() * (N-i)); 
      String t = deck[r]; 
      deck[r] = deck[i]; 
      deck[i] = t; 
    }
} 