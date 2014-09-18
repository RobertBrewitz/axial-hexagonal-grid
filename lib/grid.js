"use strict"

var module = module || {};

function Grid () {
  this.tileSize    = 100;
  this.tileSpacing = 0;
  this.pointyTiles = false;
  this.withOrigin  = false;
}

Grid.prototype.hexagonCoordinates = function (q, r, radius) {
  var result = [];
  var moveDirections = [
    [ 1,  0],
    [ 0, -1],
    [-1,  0],
    [-1,  1],
    [ 0,  1],
    [ 1,  0],
    [ 1, -1]
  ];

  if (this.withOrigin) {
    result.push({ q: q, r: r });
  }

  var currentQ, currentR, moveCounter, moveDirection;

  for (var currentRing = 1; currentRing <= radius; currentRing++) {
    currentQ = q;
    currentR = r;

    for(moveDirection = 0; moveDirection < moveDirections.length; moveDirection++) {
      for(moveCounter = 0; moveCounter < currentRing; moveCounter++) {
        currentQ += moveDirections[moveDirection][0];
        currentR += moveDirections[moveDirection][1];

        if (moveDirection != 0) {
          result.push({ q: currentQ, r: currentR });
        }
      }
    }
  }

  return result;
};

Grid.prototype.getCenterXY = function (q, r) {
  var x, y;

  if (this.pointyTiles) {
    x = (this.tileSize + this.tileSpacing) * Math.sqrt(3) * (q + r / 2);
    y = -((this.tileSize + this.tileSpacing) * 3/2 * r);
  } else {
    x = (this.tileSize + this.tileSpacing) * 3/2 * q;
    y = -((this.tileSize + this.tileSpacing) * Math.sqrt(3) * (r + q / 2));
  }

  return { x: x, y: y };
};

Grid.axialDistance = function (origin, destination) {
  var q1 = origin.q,
      r1 = origin.r,
      q2 = destination.q,
      r2 = destination.r;

  return (Math.abs(q1 - q2) + Math.abs(r1 - r2) + Math.abs(q1 + r1 - q2 - r2)) / 2;
};

Grid.roundCube = function (coordinates) {
  var rx = Math.round(coordinates.x),
      ry = Math.round(coordinates.y),
      rz = Math.round(coordinates.z);

  var dx = Math.abs(rx - coordinates.x),
      dy = Math.abs(ry - coordinates.y),
      dz = Math.abs(rz - coordinates.z);

  if (dx > dy && dx > dz) {
    rx = -ry-rz;
  } else if (dy > dz) {
    ry = -rx-rz;
  } else {
    rz = -rx-ry;
  }

  return { x: rx, y: ry, z: rz }
}

Grid.cubeToAxial = function (cube) {
  return { q: cube.x, r: cube.z }
};

Grid.axialToCube = function (axial) {
  return { x: axial.q, y: -axial.q-axial.r, z: axial.r }
};

module.exports = Grid;
