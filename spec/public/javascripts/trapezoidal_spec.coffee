"use strict"

# Kudos to Red Blob Games for the great write-up on hexagons and 
# hexa-grids over at http://www.redblobgames.com/grids/hexagons/

Trapezoidal = require "./../../../public/javascripts/trapezoidal"

describe "cubeToAxial", ->
  it "extracts (q,r) from (x,z) in (x,y,z)", ->
    result = Trapezoidal.cubeToAxial({ x: 3, y: -2, z: -1 })
    expect(result).toEqual({ q: 3, r: -1 })

describe "axialToCube", ->
  it "calculates (x,y,z) from (q,r)", ->
    result = Trapezoidal.axialToCube({ q: 2, r: -1 })
    expect(result).toEqual({ x: 2, y: -1, z: -1 })

describe "axialDistance", ->
  it "distance from (0,0) to (0,0) is 0", ->
    result = Trapezoidal.axialDistance({ q: 0, r: 0 }, { q: 0, r: 0 })
    expect(result).toEqual(0)

  it "distance from (0,0) to (1,0) is 1", ->
    result = Trapezoidal.axialDistance({ q: 0, r: 0 }, { q: 1, r: 0 })
    expect(result).toEqual(1)

  it "distance from (5,-5) to (-5,5) is 10", ->
    result = Trapezoidal.axialDistance({ q: 5, r: -5 }, { q: -5, r: 5 })
    expect(result).toEqual(10)

describe "roundCube", ->
  it "calculates the cube coordinates based on the two lowest round() coordinate diffs to get the third and returns the whole set", ->
    result = Trapezoidal.roundCube({ x: 0.49, y: 1.95, z: 2.95 })
    expect(result).toEqual({ x: -5, y: 2, z: 3 })
