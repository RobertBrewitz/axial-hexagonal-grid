"use strict"

Grid = require "./../../lib/grid"

describe "getCenterXY", ->
  it "calculates pixel coordinates", ->
    grid = new Grid()

    grid.tileSpacing = 0
    grid.tileSize = 100
    grid.pointyTiles = false
    expect(grid.getCenterXY(1, 0).x).toEqual(150)

    grid.pointyTiles = true
    expect(grid.getCenterXY(0, -1).y).toEqual(150)

    grid.tileSpacing = 10

    grid.pointyTiles = false
    expect(grid.getCenterXY(1, 0).x).toEqual(165)

    grid.pointyTiles = true
    expect(grid.getCenterXY(0, -1).y).toEqual(165)

describe "hexagonCoordinates", ->
  beforeEach ->
    @grid = new Grid()

  it "returns grid coordinates for a hexagonal shape of radius 2", ->
    result = @grid.hexagonCoordinates(-1, -1, 2)

    expect(result).toContain({ q: -1, r: -1 })

    expect(result).toContain({ q:  0, r: -1 })
    expect(result).toContain({ q:  0, r: -2 })
    expect(result).toContain({ q: -1, r: -2 })
    expect(result).toContain({ q: -2, r: -1 })
    expect(result).toContain({ q: -2, r:  0 })
    expect(result).toContain({ q: -1, r:  0 })

    expect(result).toContain({ q:  1, r: -1 })
    expect(result).toContain({ q:  1, r: -2 })
    expect(result).toContain({ q:  1, r: -3 })
    expect(result).toContain({ q:  0, r: -3 })
    expect(result).toContain({ q: -1, r: -3 })
    expect(result).toContain({ q: -2, r: -2 })
    expect(result).toContain({ q: -3, r: -1 })
    expect(result).toContain({ q: -3, r:  0 })
    expect(result).toContain({ q: -3, r:  1 })
    expect(result).toContain({ q: -2, r:  1 })
    expect(result).toContain({ q: -1, r:  1 })
    expect(result).toContain({ q:  0, r:  0 })

    expect(result.length).toEqual(19)

describe "ringCoordinates", ->
  it "returns coordinates for drawing a ring", ->
    grid = new Grid()

    result = grid.ringCoordinates(-1, -1, 2)

    expect(result).toContain({ q:  1, r: -1 })
    expect(result).toContain({ q:  1, r: -2 })
    expect(result).toContain({ q:  1, r: -3 })
    expect(result).toContain({ q:  0, r: -3 })
    expect(result).toContain({ q: -1, r: -3 })
    expect(result).toContain({ q: -2, r: -2 })
    expect(result).toContain({ q: -3, r: -1 })
    expect(result).toContain({ q: -3, r:  0 })
    expect(result).toContain({ q: -3, r:  1 })
    expect(result).toContain({ q: -2, r:  1 })
    expect(result).toContain({ q: -1, r:  1 })

    expect(result.length).toEqual(12)

describe "axialDistance", ->
  beforeEach ->
    @grid = new Grid()

  it "distance from (0,0) to (0,0) is 0", ->
    result = @grid.axialDistance(0, 0, 0, 0)
    expect(result).toEqual(0)

  it "distance from (0,0) to (1,0) is 1", ->
    result = @grid.axialDistance(0, 0, 1, 0)
    expect(result).toEqual(1)

  it "distance from (5,-5) to (-5,5) is 10", ->
    result = @grid.axialDistance(5, -5, -5, 5)
    expect(result).toEqual(10)

describe "roundCube", ->
  beforeEach ->
    @grid = new Grid()

  it "calculates the cube coordinates based on the two lowest round() coordinate diffs to get the third and returns the whole set", ->
    result = @grid.roundCube({ x: 0.49, y: 1.95, z: 2.95 })
    expect(result).toEqual({ x: -5, y: 2, z: 3 })

describe "cubeToAxial", ->
  beforeEach ->
    @grid = new Grid()

  it "extracts (q,r) from (x,z) in (x,y,z)", ->
    result = @grid.cubeToAxial({ x: 3, y: -1, z: -2 })
    expect(result).toEqual({ q: 3, r: -1 })

describe "axialToCube", ->
  beforeEach ->
    @grid = new Grid()

  it "calculates (x,y,z) from (q,r)", ->
    result = @grid.axialToCube({ q: 3, r: -1 })
    expect(result).toEqual({ x: 3, y: -1, z: -2 })

describe "neighbors", ->
  beforeEach ->
    @grid = new Grid()

  it "returns neighbor coordinates", ->
    result = @grid.neighborCoordinates(0, 0)

    expect(result).toContain({ q:  1, r:  0 })
    expect(result).toContain({ q:  1, r: -1 })
    expect(result).toContain({ q:  0, r: -1 })
    expect(result).toContain({ q: -1, r:  0 })
    expect(result).toContain({ q: -1, r:  1 })
    expect(result).toContain({ q:  0, r:  1 })

    expect(result.length).toEqual(6)

describe "pixelToAxial", ->
  beforeEach ->
    @grid = new Grid()
    @grid.tileSize = 100
    @grid.tileSpacing = 0
    @grid.pointyTiles = false

  it "returns q and r from pixels coordinates and scale", ->
    expect(@grid.pixelToAxial(0, -150)).toEqual({ q: 0, r: 1 })
    expect(@grid.pixelToAxial(-150, 0)).toEqual({ q: -1, r: 1 })
    expect(@grid.pixelToAxial(0, 150)).toEqual({ q: 0, r: -1 })
    expect(@grid.pixelToAxial(150, 0)).toEqual({ q: 1, r: 0 })
