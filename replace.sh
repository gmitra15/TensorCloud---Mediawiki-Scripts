#!/bin/bash

while getopts ":p:k:" opt; do
  case $opt in
    p)
      echo "Piwik URL: $OPTARG" >&2
      ;;
    k)
      echo "Piwik ID Number: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option : -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done