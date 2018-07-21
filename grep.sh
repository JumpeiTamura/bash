#!/bin/bash

if grep -q $1 $2; then
	echo found
else
	echo not found
fi
