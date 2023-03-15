# Extending the Mini Lib C to handle the signals
This project is to extend the mini C library to support signal relevant system calls.
I implement the following C library functions in assembly and C using the syntax supported by yasm x86_64 assembler

1. **setjump**: prepare for long jump by saving the current CPU state. In addition, preserve the signal mask of the current process
2. **longjump**: persorm the long jump by restoring a sved CPU state. In addition, restore the preserved signal mask.
3. **signal and sigaction**: setup the handler of a signal
4. **sigprocmask**: can be used to block/unblock signals, and get/set the current signal mask
5. **sigpending**: check if there is any pending signal
6. **alarm**: set a timer for the current process
7. **write**: write to a file descriptor
8. **strlen**: calculate the length pf the string, excluding the terminating null byte("\0")
9. functions to handle sigset_t data type: **sigemptyset, sigfillset, sigaddset, sigdelset, and sigismember**

The API interface is the same to what we have in the standard C library. However, because the project is attempting to replace the standard C library, the test codes will only be linked against the library I implemented.

To run the code, you simply need to do `make`
e.g.
- `make libmini64.a`
- `make libmini.so`
- `make start.o` (once you `make` start.o, you don't need to make it for the next test case)
- `make alarm3`*(the test case)*
