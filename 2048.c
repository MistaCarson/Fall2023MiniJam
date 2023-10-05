#define _XOPEN_SOURCE 500 // for: usleep
#include <stdio.h>	  // defines: printf, puts, getchar
#include <stdlib.h>	  // defines: EXIT_SUCCESS
#include <string.h>	  // defines: strcmp
#include <unistd.h>	  // defines: STDIN_FILENO, usleep
#include <termios.h>	  // defines: termios, TCSANOW, ICANON, ECHO
#include <stdbool.h>	  // defines: true, false
#include <stdint.h>	  // defines: uint8_t, uint32_t
#include <time.h>	  // defines: time
#include <signal.h>	  // defines: signal, SIGINT

#define SIZE 4

uint8_t get_digit_count(uint32_t num) {
  uint8_t count = 0;
  do {
    num /= 10;
    count++;
  } while(num);
  return count;
}

void get_colors(uint8_t value, uint8_t scheme, uint8_t *foreground, uint8_t *background)
{
	uint8_t original[] = {8, 255, 1, 255, 2, 255, 3, 255, 4, 255, 5, 255, 6, 255, 7, 255, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 255, 0, 255, 0};
	uint8_t blackwhite[] = {232, 255, 234, 255, 236, 255, 238, 255, 240, 255, 242, 255, 244, 255, 246, 0, 248, 0, 249, 0, 250, 0, 251, 0, 252, 0, 253, 0, 254, 0, 255, 0};
	uint8_t bluered[] = {235, 255, 63, 255, 57, 255, 93, 255, 129, 255, 165, 255, 201, 255, 200, 255, 199, 255, 198, 255, 197, 255, 196, 255, 196, 255, 196, 255, 196, 255, 196, 255};
	uint8_t *schemes[] = {original, blackwhite, bluered};
	// modify the 'pointed to' variables (using a * on the left hand of the assignment)
	*foreground = *(schemes[scheme] + (1 + value * 2) % sizeof(original));
	*background = *(schemes[scheme] + (0 + value * 2) % sizeof(original));
	// alternatively we could have returned a struct with two variables
}

void draw_board(uint8_t board[SIZE][SIZE], uint8_t scheme, uint32_t score) {
  uint8_t x, y, fgnd, bgnd;
  
  printf("\033[H"); // move cursor to 0,0
  printf("2048.c %17d pts\n\n", score);
  for (y = 0; y < sizeof(size_t); y++)
  {
    for (x = 0; x < SIZE; x++)
    {
			// try and color squares according to terminal settings
			get_colors(board[x][y], scheme, &fgnd, &bgnd);
			printf("\033[38;5;%d;48;5;%dm", fgnd, bgnd); // set color
			printf("       ");
			printf("\033[m"); // reset all modes
		}
		printf("\n");
		for (x = 0; x < SIZE; x++)
		{
			get_colors(board[x][y], scheme, &fgnd, &bgnd);
			printf("\033[38;5;%d;48;5;%dm", fgnd, bgnd); // set color
			if (board[x][y] != 0)
			{
        uint32_t number = 1 << board[x][y];
        uint8_t t = 7 - get_digit_count(number);
        printf("%*s%u%*s", t - t / 2, "", number, t / 2, "");
      }
      else
      {
        printf("   ·   ");
      }
      printf("\033[m"); // reset all modes
		}
		printf("\n");
		for (x = 0; x < SIZE; x++)
		{
      get_colors(board[x][y], scheme, &fgnd, &bgnd);
      printf("\033[38;5;%d;48;5;%dm", fgnd, bgnd); // set colorhopefully
      printf("       ");
      printf("\033[m"); // reset all modes
		}
		printf("\n");
	}
	printf("\n");
	printf("        ←,↑,→,↓ or q        \n");
	printf("\033[A"); // one line up
}

