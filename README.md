# docker-kdb+
A minimal (Alpine Linux) docker container for running KDB+
## What is this?
Running KDB+ in Docker should be simple, and small. KDB+ is a tiny executable that is renowned for its ultra-efficient consumption of resources. Running it under 300MB of Linux feels like overkill, but many of the smaller linux distros have no simple way of including the 32-bit c libs required for KDB+, without complicated chroot / multi--arch setups. This little project deals with that, providing a small footprint Alpine Linux, with 32-bit lib support, and an environment configured to run KDB+.
## How to use it?
First, clone or downlowd this repo. When done, you'll need to download your free 32-bit KDB+ (I can't distribute here) for Linux. It's available here: https://kx.com/download/ When you've downloaded KDB+, zip up the q folder as q.zip, and copy into this folder, build, and run your docker image as described below.
### Build Docker image
Obvs, you need to have docker installed - get it from https://www.docker.com if you haven't already. Then open up a terminal, cd into this directory and type:
```docker build -t <your_username>/docker-kdb .```
### Run Docker image
Once you've built your image, you can run it. You can pass in a set of arguments with your run command, that the 'entrypoint' will pick up and execute. A simple run invocation to start q serving on port 5001 might resemble:
```docker run -it <your_username>/docker-kdb:latest q -p 5001``` 
## Can I extend it?
Yep. This implementation is deliberately super-simple, the entrypoint.sh is completely customisable, and you can hack it in any way you see fit to deliver what you need. Enjoy!
