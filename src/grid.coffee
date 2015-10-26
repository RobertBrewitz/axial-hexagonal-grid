"use strict"

gridConstructor = ({ tileSize, tileSpacing, tilePointy } = { tileSize: 100, tileSpacing: 0, tilePointy: false }) ->
  ring = (q, r, radius) ->
    result = []
    moveDirections = [[1,0], [0,-1], [-1,0], [-1,1], [0,1], [1,0], [1,-1]]
    for moveDirection, moveDirectionIndex in moveDirections
      for [0..radius-1]
        q += moveDirection[0]
        r += moveDirection[1]
        if moveDirectionIndex != 0
          result.push { q: q, r: r }
    result

  hexagon = (q, r, radius, solid) ->
    result = []
    if solid
      result.push { q: q, r: r }
    for currentRing in [1..radius]
      result = result.concat ring(q, r, currentRing)
    result

  neighbors = (q, r) ->
    result = []
    neighbors = [[1,0],[1,-1],[0,-1],[-1,0],[-1,1],[0,1]]
    for neighbor in neighbors
      result.push { q: q+neighbor[0], r: neighbor[1] }
    result

  getCenterXY = (q, r) ->
    if tilePointy
      x = (tileSize + tileSpacing) * Math.sqrt(3) * (q + r / 2)
      y = -((tileSize + tileSpacing) * 3/2 * r)
    else
      x = (tileSize + tileSpacing) * 3/2 * q
      y = -((tileSize + tileSpacing) * Math.sqrt(3) * (r + q / 2))

    { x: x, y: y }

  axialDistance = (q1, r1, q2, r2) ->
    (Math.abs(q1-q2) + Math.abs(r1-r2) + Math.abs(q1+r1-q2-r2)) / 2

  pixelToAxial = (x, y) ->
    decimalQR = pixelToDecimalQR(x, y)
    cube = axialToCube(decimalQR)
    roundedCube = roundCube(cube)
    cubeToAxial(roundedCube)

  pixelToDecimalQR = (x, y, scale) ->
    if typeof scale != "number"
      scale = 1

    if tilePointy
      q = (1/3 * Math.sqrt(3) * x - 1/3 * -y) / (tileSize + tileSpacing)
      r = 2/3 * -y / (tileSize + tileSpacing)
    else
      q = 2/3 * x / (tileSize + tileSpacing)
      r = (1/3 * Math.sqrt(3) * -y - 1/3 * x) / (tileSize + tileSpacing)

    q /= scale
    r /= scale

    { q: q, r: r }

  roundCube = (coordinates) ->
    rx = Math.round coordinates.x
    ry = Math.round coordinates.y
    rz = Math.round coordinates.z

    dx = Math.abs rx - coordinates.x
    dy = Math.abs ry - coordinates.y
    dz = Math.abs rz - coordinates.z

    if dx > dy && dx > dz
      rx = -ry-rz
    else if dy > dz
      ry = -rx-rz
    else
      rz = -rx-ry

    { x: rx, y: ry, z: rz }

  cubeToAxial = (cube) ->
    { q: cube.x, r: cube.y }

  axialToCube = (axial) ->
    { x: axial.q, y: axial.r, z: -axial.q-axial.r }

  setTileSize = (num) ->
    tileSize = num
    return

  getTileSize = ->
    tileSize

  setTileSpacing = (num) ->
    tileSpacing = num
    return

  getTileSpacing = ->
    tileSpacing

  setTilePointy = (bool) ->
    tilePointy = bool
    return

  getTilePointy = ->
    tilePointy

  Object.freeze({
    ring,
    hexagon,
    neighbors,
    getCenterXY,
    axialDistance
    pixelToAxial,
    pixelToDecimalQR,
    roundCube,
    cubeToAxial,
    axialToCube,
    setTileSize,
    getTileSize,
    setTileSpacing,
    getTileSpacing,
    setTilePointy,
    getTilePointy
  })

