# Mini-Redis

[toc]

## Struct 列表

| file                       | struct                           | desp |
| -------------------------- | -------------------------------- | ---- |
| shutdown.rs                | pub(crate) struct Shutdown{}     |      |
| clients/blocking_client.rs | pub struct BlockingClient {}     |      |
| clients/blocking_client.rs | pub struct BlockingSubscriber {} |      |
| clients/blocking_client.rs | struct SubscriberIterator {}     |      |
| clients/client.rs          | pub struct Client {}             |      |
| clients/client.rs          | pub struct Subscriber {}         |      |
| clients/client.rs          | pub struct Message {}            |      |
| clients/buffered_client.rs | pub struct BufferedClient {}     |      |
| cmd/subscribe.rs           | pub struct Subscribe{}           |      |
| cmd/subscribe.rs           | pub struct Unsubscribe{}         |      |
| cmd/unknown.rs             | pub struct Unknown {}            |      |
| cmd/get.rs                 | pub struct Get {}                |      |
| cmd/ping.rs                | pub struct Ping {}               |      |
| cmd/publish.rs             | pub struct Publish {}            |      |
| cmd/set.rs                 | pub struct Set {}                |      |
| bin/cli.rs                 | struct Cli {}                    |      |
| bin/server.rs              | struct Cli {}                    |      |
| server.rs                  | struct Listener {}               |      |
| server.rs                  | struct Handler{}                 |      |
| db.rs                      | pub(crate) struct DbDropGuard {} |      |
| db.rs                      | pub(crate) struct Db {}          |      |
| db.rs                      | struct Shared {}                 |      |
| db.rs                      | struct State {}                  |      |
| db.rs                      | struct Entry {}                  |      |
| parse.rs                   | pub(crate) struct Parse {}       |      |
| connection.rs              | pub struct Connection{}          |      |

## enum 列表

| file                       | enum                          | desc                                                         |
| -------------------------- | ----------------------------- | ------------------------------------------------------------ |
| clients/buffered_client.rs | enum Command {}               | Get(String), Set(String, Bytes),                             |
| cmd/mod.rs                 | pub enum Command {}           | Get(Get), Publish(Publish), Set(Set), Subscribe(Subscribe), Unsubscribe(Unsubscribe), Ping(Ping), Unknown(Unknown), |
| bin/cli.rs                 | enum Command {}               | Ping, Get, Set, Publish, Subscribe                           |
| parse.rs                   | pub(crate) enum ParseError {} | EndOfStream,  Other(crate::Error),                           |
| frame.rs                   | pub enum Frame {}             | Simple(String), Error(String), Integer(u64), Bulk(Bytes), Null, Array(Vec\<Frame>), |
| frame.rs                   | pub enum Error {}             | Incomplete,  Other(crate::Error),                            |

## fn 列表

