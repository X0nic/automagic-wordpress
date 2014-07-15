#!/bin/bash

chef-solo -c $(pwd)/solo.rb -j nodes/dna.json
