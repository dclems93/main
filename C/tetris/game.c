/* game.c --- 
 * 
 * Filename: game.c
 * Description: 
 * Author: Bryce Himebaugh
 * Maintainer: 
 * Created: Tue Sep  6 11:08:59 2016
 * Last-Updated: 
 *           By: 
 *     Update #: 0
 * Keywords: 
 * Compatibility: 
 * 
 */

/* Commentary: 
 * 
 * 
 * 
 */

/* Change log:
 * 
 * 
 */

/* Copyright (c) 2016 The Trustees of Indiana University and 
 * Indiana University Research and Technology Corporation.  
 * 
 * All rights reserved. 
 * 
 * Additional copyrights may follow 
 */

/* Code: */
#include <unistd.h> 
#include <ncurses.h>
#include <time.h>
#include "highscore.h"
#include "game.h"
#include "well.h"
#include "tetris.h"
#include "tetromino.h"
#include "key.h"

void init_game(void) {
  int x,y;
}

highscore_t *game(highscore_t *highscores) {
  static int state = INIT;
  tetromino_t *next = NULL;
  tetromino_t *current = NULL;
  well_t *w;
  int x,y;
  int c;
  int arrow;
  struct timespec tim = {0,1000000};
  struct timespec tim_ret;
  int move_counter = 0;
  int move_timeout = 500;
  int status;
  int counter = 0;
  int lines_cleared = 0;
  int score = 0;
  char str[80];
  char m;
  int n = 0;
  //int rand_color;
  int z;
  highscore_t listss[10];
  char stored_scores[11] = "highscores";
  char intls[4] = "ABC";

  while(1) {
    switch(state) {
    case INIT:               // Initialize the game, only run one time 
      initscr();
      noecho();              // Do not echo input characters 
      getmaxyx(stdscr,y,x);  // Get the screen dimensions 
      w = init_well(((x/2)-(WELL_WIDTH/2)),3,WELL_WIDTH,WELL_HEIGHT);

      mvprintw(2,x/2-5,"  Tetris  ");
      mvprintw(3,x/2-15,"In soviet russia, game plays you!");
      mvprintw(4,x/2-15,"################################");;
      mvprintw(16,x/2-11,"Click s to insert coin!"); 

      while(n != 1){
	m = getch();
	if(m=='s'){
	  n += 1;
	}
      }
      nodelay(stdscr,TRUE);  // Do not wait for characters using getch.
      clear();
      draw_well(w);
      srand(time(NULL));     // Seed the random number generator with the time. Used in create tet. 
      display_score(score, w->upper_left_x-15,w->upper_left_y);
      state = ADD_PIECE;
      break;
    case ADD_PIECE:          // Add a new piece to the game
      if (next){
	undisplay_tetromino(next);
	status = move_tet(next, w->upper_left_x+(w->width/2), w->upper_left_y);
	current = next;
	//status = move_tet(current, current->upper_left_x, current->upper_left_y);
	if(status == MOVE_FAILED){
	  state = GAME_OVER;
	  break;
	}
	//rand_color = rand()%7;
	next = create_tetromino(w->upper_left_x-12, w->upper_left_y+1);
	display_tetromino(next);
      }
      else {
	//rand_color = rand()%7 -1;
	current = create_tetromino((w->upper_left_x+(w->width/2)), w->upper_left_y);
	//rand_color = rand()%7 -1;
	next = create_tetromino(w->upper_left_x-12, w->upper_left_y+1);
	display_tetromino(next);
      }
      display_tetromino(current);
      state = MOVE_PIECE;
      break;
    case MOVE_PIECE:         // Move the current piece
      if ((arrow = read_escape(&c)) != NOCHAR) {
	if (arrow == UP) {
	  undisplay_tetromino(current);
	  rotate_ccw(current);
	  display_tetromino(current);
	}
	else if (arrow == DOWN) {
	  undisplay_tetromino(current);
	  rotate_cw(current);
	  display_tetromino(current);
	}
	else if (arrow == LEFT) {
	  undisplay_tetromino(current);
	  move_tet(current,current->upper_left_x-1,current->upper_left_y);
	  display_tetromino(current);
	}
	else if (arrow == RIGHT) {
	  undisplay_tetromino(current);
	  move_tet(current,current->upper_left_x+1,current->upper_left_y);
	  display_tetromino(current);
	}
      	else if (arrow == REGCHAR) {
	  if (c == ' ') {
	    move_timeout = DROP_RATE;
 	  }
	  if (c == 'q') {
	    state = GAME_OVER;
 	  }
	}
      } 
      if (move_counter++ >= move_timeout) {
	counter++;
	undisplay_tetromino(current);
	status = move_tet(current,current->upper_left_x,current->upper_left_y+1);
	display_tetromino(current);
	if (status == MOVE_FAILED) {
	  status = prune_well(w);
	  score = compute_score(score,status);
	  display_score(score, w->upper_left_x-15,w->upper_left_y);
	  state = ADD_PIECE;
	  move_timeout = BASE_FALL_RATE;
	}
	move_counter = 0;
      }
      break;
    case GAME_OVER:
      nodelay(stdscr,FALSE);
      clear();
      // highscore_t listss[10];
      // char stored_scores[11] = "highscores";
      // char intls[4] = "ABC";
      // highscores = game(highscores);
      //listss = load_scores(stored_scores);
      //int i;
      //for(i = 0; i < 10; i++){
	//listss[i] = *load_scores(stored_scores);
	//}

      insert_score(listss,intls,100);
      //store_scores(stored_scores, listss);
      // getmaxyx(stdscr,y,x);
      mvprintw(1,x/2-5,"  GAME_OVER  ");
      mvprintw(2,x/2-5,"#############");
      mvprintw(6,x/2-5,"SCORE:%8d",score);
      //print_score_list(listss, 8, x/2-5, 10);
      //highscore = load_scores(highscores);
      // store_scores("highscores",score)
      mvprintw(16,x/2-5,"Hit q to exit");
      getch(); // Wait for a key to be pressed. 
      state = EXIT;
      break;
    case EXIT:
      return(highscores);  // Return the highscore structure back to main to be stored on disk. 
      break;
    }
    refresh();
    nanosleep(&tim,&tim_ret);
  }
}

/* game.c ends here */