| file | fn   | desc |
| ---- | ---- | ---- |
|shutdown.rs|pub(crate) fn new(notify: broadcast::Receiver<()>) -> Shutdown {}||
|shutdown.rs|pub(crate) fn is_shutdown(&self) -> bool {}||
|shutdown.rs|pub(crate) async fn recv(&mut self) {}||
|clients/blocking_client.rs|pub fn connect<T: ToSocketAddrs>(addr: T) -> crate::Result\<BlockingClient> {}||
|clients/blocking_client.rs|pub fn get(&mut self, key: &str) -> crate::Result<Option\<Bytes>> {}||
|clients/blocking_client.rs|pub fn set(&mut self, key: &str, value: Bytes) -> crate::Result\<()> {}||
|clients/blocking_client.rs|pub fn set_expires( &mut self,  key: &str,  value: Bytes,  expiration: Duration, ) -> crate::Result<()> {}||
|clients/blocking_client.rs|pub fn publish(&mut self, channel: &str, message: Bytes) -> crate::Result\<u64> {}||
|clients/blocking_client.rs|pub fn subscribe(self, channels: Vec\<String>) -> crate::Result\<BlockingSubscriber> {}||
|clients/blocking_client.rs|pub fn get_subscribed(&self) -> &[String] {}||
|clients/blocking_client.rs|pub fn next_message(&mut self) -> crate::Result<Option\<Message>> {}||
|clients/blocking_client.rs|pub fn into_iter(self) -> impl Iterator<Item = crate::Result\<Message>> {}||
|clients/blocking_client.rs|pub fn subscribe(&mut self, channels: &[String]) -> crate::Result<()> {}||
|clients/blocking_client.rs|pub fn unsubscribe(&mut self, channels: &[String]) -> crate::Result<()> {}||
|clients/blocking_client.rs|fn next(&mut self) -> Option\<crate::Result\<Message>> {}||
|clients/client.rs|pub async fn connect<T: ToSocketAddrs>(addr: T) -> crate::Result\<Client> {}||
|clients/client.rs|pub async fn ping(&mut self, msg: Option\<Bytes>) -> crate::Result\<Bytes> {}||
|clients/client.rs|pub async fn get(&mut self, key: &str) -> crate::Result<Option\<Bytes>> {}||
|clients/client.rs|pub async fn set(&mut self, key: &str, value: Bytes) -> crate::Result<()> {}||
|clients/client.rs|pub async fn set_expires( &mut self,  key: &str, value: Bytes, expiration: Duration, ) -> crate::Result<()> {}||
|clients/client.rs|async fn set_cmd(&mut self, cmd: Set) -> crate::Result<()> {}||
|clients/client.rs|pub async fn publish(&mut self, channel: &str, message: Bytes) -> crate::Result\<u64> {}||
|clients/client.rs|pub async fn subscribe(mut self, channels: Vec\<String>) -> crate::Result\<Subscriber> {}||
|clients/client.rs|async fn subscribe_cmd(&mut self, channels: &[String]) -> crate::Result<()> {}||
|clients/client.rs|async fn read_response(&mut self) -> crate::Result\<Frame> {}||
|clients/client.rs|pub fn get_subscribed(&self) -> &[String] {}||
|clients/client.rs|pub async fn next_message(&mut self) -> crate::Result<Option\<Message>> {}||
|clients/client.rs|pub fn into_stream(mut self) -> impl Stream<Item = crate::Result\<Message>> {}||
|clients/client.rs|pub async fn subscribe(&mut self, channels: &[String]) -> crate::Result<()> {}||
|clients/client.rs|pub async fn unsubscribe(&mut self, channels: &[String]) -> crate::Result<()> {}||
|clients/buffered_client.rs|async fn run(mut client: Client, mut rx: Receiver\<Message>) {}||
|clients/buffered_client.rs|pub fn buffer(client: Client) -> BufferedClient {}||
|clients/buffered_client.rs|pub async fn get(&mut self, key: &str) -> Result<Option\<Bytes>> {}||
|clients/buffered_client.rs|pub async fn set(&mut self, key: &str, value: Bytes) -> Result<()> {}||
|cmd/subscribe.rs|pub(crate) fn new(channels: Vec\<String>) -> Subscribe {}||
|cmd/subscribe.rs|pub(crate) fn parse_frames(parse: &mut Parse) -> crate::Result\<Subscribe> {}||
|cmd/subscribe.rs|pub(crate) async fn apply(mut self, db: &Db, dst: &mut Connection, shutdown: &mut Shutdown, ) -> crate::Result<()> {}||
|cmd/subscribe.rs|pub(crate) fn into_frame(self) -> Frame {}||
|cmd/subscribe.rs|async fn subscribe_to_channel(channel_name: String, subscriptions: &mut StreamMap<String, Messages>, db: &Db, dst: &mut Connection, ) -> crate::Result<()> {}||
|cmd/subscribe.rs|async fn handle_command(frame: Frame,  subscribe_to: &mut Vec\<String>,     subscriptions: &mut StreamMap<String, Messages>,  dst: &mut Connection, ) -> crate::Result<()> {}||
|cmd/subscribe.rs|fn make_subscribe_frame(channel_name: String, num_subs: usize) -> Frame {}||
|cmd/subscribe.rs|fn make_unsubscribe_frame(channel_name: String, num_subs: usize) -> Frame {}||
|cmd/subscribe.rs|fn make_message_frame(channel_name: String, msg: Bytes) -> Frame {}||
|cmd/subscribe.rs|pub(crate) fn new(channels: &[String]) -> Unsubscribe {}||
|cmd/subscribe.rs|pub(crate) fn parse_frames(parse: &mut Parse) -> Result<Unsubscribe, ParseError> {}||
|cmd/subscribe.rs|pub(crate) fn into_frame(self) -> Frame {}||
|cmd/unknown.rs|pub(crate) fn new(key: impl ToString) -> Unknown {}||
|cmd/unknown.rs|pub(crate) fn get_name(&self) -> &str {}||
|cmd/unknown.rs|pub(crate) async fn apply(self, dst: &mut Connection) -> crate::Result<()> {}||
|cmd/get.rs|pub fn new(key: impl ToString) -> Get {}||
|cmd/get.rs|pub fn key(&self) -> &str {}||
|cmd/get.rs|pub(crate) fn parse_frames(parse: &mut Parse) -> crate::Result\<Get> {}||
|cmd/get.rs|pub(crate) async fn apply(self, db: &Db, dst: &mut Connection) -> crate::Result<()> {}||
|cmd/get.rs|pub(crate) fn into_frame(self) -> Frame {}||
|cmd/mod.rs|pub fn from_frame(frame: Frame) -> crate::Result\<Command> {}||
|cmd/mod.rs|pub(crate) async fn apply(self, db: &Db, dst: &mut Connection, shutdown: &mut Shutdown, ) -> crate::Result<()> {}||
|cmd/mod.rs|pub(crate) fn get_name(&self) -> &str {}||
|cmd/ping.rs|pub fn new(msg: Option\<Bytes>) -> Ping {}||
|cmd/ping.rs|pub(crate) fn parse_frames(parse: &mut Parse) -> crate::Result\<Ping> {}||
|cmd/ping.rs|pub(crate) async fn apply(self, dst: &mut Connection) -> crate::Result<()> {}||
|cmd/ping.rs|pub(crate) fn into_frame(self) -> Frame {}||
|cmd/publish.rs|pub(crate) fn new(channel: impl ToString, message: Bytes) -> Publish {}||
|cmd/publish.rs|pub(crate) fn parse_frames(parse: &mut Parse) -> crate::Result\<Publish> {}||
|cmd/publish.rs|pub(crate) async fn apply(self, db: &Db, dst: &mut Connection) -> crate::Result<()> {}||
|cmd/publish.rs|pub(crate) fn into_frame(self) -> Frame {}||
|cmd/set.rs|pub fn new(key: impl ToString, value: Bytes, expire: Option\<Duration>) -> Set {}||
|cmd/set.rs|pub fn key(&self) -> &str {}||
|cmd/set.rs|pub fn value(&self) -> &Bytes {}||
|cmd/set.rs|pub fn expire(&self) -> Option\<Duration> {}||
|cmd/set.rs|pub(crate) fn parse_frames(parse: &mut Parse) -> crate::Result\<Set> {}||
|cmd/set.rs|pub(crate) async fn apply(self, db: &Db, dst: &mut Connection) -> crate::Result<()> {}||
|cmd/set.rs|pub(crate) fn into_frame(self) -> Frame {}||
|bin/server.rs|pub async fn main() -> mini_redis::Result<()> {}||
|bin/server.rs|fn set_up_logging() -> mini_redis::Result<()> {}||
|bin/server.rs|fn set_up_logging() -> Result<(), TryInitError> {}||
|bin/cli.rs|async fn main() -> mini_redis::Result<()> {}||
|bin/cli.rs|fn duration_from_ms_str(src: &str) -> Result<Duration, ParseIntError> {}||
|bin/cli.rs|fn bytes_from_str(src: &str) -> Result<Bytes, Infallible> {}||
|server.rs|pub async fn run(listener: TcpListener, shutdown: impl Future) {}||
|server.rs|async fn run(&mut self) -> crate::Result<()> {}||
|server.rs|async fn accept(&mut self) -> crate::Result\<TcpStream> {}||
|server.rs|async fn run(&mut self) -> crate::Result<()> {}||
|db.rs|pub(crate) fn new() -> DbDropGuard {}||
|db.rs|pub(crate) fn db(&self) -> Db {}||
|db.rs|fn drop(&mut self) {}||
|db.rs|pub(crate) fn new() -> Db {}||
|db.rs|pub(crate) fn get(&self, key: &str) -> Option\<Bytes> {}||
|db.rs|pub(crate) fn set(&self, key: String, value: Bytes, expire: Option\<Duration>) {}||
|db.rs|pub(crate) fn subscribe(&self, key: String) -> broadcast::Receiver\<Bytes> {}||
|db.rs|pub(crate) fn publish(&self, key: &str, value: Bytes) -> usize {}||
|db.rs|fn shutdown_purge_task(&self) {}||
|db.rs|fn purge_expired_keys(&self) -> Option\<Instant> {}||
|db.rs|fn is_shutdown(&self) -> bool {}||
|db.rs|fn next_expiration(&self) -> Option\<Instant> {}||
|db.rs|async fn purge_expired_tasks(shared: Arc\<Shared>) {}||
|parse.rs|pub(crate) fn new(frame: Frame) -> Result<Parse, ParseError> {}||
|parse.rs|fn next(&mut self) -> Result<Frame, ParseError> {}||
|parse.rs|pub(crate) fn next_string(&mut self) -> Result<String, ParseError> {}||
|parse.rs|pub(crate) fn next_bytes(&mut self) -> Result<Bytes, ParseError> {}||
|parse.rs|pub(crate) fn next_int(&mut self) -> Result<u64, ParseError> {}||
|parse.rs|pub(crate) fn finish(&mut self) -> Result<(), ParseError> {}||
|parse.rs|fn from(src: String) -> ParseError {}||
|parse.rs|fn from(src: &str) -> ParseError {}||
|parse.rs|fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {}||
|frame.rs|pub(crate) fn array() -> Frame {}||
|frame.rs|pub(crate) fn push_bulk(&mut self, bytes: Bytes) {}||
|frame.rs|pub(crate) fn push_int(&mut self, value: u64) {}||
|frame.rs|pub fn check(src: &mut Cursor<&[u8]>) -> Result<(), Error> {}||
|frame.rs|pub fn parse(src: &mut Cursor<&[u8]>) -> Result<Frame, Error> {}||
|frame.rs|pub(crate) fn to_error(&self) -> crate::Error {}||
|frame.rs|fn eq(&self, other: &&str) -> bool {}||
|frame.rs|fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result {}||
|frame.rs|fn peek_u8(src: &mut Cursor<&[u8]>) -> Result<u8, Error> {}||
|frame.rs|fn get_u8(src: &mut Cursor<&[u8]>) -> Result<u8, Error> {}||
|frame.rs|fn skip(src: &mut Cursor<&[u8]>, n: usize) -> Result<(), Error> {}||
|frame.rs|fn get_decimal(src: &mut Cursor<&[u8]>) -> Result<u64, Error> {}||
|frame.rs|fn get_line<'a>(src: &mut Cursor<&'a [u8]>) -> Result<&'a [u8], Error> {}||
|frame.rs|fn from(src: String) -> Error {}||
|frame.rs|fn from(src: &str) -> Error {}||
|frame.rs|fn from(_src: FromUtf8Error) -> Error {}||
|frame.rs|fn from(_src: TryFromIntError) -> Error {}||
|frame.rs|fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result {}||
|connection.rs|pub fn new(socket: TcpStream) -> Connection {}||
|connection.rs|pub async fn read_frame(&mut self) -> crate::Result<Option\<Frame>> {}||
|connection.rs|fn parse_frame(&mut self) -> crate::Result<Option\<Frame>> {}||
|connection.rs|pub async fn write_frame(&mut self, frame: &Frame) -> io::Result<()> {}||
|connection.rs|async fn write_value(&mut self, frame: &Frame) -> io::Result<()> {}||
|connection.rs|async fn write_decimal(&mut self, val: u64) -> io::Result<()> {}||

## [RESP](https://redis.com.cn/topics/protocol.html)

RESP 协议在Redis1.2被引入，直到Redis2.0才成为和Redis服务器通信的标准。

RESP 是一个支持多种数据类型的序列化协议：简单字符串（Simple Strings）,错误（ Errors）,整型（ Integers）, 大容量字符串（Bulk Strings）和数组（Arrays）。

RESP在Redis中作为一个请求-响应协议以如下方式使用：

- 客户端以大容量字符串RESP数组的方式发送命令给服务器端。
- 服务器端根据命令的具体实现返回某一种RESP数据类型

在 RESP 中，数据的类型依赖于首字节：

- **单行字符串（Simple Strings）：** 响应的首字节是 "+"
- **错误（Errors）： 响应的首字节是** "-"
- **整型（Integers）： 响应的首字节是** ":"
- **多行字符串（Bulk Strings）： 响应的首字节是**"\$"
- **数组（Arrays）：** 响应的首字节是 "`*`"

RESP可以使用大容量字符串或者数组类型的特殊变量表示空值。RESP协议的不同部分总是以 "\r\n" (CRLF) 结束。
