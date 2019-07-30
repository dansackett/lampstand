#!/bin/bash
#
# for MySQL 5.7
#
# Order of commands
#
# 1. Setup VALIDATE PASSWORD PLUGIN?
# 2. Password level (ignore if no for first) [0, 1, 2]
# 3. Root password
# 4. Root password again
# 5. Accept password strength?
# 6. Remove anonymous users?
# 7. Disallow root login remotely?
# 8. Remove test database?
# 9. Reload privilege table?

sudo mysql_secure_installation <<EOF
y
0
root_password
root_password
y
y
y
y
y
EOF
