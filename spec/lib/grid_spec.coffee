"use strict"

Grid = require "./../../lib/grid"

describe "getCenterXY", ->
  it "expects tile options", ->
    grid = new Grid()
    expect(grid.tileSpacing).toBeDefined()
    expect(grid.tileSize).toBeDefined()
    expect(grid.pointyTiles).toBeDefined()

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

  it "expects grid options", ->
    expect(@grid.withOrigin).toBeDefined()

  it "returns grid coordinates for a hexagonal shape of radius 2", ->
    result = @grid.hexagonCoordinates(-1, -1, 2)

    # 1st ring
    expect(result).toContain({ q:  0, r: -1 })
    expect(result).toContain({ q:  0, r: -2 })
    expect(result).toContain({ q: -1, r: -2 })
    expect(result).toContain({ q: -2, r: -1 })
    expect(result).toContain({ q: -2, r:  0 })
    expect(result).toContain({ q: -1, r:  0 })

    # 2nd ring
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

describe "axialDistance", ->
  it "distance from (0,0) to (0,0) is 0", ->
    result = Grid.axialDistance({ q: 0, r: 0 }, { q: 0, r: 0 })
    expect(result).toEqual(0)

  it "distance from (0,0) to (1,0) is 1", ->
    result = Grid.axialDistance({ q: 0, r: 0 }, { q: 1, r: 0 })
    expect(result).toEqual(1)

  it "distance from (5,-5) to (-5,5) is 10", ->
    result = Grid.axialDistance({ q: 5, r: -5 }, { q: -5, r: 5 })
    expect(result).toEqual(10)

describe "roundCube", ->
  it "calculates the cube coordinates based on the two lowest round() coordinate diffs to get the third and returns the whole set", ->
    result = Grid.roundCube({ x: 0.49, y: 1.95, z: 2.95 })
    expect(result).toEqual({ x: -5, y: 2, z: 3 })

describe "cubeToAxial", ->
  it "extracts (q,r) from (x,z) in (x,y,z)", ->
    result = Grid.cubeToAxial({ x: 3, y: -2, z: -1 })
    expect(result).toEqual({ q: 3, r: -1 })

describe "axialToCube", ->
  it "calculates (x,y,z) from (q,r)", ->
    result = Grid.axialToCube({ q: 3, r: -1 })
    expect(result).toEqual({ x: 3, y: -2, z: -1 })
