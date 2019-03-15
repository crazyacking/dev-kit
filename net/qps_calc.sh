#!/usr/bin/env bash

a=0
b=0

while true ; do {
  sleep 1

  a=`sed -n '$=' health.log`
  ((gap=a-b))
  b=${a}

  echo "${gap} op/s"
}
done
