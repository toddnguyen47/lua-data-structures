# Generate random string file in Linux

Run this command:

```
(tr -dc "0-5" < /dev/urandom) | head -c 10000000 > samplestring.txt
```

# Compile and Run CPP Time Test

Run this command:

```
g++ timetest.cpp -o timetest
./timetest <numberOfTimes>
```

# Run busted test

Run this command:

```
busted SplitString_spec.lua
```
