# Travis Smith
# ITMS 543 Vulnerability Analysis and Control
# Fall 2020
# Concurrent TCP port scanner

from socket import *
from queue import Queue
import threading
import time

# global/shared variables
openPorts = []
q = Queue()
ip = input("Enter in an IP address to port scan: ")

def main():

    print("Starting scan of target: ", ip)

    # start 100 threads that are ready to scan ports
    # more threads tends to make the scans faster
    # risk running out of resources on system with to many
    for _ in range(100):
        thread = threading.Thread(target=threadManager)
        thread.daemon = True
        thread.start()

    start = time.time()

    # put all ports into a queue, the when a thread is ready, it will grab a new port from the queue and perform the scan
    for port in range(1, 1024):
        q.put(port)

    # block/wait until all threads are done
    q.join()
       
    # end timer and print results
    end = time.time() - start
    print("The scan took: ", end, "seconds")
    print("The target's following ports are open")

    for port in openPorts:
        print("Port open: ", port)


def threadManager():
    # check for new workers to handle a new port to scan
    # signal that scan is done
    while True:
        port= q.get()
        scan(port)
        q.task_done()


def scan(port):
    
    try:
        # create socket object and attempt TCP connection (SOCK_STREAM)
        s = socket(AF_INET, SOCK_STREAM)
        s.settimeout(0.5)
        result = s.connect_ex((ip, port))

        # result of zero means that the port was open
        # append port to result
        if (result == 0):
            openPorts.append(port) # append only writes to the list, so it is "thread" safe thanks to GIL
        
        # close the socket connection 
        s.close()
    
    except:
        print("error scanning port:", port)


if __name__ == "__main__":
    main()