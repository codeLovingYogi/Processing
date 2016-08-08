int x = 20;         // x position of reset button
int y = 55;         // y position of reset button
int w = 50;         // cwidth of reset button
int h = 20;         // height of reset button
int cx = 20;        // position x of tiles
int cy = 85;        // position y of tiles
int cw = 800;       // cwidth of all tiles
int ch = 100;       // height of tiles
int cwidth = 50;    // width of single tile
int[] deck = {};
boolean[] exposed = {};     // currently exposed cards
int N = 16;         // length of deck
int numExposed = 0; // determine win
int turns;          // number of turns
int state;          // track num cards revealed
int card1;
int card2;
String message;
boolean win = false;

void setup() {
    size(840, 200);
    resetButtonColor = color(221, 160, 221);
    myFont = createFont("Sans-Serif", 16);
    textFont(myFont);
    initializeDeck();
    newGame();
} 

void draw() { 
    background(255);
    
    // reset button
    fill(resetButtonColor);
    stroke(255);
    rect(x, y, w, h);
    
    fill(color(0));
    textAlign(LEFT, CENTER);
    text(message, x, y / 2);
    textAlign(CENTER, CENTER);
    text("Reset", x + (w / 2), y + (h / 2));
    textAlign(RIGHT, CENTER);
    text("Turns = " + turns, width - 25, y + (h / 2));
    
    // cards
    fill(cardsColor);
    rect(cx, cy, cw, ch);

    // display exposed cards only
    fill(color(255));
    textAlign(CENTER, CENTER);
    for(int i = 0; i < N; i++){
        if(exposed[i]==true){
            text(deck[i], (cx + (cwidth*i) + (cwidth/2)), cy + (ch / 2));
        }
        line((cx + (cwidth*i) + (cwidth)), cy, (cx + (cwidth*i) + (cwidth)), cy + ch);
    } 
}

void mousePressed() {
    // reset clicked
    if(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
        newGame();
    }

    // cards clicked
    if(mouseX >= cx && mouseX <= cx+cw && mouseY >= cy && mouseY <= cy+ch) {
        playGame();
    }
}

void newGame() {
    state = 0;
    turns = 0;
    numExposed = 0;
    win = false;
    shuffle();

    // reset exposed cards
    for (int e = 0; e < N; e++){
        exposed[e] = false;
    } 
    
    message = "Welcome! Test your memory by clicking on two cards. Try to match all cards in the lowest number of turns."   
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

void playGame(){
    int clickIndex;
    
    // find card selected as index in deck
    clickIndex = floor((mouseX - cx) / cwidth);
    
    if(state == 0){
        state = 1;
        exposed[clickIndex] = true;
        card1 = clickIndex;
    } else if(state == 1){
        if(exposed[clickIndex] != true){
            state = 2;
            exposed[clickIndex] = true;
            card2 = clickIndex;
            turns++;
        }
    } else if(state==2){
        if(exposed[clickIndex] != true){
            if(deck[card1]!=deck[card2]){
                exposed[card1] = false;
                exposed[card2] = false;
            }
            else if(deck[card1]==deck[card2]){
                numExposed+= 2;
                if(numExposed==4){
                    message = "Congratulations, you win! Click 'Reset' to play again.";
                }
            }

            state = 1;
            exposed[clickIndex] = true;
            card1 = clickIndex;          
        }   
    }    
}