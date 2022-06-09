# YUVPLayer Demo
```C

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <SDL.h>
#include <pthread.h>
#define REFRESH_EVENT (SDL_USEREVENT + 1)
#define QUIT_EVENT (SDL_USEREVENT + 2)
bool thread_exit = false;
int refresh()
{
	thread_exit = false;
	while (!thread_exit) {
		SDL_Event event;
		event.type = REFRESH_EVENT;
		SDL_PushEvent(&event);
		SDL_Delay(40);
	}
	thread_exit = true;

	SDL_Event event;
	event.type = QUIT_EVENT;
	SDL_PushEvent(&event);
	return 0;
}
int main(int argc, char* argv[])
{
	FILE* video_fd = NULL;

	SDL_Event event = {0};
	SDL_Rect rect = {0};

	unsigned int pixformat = 0;
	
	SDL_Window* window = NULL;
	SDL_Renderer* renderer = NULL;
	SDL_Texture* texture = NULL;
	SDL_Thread* timer_thread = NULL;

	int win_w = 1920;
	int win_h = 1080;
	const int video_w = win_w;
	const int video_h = win_h;
	
	unsigned char* video_pos = NULL;
	unsigned char* video_end = NULL;

	unsigned int remain_len = 0;
	size_t video_buffer_len = 0;
	size_t blank_space_len = 0;
	unsigned char* video_buf = NULL;

	const char* path = "1.yuv";
	const unsigned int yuv_frame_len = video_w * video_h * 12 / 8;
	unsigned int tmp_yuv_frame_len = yuv_frame_len;

	if (yuv_frame_len & 0xF) {
		tmp_yuv_frame_len = (yuv_frame_len & 0xFFF0) + 0x10;
	}

	if (SDL_Init(SDL_INIT_VIDEO)) {
		printf("SDL INIT Fail!\n");
		return -1;
	}
	window = SDL_CreateWindow(
			"YUV Player",
			SDL_WINDOWPOS_UNDEFINED,
			SDL_WINDOWPOS_UNDEFINED,
			win_w, win_h,
			SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE
	);
	if (window == NULL) {
		printf("Window create Fail!\n");
		// TODO 资源释放
		return -1;
	} 
	renderer = SDL_CreateRenderer(window, -1, 0);
	// IYVU: Y + U + V (3 planes)
	// YV12: Y + V + U (3 planes)
	pixformat = SDL_PIXELFORMAT_IYUV;
	texture = SDL_CreateTexture(
							renderer,
							pixformat,
							SDL_TEXTUREACCESS_STREAMING,
							video_w, video_h
							);

	video_buf = (unsigned char*) malloc(tmp_yuv_frame_len);
	if (video_buf == NULL) {
		// TODO 资源释放
		return -1;
	}
	video_fd = fopen(path, "r");
	video_buffer_len = fread(video_buf, 1, yuv_frame_len, video_fd);
	if (video_buffer_len <= 0) {
		return -1;
	}
	video_pos = video_buf;
	timer_thread = SDL_CreateThread(
		refresh,
		"thread",
		NULL
	);
	do {
		SDL_WaitEvent(&event);
		if (event.type == REFRESH_EVENT) {
			SDL_UpdateTexture(texture, NULL, video_pos, video_w);
			rect.x = 0;
			rect.y = 0;
			rect.w = win_w;
			rect.h = win_h;
			SDL_RenderCopy(renderer, texture, NULL, &rect);
			SDL_RenderPresent(renderer);

			video_buffer_len = fread(video_buf, 1, yuv_frame_len, video_fd);
			if (video_buffer_len <= 0) {
				thread_exit = true;
				continue;
			}
		} else if (event.type == SDL_WINDOWEVENT) {
			SDL_GetWindowSize(window, &win_w, &win_h);
		} else if (event.type == SDL_QUIT) {
			thread_exit = true;
		} else if (event.type == QUIT_EVENT) {
			break;
		}
	} while(1);
	return 0;
}
```
