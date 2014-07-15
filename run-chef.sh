#!/bin/bash

chef-solo -c $(pwd)/solo.rb -j dna.json
