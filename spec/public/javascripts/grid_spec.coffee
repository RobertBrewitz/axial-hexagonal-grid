"use strict"

Grid = require "./../../../public/javascripts/grid"
Canvas = require "canvas"
Image = Canvas.Image
fs = require "fs"
imagediff = require "imagediff"

loadExpectedImage = (path) ->
  expectedImage = new Image()
  expectedImage.src = fs.readFileSync(__dirname + path)

  expectedCanvas = new Canvas(expectedImage.width, expectedImage.height)
  expectedContext = expectedCanvas.getContext("2d")
  expectedContext.drawImage(expectedImage, 0, 0, expectedImage.width, expectedImage.height)

  expectedCanvas

describe "instance of self", ->
  it "has origin coordinates to begin drawing from", ->
    grid = new Grid()
    expect(grid.origin.q).toBeDefined()
    expect(grid.origin.r).toBeDefined()

  it "origin coordinates can be overridden", ->
    grid = new Grid()
    grid.origin.q = 1
    grid.origin.r = 2

    expect(grid.origin).toEqual({ q: 1, r: 2 })

describe "drawTile", ->
  it "expects tile options", ->
    grid = new Grid()
    expect(grid.tileSize).toBeDefined()
    expect(grid.tileSpacing).toBeDefined()
    expect(grid.tilePointy).toBeDefined()
    expect(grid.tileLineColor).toBeDefined()
    expect(grid.tileLineWidth).toBeDefined()
    expect(grid.tileColor).toBeDefined()

  it "draws a pointy hexagon tile", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(210,210)
    context = canvas.getContext("2d")
    context.translate(105,105)

    grid = new Grid(context)
    grid.drawTile(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/pointy_hexagon.png"))

  it "draws a flat hexagon tile", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(210,210)
    context = canvas.getContext("2d")
    context.translate(105,105)

    grid = new Grid(context)
    grid.tilePointy = false
    grid.drawTile(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/flat_hexagon.png"))

  it "draws a colored hexagon tile", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(210,210)
    context = canvas.getContext("2d")
    context.translate(105,105)

    grid = new Grid(context)
    grid.tilePointy = false
    grid.tileColor = "rgba(255,155,55,1)"
    grid.tileLineColor = "rgba(255,155,55,1)"
    grid.drawTile(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/orange_hexagon.png"))

describe "drawRingGrid", ->
  it "expects grid options", ->
    grid = new Grid()
    expect(grid.gridRings).toBeDefined()
    expect(grid.gridDrawOrigin).toBeDefined()

  it "draws a ring grid of pointy tiles", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(600,600)
    context = canvas.getContext("2d")
    context.translate(300,300)

    grid = new Grid(context)
    grid.drawRingGrid(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/ring_grid_no_spacing_pointy_tiles.png"))

  it "draws a ring grid of pointy tiles and spacing with origin included", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(600,600)
    context = canvas.getContext("2d")
    context.translate(300,300)

    grid = new Grid(context)
    grid.tileSpacing = 5
    grid.drawRingGrid(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/ring_grid_spacing_pointy_tiles_with_origin.png"))

  it "draws a ring grid of pointy tiles and spacing with origin excluded", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(600,600)
    context = canvas.getContext("2d")
    context.translate(300,300)

    grid = new Grid(context)
    grid.tileSpacing = 5
    grid.gridDrawOrigin = false
    grid.drawRingGrid(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/ring_grid_spacing_pointy_tiles_without_origin.png"))

  it "draws a ring grid of flat tiles", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(600,600)
    context = canvas.getContext("2d")
    context.translate(300,300)

    grid = new Grid(context)
    grid.tilePointy = false
    grid.drawRingGrid(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/ring_grid_no_spacing_flat_tiles.png"))

  it "draws a ring grid of flat tiles and spacing with origin included", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(600,600)
    context = canvas.getContext("2d")
    context.translate(300,300)

    grid = new Grid(context)
    grid.tilePointy = false
    grid.tileSpacing = 5
    grid.drawRingGrid(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/ring_grid_spacing_flat_tiles_with_origin.png"))

  it "draws a ring grid of flat tiles and spacing with origin excluded", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(600,600)
    context = canvas.getContext("2d")
    context.translate(300,300)

    grid = new Grid(context)
    grid.tilePointy = false
    grid.tileSpacing = 5
    grid.gridDrawOrigin = false
    grid.drawRingGrid(0, 0)

    expect(canvas).toImageDiffEqual(loadExpectedImage("/../../fixtures/ring_grid_spacing_flat_tiles_without_origin.png"))

describe "getCenterXY", ->
  it "expects tile options", ->
    grid = new Grid()
    expect(grid.tileSpacing).toBeDefined()

  it "calculates pixel coordinates for canvas based on tile and grid options", ->
    canvas = new Canvas(1,1)
    context = canvas.getContext("2d")
    grid = new Grid(context)
    grid.tileSpacing = 0
    grid.tileSize = 100

    expect(grid.getCenterXY(0, -1).y).toEqual(150)

    grid.tilePointy = false
    expect(grid.getCenterXY(1, 0).x).toEqual(150)

    grid.tileSpacing = 10
    expect(grid.getCenterXY(1, 0).x).toEqual(165)

    grid.tilePointy = true
    expect(grid.getCenterXY(0, -1).y).toEqual(165)
