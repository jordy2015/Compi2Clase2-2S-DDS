#!bash
flex --prefix="jj" --header-file=scanner.h -o scanner.cpp scanner.l
bison --name-prefix="jj" -o parser.cpp --defines=parser.h parser.y
g++ -g main.cpp scanner.cpp parser.cpp -o a.out
./a.out
