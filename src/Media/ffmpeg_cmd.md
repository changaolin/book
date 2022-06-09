# FFMPEG 命令行学习

# [命令分类](http://ffmpeg.org/ffmpeg.html)

## 0. 基本格式

```shell
ffmpeg [global_options] {[input_file_options] -i input_url} ... {[output_file_options] output_url} ...
```

## Input_url (-i)

- regular files
- pipes
- network streams
- grabbing devices
- Based 0 numbers
- ...

## Input or output data types

- video
- audios
- subtitles
- attachment
- data

## Stream

###  selection

- -map (attachment streams can only use map)
- -vn
- -an
- -sn
- -dn

### handling

- -codec

### example

```
input file 'A.avi'
      stream 0: video 640x360
      stream 1: audio 2 channels

input file 'B.mp4'
      stream 0: video 1920x1080
      stream 1: audio 2 channels
      stream 2: subtitles (text)
      stream 3: audio 5.1 channels
      stream 4: subtitles (text)

input file 'C.mkv'
      stream 0: video 1280x720
      stream 1: audio 2 channels
      stream 2: subtitles (image)
      
ffmpeg -i A.avi -i B.mp4 out1.mkv out2.wav -map 1:a -c:a copy out3.mov
MKV: a/v/s from B-0/B-3/B-2
WAV: a B-3
out3.mov/MAP: B-Audio
```

```
ffmpeg -i C.mkv out1.mkv -c:s dvdsub -an out2.mkv
```

```
ffmpeg -i A.avi -i C.mkv -i B.mp4 -filter_complex "overlay" out1.mp4 out2.srt
```

```
ffmpeg -i A.avi -i B.mp4 -i C.mkv -filter_complex "[1:v]hue=s=0[outv];overlay;aresample" \
       -map '[outv]' -an        out1.mp4 \
                                out2.mkv \
       -map '[outv]' -map 1:a:0 out3.mkv
fail
```

```
ffmpeg -i A.avi -i B.mp4 -i C.mkv -filter_complex "[1:v]hue=s=0[outv];overlay;aresample" \
       -an        out1.mp4 \
                  out2.mkv \
       -map 1:a:0 out3.mkv
       
fail
```

```
ffmpeg -i A.avi -i B.mp4 -i C.mkv -filter_complex "[1:v]hue=s=0,split=2[outv1][outv2];overlay;aresample" \
        -map '[outv1]' -an        out1.mp4 \
                                  out2.mkv \
        -map '[outv2]' -map 1:a:0 out3.mkv
success
```



## 基本流程

```
 _______              ______________
|       |            |              |
| input |  demuxer   | encoded data |   decoder
| file  | ---------> | packets      | -----+
|_______|            |______________|      |
                                           v
                                       _________
                                      |         |
                                      | decoded |
                                      | frames  |
                                      |_________|
 ________             ______________       |
|        |           |              |      |
| output | <-------- | encoded data | <----+
| file   |   muxer   | packets      |   encoder
|________|           |______________|


```

## Filtering（-vf or -af）

### simple filtergraphs

```
 _________                        ______________
|         |                      |              |
| decoded |                      | encoded data |
| frames  |\                   _ | packets      |
|_________| \                  /||______________|
             \   __________   /
  simple     _\||          | /  encoder
  filtergraph   | filtered |/
                | frames   |
                |__________|

```

### filter for video

```
 _______        _____________        _______        ________
|       |      |             |      |       |      |        |
| input | ---> | deinterlace | ---> | scale | ---> | output |
|_______|      |_____________|      |_______|      |________|

```



## Complex filter graphs

```
 _________
|         |
| input 0 |\                    __________
|_________| \                  |          |
             \   _________    /| output 0 |
              \ |         |  / |__________|
 _________     \| complex | /
|         |     |         |/
| input 1 |---->| filter  |\
|_________|     |         | \   __________
               /| graph   |  \ |          |
              / |         |   \| output 1 |
 _________   /  |_________|    |__________|
|         | /
| input 2 |/
|_________|

```



## Stream Copy

```
 _______              ______________            ________
|       |            |              |          |        |
| input |  demuxer   | encoded data |  muxer   | output |
| file  | ---------> | packets      | -------> | file   |
|_______|            |______________|          |________|

```

## 1. 通用查询参数

- -formats

​	Show available formats (including devices).

- -demuxers

​	Show available demuxers.

- -muxers

​	Show available muxers.

- -devices

​	Show available devices.

- -codecs

​	Show all codecs known to libavcodec.

- -decoders

​	Show available decoders.

- -encoders

​	Show all available encoders.

- -bsfs

​	Show available bitstream filters.

- -protocols

​	Show available protocols.

- -filters

​	Show available libavfilter filters.

- -pix_fmts

​	Show available pixel formats.

- -sample_fmts

​	Show available sample formats.

- -layouts

​	Show channel names and standard channel layouts.



## 2. AV参数

- -f fmt (*input/output*)

  Force input or output file format. The format is normally auto detected for input files and guessed from the file extension for output files, so this option is not needed in most cases.

- -i url (*input*)

  input file url

- -c[:stream_specifier] codec (*input/output,per-stream*)

  -codec[:stream_specifier] codec (*input/output,per-stream*)

  Select an encoder (when used before an output file) or a decoder (when used before an input file) for one or more streams. codec is the name of a decoder/encoder or a special value `copy` (output only) to indicate that the stream is not to be re-encoded.

