#!/usr/bin/python
from impacket import smb, smbconnection
from mysmb import MYSMB
from struct import pack, unpack, unpack_from
import sys
import socket
import time

target = '10.11.1.75'
USERNAME = ''
PASSWORD = ''
PIPEFILE = '/usr/share/wordlists/metasploit/named_pipes.txt'
SMBSHARE = 'IPC$'

#pipes = [ 'browser', 'spoolss', 'netlogon', 'lsarpc', 'samr' ]

with open(PIPEFILE) as f:
    pipes = f.read().splitlines()

conn = MYSMB(target)

# set NODELAY to make exploit much faster
conn.get_socket().setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)

info = {}

try:
    conn.login(USERNAME, PASSWORD, maxBufferSize=4356)
except:
    print "Cannot Connect"

try:
    tid = conn.tree_connect_andx('\\\\'+conn.get_remote_host()+'\\'+SMBSHARE)
except smb.SessionError as e:
    print e
    sys.exit()

found_pipe = None

for pipe in pipes:
    try:
        print "Trying pipe: " + pipe
        fid = conn.nt_create_andx(tid, pipe)
        conn.close(tid, fid)
        found_pipe = pipe
        break
    except smb.SessionError as e:
        print e
        pass

    conn.disconnect_tree(tid)

if found_pipe is None:
    print('Not found accessible named pipe')
else:
    print('Using named pipe: '+found_pipe)

