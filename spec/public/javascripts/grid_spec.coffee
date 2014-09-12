"use strict"

Grid = require "./../../../public/javascripts/grid"
Canvas = require "canvas"
Image = Canvas.Image
fs = require "fs"
imagediff = require "imagediff"

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
  it "has tile options", ->
    grid = new Grid()
    expect(grid.tileSize).toBeDefined()
    expect(grid.tileSpacing).toBeDefined()
    expect(grid.tilePointy).toBeDefined()
    expect(grid.tileLineColor).toBeDefined()
    expect(grid.tileLineWidth).toBeDefined()

  it "draws a pointy hexagon tile", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(210,210)
    context = canvas.getContext("2d")
    context.translate(105,105)

    grid = new Grid(context)
    grid.drawTile(0, 0)

    expectedImage = new Image()
    expectedImage.src = fs.readFileSync(__dirname + "/../../fixtures/pointy_hexagon.png")

    expectedCanvas = new Canvas(expectedImage.width, expectedImage.height)
    expectedContext = expectedCanvas.getContext("2d")
    expectedContext.drawImage(expectedImage, 0, 0, expectedImage.width, expectedImage.height)

    expect(canvas).toImageDiffEqual(expectedCanvas)

  it "draws a flat hexagon tile", ->
    this.addMatchers imagediff.jasmine

    canvas = new Canvas(210,210)
    context = canvas.getContext("2d")
    context.translate(105,105)

    grid = new Grid(context)
    grid.tilePointy = false
    grid.drawTile(0, 0)

    expectedImage = new Image()
    expectedImage.src = fs.readFileSync(__dirname + "/../../fixtures/flat_hexagon.png")

    expectedCanvas = new Canvas(expectedImage.width, expectedImage.height)
    expectedContext = expectedCanvas.getContext("2d")
    expectedContext.drawImage(expectedImage, 0, 0, expectedImage.width, expectedImage.height)

    expect(canvas).toImageDiffEqual(expectedCanvas)
