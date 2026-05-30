#!/bin/bash

sleep_time=$(( 60 * $2 ))

images=("$1"/*)

while true; do
	shuffled=($(shuf -e "${images[@]}"))
	for image in "${shuffled[@]}"; do
		awww img "$image"
		sleep "$sleep_time"
	done
done

