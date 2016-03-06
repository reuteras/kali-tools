#!/bin/bash

cd /root/src/iSniff-GPS && . .env/bin/activate && \
    ./manage.py runserver 127.0.0.1:8000 && \
    iceweasel http://127.0.0.1:8000

