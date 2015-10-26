"use strict"

beforeEach ->
  @grid = gridConstructor()

describe "ring", ->
  it "returns coordinates for a ring two (2) tiles from center", ->
    result = @grid.ring(-1, -1, 2)
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

describe "hexagon", ->
  it "returns coordinates for a solid hexagonal shape stretching two (2) tiles from center", ->
    result = @grid.hexagon(-1, -1, 2, true)
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

  it "returns coordinates for a hexagonal shape stretching two (2) tiles from center without the center coordinate", ->
    result = @grid.hexagon(-1, -1, 2)
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
    expect(result.length).toEqual(18)

describe "getCenterXY", ->
  it "calculates pixel coordinates based on hexagon settings", ->
    @grid.setTileSpacing(0)
    @grid.setTileSize(100)
    @grid.setTilePointy(false)
    expect(@grid.getCenterXY(1, 0).x).toEqual(150)

    @grid.setTilePointy true
    expect(@grid.getCenterXY(0, -1).y).toEqual(150)

    @grid.setTileSpacing 10
    @grid.setTilePointy false
    expect(@grid.getCenterXY(1, 0).x).toEqual(165)

    @grid.setTilePointy true
    expect(@grid.getCenterXY(0, -1).y).toEqual(165)

describe "axialDistance", ->
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
  it "calculates the cube coordinates based on the two lowest round() coordinate diffs to get the third and returns the whole set", ->
    result = @grid.roundCube({ x: 0.49, y: 1.95, z: 2.95 })
    expect(result).toEqual({ x: -5, y: 2, z: 3 })

describe "cubeToAxial", ->
  it "extracts (q,r) from (x,z) in (x,y,z)", ->
    result = @grid.cubeToAxial({ x: 3, y: -1, z: -2 })
    expect(result).toEqual({ q: 3, r: -1 })

describe "axialToCube", ->
  it "calculates (x,y,z) from (q,r)", ->
    result = @grid.axialToCube({ q: 3, r: -1 })
    expect(result).toEqual({ x: 3, y: -1, z: -2 })

describe "neighbors", ->
  it "returns neighbor coordinates", ->
    result = @grid.neighbors(0, 0)
    expect(result).toContain({ q:  1, r:  0 })
    expect(result).toContain({ q:  1, r: -1 })
    expect(result).toContain({ q:  0, r: -1 })
    expect(result).toContain({ q: -1, r:  0 })
    expect(result).toContain({ q: -1, r:  1 })
    expect(result).toContain({ q:  0, r:  1 })
    expect(result.length).toEqual(6)

describe "pixelToAxial", ->
  it "returns q and r from pixels coordinates and scale", ->
    expect(@grid.pixelToAxial(0, -150)).toEqual({ q: 0, r: 1 })
    expect(@grid.pixelToAxial(-150, 0)).toEqual({ q: -1, r: 1 })
    expect(@grid.pixelToAxial(0, 150)).toEqual({ q: 0, r: -1 })
    expect(@grid.pixelToAxial(150, 0)).toEqual({ q: 1, r: -0 }) # Weird -0

