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
int N = 16;         // length of deck
int turns;          // number of turns
int state;          // track num cards revealed
int card1;
int card2;

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

    // display exposed cards only
    fill(color(255));
    for(int i = 0; i < N; i++){
        if(exposed[i]=="True"){
            text(deck[i], (cx + (width*i) + (width/2)), cy + (ch / 2));
        }
        line((cx + (width*i) + (width)), cy, (cx + (width*i) + (width)), cy + ch);
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
    shuffle();

    // reset exposed cards
    for (int e = 0; e < N; e++){
        //append(exposed, "False");
        exposed[e] = "False";
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

void playGame(){
    int clickIndex;
    
    // find card selected as index in deck
    clickIndex = floor((mouseX - cx) / width);
    
    if(state == 0){
        state = 1;
        exposed[clickIndex] = "True";
        card1 = clickIndex;
    } else if(state == 1){
        if(exposed[clickIndex] != "True"){
            state = 2;
            exposed[clickIndex] = "True";
            card2 = clickIndex;
            turns++;
        }
    } else if(state==2){
        //state = 0;
        if(exposed[clickIndex] != "True"){
            if(deck[card1]!=deck[card2]){
                exposed[card1] = "False";
                exposed[card2] = "False";
            }
            state = 1;
            exposed[clickIndex] = "True";
            card1 = clickIndex;
        }   
    }    
}