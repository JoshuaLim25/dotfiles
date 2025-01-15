#!/usr/bin/env bash

reference_dir="/home/josh/spaghetti/langs/rust/reference-code"

if [ "$PWD" != "$reference_dir" ]; then
    cd "$reference_dir" || exit
fi

ls

echo "Enter filename: "
read -r filename

if [ ! -f "$filename" ]; then
    echo "Error reading file, try again." && exit
fi

mv playground/src/*.rs ./playgroundfile.rs.bak
mv "$filename" playground/src/main.rs
cd playground/ && nvim src/"${filename}"
