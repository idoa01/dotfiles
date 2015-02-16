#!/bin/bash
du -kd1 $@ | sort -n | awk '{
    if ($1>1048576) 
    {
        size=int($1/1048576)"G" 
    }
    else if ($1>1024) 
    {
        size=int($1/1024)"M" 
    }
    else 
    {
        size=$1"K"; 
    }
    $1 = size; 
    print; 
}'