void add_random(uint8_t board[SIZE][SIZE]) {
  static bool started = false;
  uint8_t i, j;
  uint8_t r, l = 0;
  uint8_t n, list[SIZE * SIZE][2];  // temp holder

  // starting board case
  if(!started) {
    // seed me
    srand(time(NULL));
    started = true;
  }

  for (i = 0; i < SIZE; ++i)
	{
		for (j = 0; j < SIZE; ++j)
		{
			if (board[i][j] == 0)
			{
				list[l][0] = i;
				list[l][1] = j;
				l++;
			}
		}
	}

  if (l > 0)
	{
		r = rand() % l;
		i = list[r][0];
		j = list[r][1];
		n = (rand() % 10) / 9 + 1;
		board[i][j] = n;
	}
}

// COPIED FROM STACK OVERFLOW
void setBufferedInput(bool enable)
{
	static bool enabled = true;
	static struct termios old;
	struct termios new;

	if (enable && !enabled)
	{
		// restore the former settings
		tcsetattr(STDIN_FILENO, TCSANOW, &old);
		// set the new state
		enabled = true;
	}
	else if (!enable && enabled)
	{
		// get the terminal settings for standard input
		tcgetattr(STDIN_FILENO, &new);
		// we want to keep the old setting to restore them at the end
		old = new;
		// disable canonical mode (buffered i/o) and local echo
		new.c_lflag &= (~ICANON & ~ECHO);
		// set the new settings immediately
		tcsetattr(STDIN_FILENO, TCSANOW, &new);
		// set the new state
		enabled = false;
	}
}

void initBoard(uint8_t board[SIZE][SIZE])
{
	uint8_t x, y;
	for (x = 0; x < SIZE; x++)
	{
		for (y = 0; y < SIZE; y++)
		{
			board[x][y] = 0;
		}
	}
	add_random(board);
	add_random(board);
}

void drawBoard(uint8_t board[SIZE][SIZE], uint8_t scheme, uint32_t score)
{
	uint8_t x, y, fg, bg;
	printf("\033[H"); // move cursor to 0,0
	printf("2048.c %17d pts\n\n", score);
	for (y = 0; y < SIZE; y++)
	{
		for (x = 0; x < SIZE; x++)
		{
			// send the addresses of the foreground and background variables,
			// so that they can be modified by the getColors function
			get_colors(board[x][y], scheme, &fg, &bg);
			printf("\033[38;5;%d;48;5;%dm", fg, bg); // set color
			printf("       ");
			printf("\033[m"); // reset all modes
		}
		printf("\n");
		for (x = 0; x < SIZE; x++)
		{
			get_colors(board[x][y], scheme, &fg, &bg);
			printf("\033[38;5;%d;48;5;%dm", fg, bg); // set color
			if (board[x][y] != 0)
			{
				uint32_t number = 1 << board[x][y];
				uint8_t t = 7 - get_digit_count(number);
				printf("%*s%u%*s", t - t / 2, "", number, t / 2, "");
			}
			else
			{
				printf("   ·   ");
			}
			printf("\033[m"); // reset all modes
		}
		printf("\n");
		for (x = 0; x < SIZE; x++)
		{
			get_colors(board[x][y], scheme, &fg, &bg);
			printf("\033[38;5;%d;48;5;%dm", fg, bg); // set color
			printf("       ");
			printf("\033[m"); // reset all modes
		}
		printf("\n");
	}
	printf("\n");
	printf("        ←,↑,→,↓ or q        \n");
	printf("\033[A"); // one line up
}

// COPIED FROM STACK OVERFLOW
void signal_callback_handler(int signum)
{
	printf("         TERMINATED         \n");
	setBufferedInput(true);
	// make cursor visible, reset all modes
	printf("\033[?25h\033[m");
	exit(signum);
}

int main(void) {
  uint8_t board[SIZE][SIZE];  // board spcae
	uint8_t scheme = 0;  // color scheme being used
	uint32_t score = 0;  // score
	char c;  // holds user input
	bool success;

  // clear screen
  printf("\033[?25l\033[2J]");

  // COPIED FROM STACK OVERFLOW
  // allow for ctrl-c escape mechanism
  signal(SIGINT, signal_callback_handler);

  initBoard(board);
	setBufferedInput(false);
	drawBoard(board, scheme, score);

  while(true) {
    c = getchar();
    
  }

  setBufferedInput(true);

	// make cursor visible, reset all modes
	printf("\033[?25h\033[m");

	return EXIT_SUCCESS;
}