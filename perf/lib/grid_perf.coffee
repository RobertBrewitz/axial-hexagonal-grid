"use strict"

Grid = require "./../../lib/grid"
Canvas = require "canvas"
canvas = new Canvas 1, 1
context = canvas.getContext "2d"
grid = new Grid context

iterations = 1000000
console.time 'grid.hexagonCoordinates()'
grid.hexagonCoordinates(0,0,10) for i in [0..iterations]
console.timeEnd 'grid.hexagonCoordinates()'
