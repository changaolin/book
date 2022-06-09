# PCMPLayer Demo(C)
```C
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <SDL.h>
#include <pthread.h>
#define BLOCK_SIZE 4096000
unsigned char* audio_buf = NULL;
unsigned char* audio_pos = NULL;
size_t buffer_len = 0;
void read_audio_data(void* userdatai, Uint8* stream, int len)
{
	if (buffer_len == 0) {
		return;
	}
	SDL_memset(stream, 0, len);
	len = (len < buffer_len) ? len : buffer_len;
	SDL_MixAudio(stream, audio_pos, len, SDL_MIX_MAXVOLUME);
	audio_pos += len;
	buffer_len -= len;
}
int main(int argc, char* argv[])
{
	if (SDL_Init(SDL_INIT_AUDIO) != 0) {
		SDL_Log("init fail!\n");
		return -1;
	}
	const char* path = "1.pcm";
	FILE* audio_fd = fopen(path, "r");
	if (audio_fd == NULL) {
		SDL_Log("open fail!\n");
		SDL_Quit();
		return -1;
	}
	audio_buf = malloc(BLOCK_SIZE);
	if (audio_buf == NULL) {
		SDL_Log("malloc fail!\n");
		fclose(audio_fd);
		SDL_Quit();
	}
	SDL_AudioSpec spec;
	spec.freq = 48000;
	spec.channels = 2;
	spec.format = AUDIO_S16SYS;
	spec.callback = read_audio_data;
	spec.userdata = NULL;
	if (SDL_OpenAudio(&spec, NULL) != 0) {
		SDL_Log("open audio fail!\n");
		fclose(audio_fd);
		free(audio_buf);
		SDL_Quit();
		return -1;
	}
	SDL_PauseAudio(0);
	do {
		buffer_len = fread(audio_buf, 1, BLOCK_SIZE, audio_fd);
		audio_pos = audio_buf;
		while (audio_pos < (audio_buf + buffer_len)) {
			SDL_Delay(1);
		}
	} while(buffer_len != 0);

	SDL_CloseAudio();
	fclose(audio_fd);
	free(audio_buf);
	SDL_Quit();
	return 0;
}	
```