- -t duration (*input/output*)

  When used as an input option (before `-i`), limit the duration of data read from the input file.

  When used as an output option (before an output url), stop writing the output after its duration reaches duration.

  duration must be a time duration specification, see [(ffmpeg-utils)the Time duration section in the ffmpeg-utils(1) manual](http://ffmpeg.org/ffmpeg-utils.html#time-duration-syntax).

  -to and -t are mutually exclusive and -t has priority.

- -to position (*input/output*)

  Stop writing the output or reading the input at position. position must be a time duration specification, see [(ffmpeg-utils)the Time duration section in the ffmpeg-utils(1) manual](http://ffmpeg.org/ffmpeg-utils.html#time-duration-syntax).

  -to and -t are mutually exclusive and -t has priority.

- -ss position (*input/output*)

  When used as an input option (before `-i`), seeks in this input file to position. Note that in most formats it is not possible to seek exactly, so `ffmpeg` will seek to the closest seek point before position. When transcoding and -accurate_seek is enabled (the default), this extra segment between the seek point and position will be decoded and discarded. When doing stream copy or when -noaccurate_seek is used, it will be preserved.

  When used as an output option (before an output url), decodes but discards input until the timestamps reach position.

- -filter[:stream_specifier] filtergraph (*output,per-stream*)

  Create the filtergraph specified by filtergraph and use it to filter the stream.

  filtergraph is a description of the filtergraph to apply to the stream, and must have a single input and a single output of the same type of the stream. In the filtergraph, the input is associated to the label `in`, and the output to the label `out`. See the ffmpeg-filters manual for more information about the filtergraph syntax.

  See the [-filter_complex option](http://ffmpeg.org/ffmpeg.html#filter_005fcomplex_005foption) if you want to create filtergraphs with multiple inputs and/or outputs.

- ffmpeg -f avfoundation -list_devices true -i ""

## 3. Video参数

- -r[:stream_specifier] fps (*input/output,per-stream*)

  Set frame rate (Hz value, fraction or abbreviation).

  As an input option, ignore any timestamps stored in the file and instead generate timestamps assuming constant frame rate fps. This is not the same as the -framerate option used for some input formats like image2 or v4l2 (it used to be the same in older versions of FFmpeg). If in doubt use -framerate instead of the input option -r.

  As an output option, duplicate or drop input frames to achieve constant output frame rate fps.

- -fpsmax[:stream_specifier] fps (*output,per-stream*)

  Set maximum frame rate (Hz value, fraction or abbreviation).

  Clamps output frame rate when output framerate is auto-set and is higher than this value. Useful in batch processing or when input framerate is wrongly detected as very high. It cannot be set together with `-r`. It is ignored during streamcopy.

- -s[:stream_specifier] size (*input/output,per-stream*)

  Set frame size.

  As an input option, this is a shortcut for the video_size private option, recognized by some demuxers for which the frame size is either not stored in the file or is configurable – e.g. raw video or video grabbers.

  As an output option, this inserts the `scale` video filter to the *end* of the corresponding filtergraph. Please use the `scale` filter directly to insert it at the beginning or some other place.

  The format is ‘wxh’ (default - same as source).

- -vn (*input/output*)

  As an input option, blocks all video streams of a file from being filtered or being automatically selected or mapped for any output. See `-discard` option to disable streams individually.

  As an output option, disables video recording i.e. automatic selection or mapping of any video stream. For full manual control see the `-map` option.

- -vcodec codec (*output*)

  Set the video codec. This is an alias for `-codec:v`.

- -vf filtergraph (*output*)

  Create the filtergraph specified by filtergraph and use it to filter the stream.

  This is an alias for `-filter:v`, see the [-filter option](http://ffmpeg.org/ffmpeg.html#filter_005foption).

- -pix_fmt[:stream_specifier] format (*input/output,per-stream*)

  -pixel_format

  Set pixel format. Use `-pix_fmts` to show all the supported pixel formats. If the selected pixel format can not be selected, ffmpeg will print a warning and select the best pixel format supported by the encoder. If pix_fmt is prefixed by a `+`, ffmpeg will exit with an error if the requested pixel format can not be selected, and automatic conversions inside filtergraphs are disabled. If pix_fmt is a single `+`, ffmpeg selects the same pixel format as the input (or graph output) and automatic conversions are disabled.

## 4. Audio参数

- -aq q (*output*)

  Set the audio quality (codec-specific, VBR). This is an alias for -q:a.

- -ac[:stream_specifier] channels (*input/output,per-stream*)

  Set the number of audio channels. For output streams it is set by default to the number of input audio channels. For input streams this option only makes sense for audio grabbing devices and raw demuxers and is mapped to the corresponding demuxer options.

- -an (*input/output*)

  As an input option, blocks all audio streams of a file from being filtered or being automatically selected or mapped for any output. See `-discard` option to disable streams individually.

  As an output option, disables audio recording i.e. automatic selection or mapping of any audio stream. For full manual control see the `-map` option.

- -acodec codec (*input/output*)

  Set the audio codec. This is an alias for `-codec:a`.

- -sample_fmt[:stream_specifier] sample_fmt (*output,per-stream*)

  Set the audio sample format. Use `-sample_fmts` to get a list of supported sample formats.

- -af filtergraph (*output*)

  Create the filtergraph specified by filtergraph and use it to filter the stream.

  This is an alias for `-filter:a`, see the [-filter option](http://ffmpeg.org/ffmpeg.html#filter_005foption).

- -ar

- -f sl6le
