#!/bin/bash

# Start node.js application via forever
/usr/local/bin/forever -m 25 -w --watchDirectory /var/www/ start /var/www/app.js