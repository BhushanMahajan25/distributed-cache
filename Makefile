CC = g++

CFLAGS = -c --std=c++20
HEADERFLAGS += -I./common.h

OBJDIR = obj
BINDIR = bin

compile : $(BINDIR)/server $(BINDIR)/client

$(BINDIR)/server : $(OBJDIR)/server.o $(OBJDIR)/hashtable.o $(OBJDIR)/zset.o $(OBJDIR)/heap.o $(OBJDIR)/thread_pool.o $(OBJDIR)/avl.o
	$(CC) $(OBJDIR)/server.o $(OBJDIR)/hashtable.o $(OBJDIR)/zset.o $(OBJDIR)/heap.o $(OBJDIR)/thread_pool.o $(OBJDIR)/avl.o -o $(BINDIR)/server

$(BINDIR)/client : $(OBJDIR)/client.o
	$(CC) $(OBJDIR)/client.o -o $(BINDIR)/client

$(OBJDIR)/thread_pool.o : thread_pool.cpp
	$(CC) $(CFLAGS) thread_pool.cpp -o $(OBJDIR)/thread_pool.o

$(OBJDIR)/heap.o : heap.cpp
	$(CC) $(CFLAGS) heap.cpp -o $(OBJDIR)/heap.o

$(OBJDIR)/hashtable.o : hashtable.cpp
	$(CC) $(CFLAGS) hashtable.cpp -o $(OBJDIR)/hashtable.o

$(OBJDIR)/avl.o : avl.cpp
	$(CC) $(CFLAGS) avl.cpp -o $(OBJDIR)/avl.o

$(OBJDIR)/zset.o : zset.cpp $(OBJDIR)/hashtable.o $(OBJDIR)/avl.o
	$(CC) $(CFLAGS) $(HEADERFLAGS) zset.cpp -o $(OBJDIR)/zset.o

$(OBJDIR)/server.o : server.cpp
	$(CC) $(CFLAGS) $(HEADERFLAGS) server.cpp -o $(OBJDIR)/server.o

$(OBJDIR)/client.o : client.cpp
	$(CC) $(CFLAGS) client.cpp -o $(OBJDIR)/client.o


clean : 
	rm $(OBJDIR)/* $(BINDIR)/*