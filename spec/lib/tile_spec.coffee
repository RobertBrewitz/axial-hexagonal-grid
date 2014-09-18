Tile = require "./../../lib/tile"
Grid = require "./../../lib/grid"
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

describe "drawTile", ->
  beforeEach ->
    this.addMatchers imagediff.jasmine
    @canvas = new Canvas(210,210)
    context = @canvas.getContext("2d")
    context.translate(105,105)
    grid = new Grid()
    @tile = new Tile(grid, context)

  it "expects tile options", ->
    expect(@tile.size).toBeDefined()
    expect(@tile.angle).toBeDefined()
    expect(@tile.lineColor).toBeDefined()
    expect(@tile.lineWidth).toBeDefined()
    expect(@tile.color).toBeDefined()
    expect(@tile.coordinates).toBeDefined()
    expect(@tile.coordinateColor).toBeDefined()
    expect(@tile.coordinateFont).toBeDefined()

  it "draws a flat hexagon tile", ->
    @tile.draw(0, 0)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/flat_hexagon.png"))

  it "draws a pointy hexagon tile", ->
    @tile.angle = 0.5
    @tile.draw(0, 0)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/pointy_hexagon.png"))

  it "draws a colored hexagon tile", ->
    @tile.color = "rgba(255,155,55,1)"
    @tile.lineColor = "rgba(255,155,55,1)"
    @tile.draw(0, 0)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/orange_hexagon.png"))

describe "hexagonal shape coordinates and drawing", ->
  beforeEach ->
    this.addMatchers imagediff.jasmine
    @canvas = new Canvas(600,600)
    @context = @canvas.getContext("2d")
    @context.translate(300,300)
    @grid = new Grid()
    @tile = new Tile(@grid, @context)

  it "draws a hexagonal grid of pointy tiles", ->
    @grid.tileSize    = 100
    @grid.tileSpacing = 0
    @grid.pointyTiles = true
    @grid.withOrigin  = true
    @tile.angle = 0.5
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/ring_grid_no_spacing_pointy_tiles.png"))

  it "draws a hexagonal grid of pointy tiles, with spacing and origin", ->
    @grid.tileSpacing = 5
    @grid.pointyTiles = true
    @grid.withOrigin = true
    @tile.angle = 0.5
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/ring_grid_spacing_pointy_tiles_with_origin.png"))

  it "draws a hexagonal grid of pointy tiles, with spacing and without origin", ->
    @grid.tileSpacing = 5
    @grid.pointyTiles = true
    @tile.angle = 0.5
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/ring_grid_spacing_pointy_tiles_without_origin.png"))

  it "draws a ring grid of flat tiles", ->
    @grid.withOrigin = true
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/ring_grid_no_spacing_flat_tiles.png"))

  it "draws a hexagonal grid of flat tiles, with spacing and origin", ->
    @grid.tileSpacing = 5
    @grid.withOrigin = true
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/ring_grid_spacing_flat_tiles_with_origin.png"))

  it "draws a hexagonal grid of flat tiles, with spacing and without origin", ->
    @grid.tileSpacing = 5
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/ring_grid_spacing_flat_tiles_without_origin.png"))

  it "coordinates for pointy tiles", ->
    @grid.pointyTiles = true
    @grid.withOrigin = true
    @tile.coordinates = true
    @tile.angle = 0.5
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/pointy_coordinates.png"))

  it "coordinates for flat tiles", ->
    @grid.withOrigin = true
    @tile.coordinates = true
    coordinates = @grid.hexagonCoordinates(0, 0, 1)
    for i in [0..coordinates.length-1]
      @tile.draw(coordinates[i].q, coordinates[i].r)
    expect(@canvas).toImageDiffEqual(loadExpectedImage("/../fixtures/flat_coordinates.png"))
