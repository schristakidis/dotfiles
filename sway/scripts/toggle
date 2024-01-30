#!/bin/bash

w_id=$(swaymsg -t get_tree | jq -r ".. | select(.focused? == true).id")
focused=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true).name' | tr -d '"')
focused=$(printf "%s$" "$focused")

swaymsg "[workspace="$focused"] move workspace "reorder"; [workspace="reorder"] move workspace current"
swaymsg "layout toggle tabbed split"
swaymsg "[con_id=$w_id] focus"
