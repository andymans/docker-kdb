#!/bin/sh
# A simple entrypoint script - it:
# 1 - prints a welcome message
# 2 - prints the length of args
# 3 - executes the arguments passed in. 
# Naturally it can be customised...to perform checks, start various services, etc.,
# One good use case for the entrypoint would be to pass in a specific script and port to run. in this case a 'master' script like master.q could start on e.g. port 5000 and a set of worker scripts worker-1.q, worker-2.q etc., could run on 5001, 5002...
echo "Welcome to KDB+ on Docker"
echo $#
exec "$@"
