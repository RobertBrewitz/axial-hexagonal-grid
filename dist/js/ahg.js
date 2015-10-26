"use strict";
var gridConstructor;

gridConstructor = function(arg) {
  var axialDistance, axialToCube, cubeToAxial, getCenterXY, getTilePointy, getTileSize, getTileSpacing, hexagon, neighbors, pixelToAxial, pixelToDecimalQR, ref, ring, roundCube, setTilePointy, setTileSize, setTileSpacing, tilePointy, tileSize, tileSpacing;
  ref = arg != null ? arg : {
    tileSize: 100,
    tileSpacing: 0,
    tilePointy: false
  }, tileSize = ref.tileSize, tileSpacing = ref.tileSpacing, tilePointy = ref.tilePointy;
  ring = function(q, r, radius) {
    var i, j, len, moveDirection, moveDirectionIndex, moveDirections, ref1, result;
    result = [];
    moveDirections = [[1, 0], [0, -1], [-1, 0], [-1, 1], [0, 1], [1, 0], [1, -1]];
    for (moveDirectionIndex = i = 0, len = moveDirections.length; i < len; moveDirectionIndex = ++i) {
      moveDirection = moveDirections[moveDirectionIndex];
      for (j = 0, ref1 = radius - 1; 0 <= ref1 ? j <= ref1 : j >= ref1; 0 <= ref1 ? j++ : j--) {
        q += moveDirection[0];
        r += moveDirection[1];
        if (moveDirectionIndex !== 0) {
          result.push({
            q: q,
            r: r
          });
        }
      }
    }
    return result;
  };
  hexagon = function(q, r, radius, solid) {
    var currentRing, i, ref1, result;
    result = [];
    if (solid) {
      result.push({
        q: q,
        r: r
      });
    }
    for (currentRing = i = 1, ref1 = radius; 1 <= ref1 ? i <= ref1 : i >= ref1; currentRing = 1 <= ref1 ? ++i : --i) {
      result = result.concat(ring(q, r, currentRing));
    }
    return result;
  };
  neighbors = function(q, r) {
    var i, len, neighbor, result;
    result = [];
    neighbors = [[1, 0], [1, -1], [0, -1], [-1, 0], [-1, 1], [0, 1]];
    for (i = 0, len = neighbors.length; i < len; i++) {
      neighbor = neighbors[i];
      result.push({
        q: q + neighbor[0],
        r: neighbor[1]
      });
    }
    return result;
  };
  getCenterXY = function(q, r) {
    var x, y;
    if (tilePointy) {
      x = (tileSize + tileSpacing) * Math.sqrt(3) * (q + r / 2);
      y = -((tileSize + tileSpacing) * 3 / 2 * r);
    } else {
      x = (tileSize + tileSpacing) * 3 / 2 * q;
      y = -((tileSize + tileSpacing) * Math.sqrt(3) * (r + q / 2));
    }
    return {
      x: x,
      y: y
    };
  };
  axialDistance = function(q1, r1, q2, r2) {
    return (Math.abs(q1 - q2) + Math.abs(r1 - r2) + Math.abs(q1 + r1 - q2 - r2)) / 2;
  };
  pixelToAxial = function(x, y) {
    var cube, decimalQR, roundedCube;
    decimalQR = pixelToDecimalQR(x, y);
    cube = axialToCube(decimalQR);
    roundedCube = roundCube(cube);
    return cubeToAxial(roundedCube);
  };
  pixelToDecimalQR = function(x, y, scale) {
    var q, r;
    if (typeof scale !== "number") {
      scale = 1;
    }
    if (tilePointy) {
      q = (1 / 3 * Math.sqrt(3) * x - 1 / 3 * -y) / (tileSize + tileSpacing);
      r = 2 / 3 * -y / (tileSize + tileSpacing);
    } else {
      q = 2 / 3 * x / (tileSize + tileSpacing);
      r = (1 / 3 * Math.sqrt(3) * -y - 1 / 3 * x) / (tileSize + tileSpacing);
    }
    q /= scale;
    r /= scale;
    return {
      q: q,
      r: r
    };
  };
  roundCube = function(coordinates) {
    var dx, dy, dz, rx, ry, rz;
    rx = Math.round(coordinates.x);
    ry = Math.round(coordinates.y);
    rz = Math.round(coordinates.z);
    dx = Math.abs(rx - coordinates.x);
    dy = Math.abs(ry - coordinates.y);
    dz = Math.abs(rz - coordinates.z);
    if (dx > dy && dx > dz) {
      rx = -ry - rz;
    } else if (dy > dz) {
      ry = -rx - rz;
    } else {
      rz = -rx - ry;
    }
    return {
      x: rx,
      y: ry,
      z: rz
    };
  };
  cubeToAxial = function(cube) {
    return {
      q: cube.x,
      r: cube.y
    };
  };
  axialToCube = function(axial) {
    return {
      x: axial.q,
      y: axial.r,
      z: -axial.q - axial.r
    };
  };
  setTileSize = function(num) {
    tileSize = num;
  };
  getTileSize = function() {
    return tileSize;
  };
  setTileSpacing = function(num) {
    tileSpacing = num;
  };
  getTileSpacing = function() {
    return tileSpacing;
  };
  setTilePointy = function(bool) {
    tilePointy = bool;
  };
  getTilePointy = function() {
    return tilePointy;
  };
  return Object.freeze({
    ring: ring,
    hexagon: hexagon,
    neighbors: neighbors,
    getCenterXY: getCenterXY,
    axialDistance: axialDistance,
    pixelToAxial: pixelToAxial,
    pixelToDecimalQR: pixelToDecimalQR,
    roundCube: roundCube,
    cubeToAxial: cubeToAxial,
    axialToCube: axialToCube,
    setTileSize: setTileSize,
    getTileSize: getTileSize,
    setTileSpacing: setTileSpacing,
    getTileSpacing: getTileSpacing,
    setTilePointy: setTilePointy,
    getTilePointy: getTilePointy
  });
};
