# Distributed Cache

This project attempts to implement Redis like cache server from scratch using C/C++. This cache server runs on `6379`.

## How to run
1. Clone the repository and make sure you have `bin` and `obj` directories after cloning. If not, then create both of them.
2. Run `make compile`.
3. Open a terminal for the server and run `./bin/server`.
4. Open another terminal for the client and run `./bin/client [command in lowercase]`.

## Supported Commands:
1. SET: set a key-value pair. Ex. `set k v`
2. GET: get a value for key. Ex. `get k`
3. DEL: deletes a key-value pair. Ex. `del k`
4. KEYS: lists all the keys. Ex. `keys`

Note: Provide all the commands in lowercase.

## Following are the brief features of the cache server:

- Client/Server Communication:
  - Client-Server connection is made using TCP/IP sockets.
  
- Protocol Parsing:
  - The protocol or command is a simple list of strings, ex. `set key val`.

- Data Serialization:
  - This project implements serialization protocol of 5 data types: 
    - Null
    - String
    - Error code and message
    - Int
    - Array

- Event Loop:
  - To handle multiple clients in non-blocking IO mode, event loop is implemented using `poll()` syscall.

- Data Structure:
  - The server implements a chaining hashtable. A chaining hashtable is easy to code; it doesn’t require much choice-making.

- The sorted set and AVL tree:
  - To implement sorted set we need AVL tree. It offers the ability to sort your data in order, but also has the unique feature of querying ordered data by rank.
  - The real Redis project uses skiplist.

- TTL using Heap:
  - Heap is used to implement TTL to kick out idle TCP connections.

- Thread Pool and Asynchronous tasks
  - If the size of a sorted set is huge, it can take a long time to free its nodes while deleting the keys and the server is stalled during the destruction of the key. This can be easily fixed by using multi-threading to move the destructor away from the main thread.

## Future upgradation
- Using `epoll()` instead of `poll()` since, the argument for the poll can become too large as the number of fds increases.
- Implementation of RAFT consensus algorithm for leader election and log replication.