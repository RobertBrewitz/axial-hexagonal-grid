/*
* Author: Robert Brewitz <hello@robertbrewitz.com>
* License: MIT
*/

"use strict";

var module = module || {};

function Grid () {
  this.tileSize    = 100;
  this.tileSpacing = 0;
  this.pointyTiles = false;
  this.withOrigin  = true;
}

Grid.prototype.ringCoordinates = function (q, r, distance) {
  var result = this.hexagonCoordinates(q, r, distance, true);
  if (this.withOrigin) { result.shift(0); }
  return result;
};

Grid.prototype.hexagonCoordinates = function (q, r, radius, ring) {
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

  for (var currentRing = ring ? radius : 1; currentRing <= radius; currentRing++) {
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

Grid.prototype.pixelToDecimalQR = function (x, y, scale) {
  var q, r;

  if (typeof(scale) !== "number") { scale = 1; }

  if (this.tilePointy) {
    q = (1/3 * Math.sqrt(3) * x - 1/3 * -y) / (this.tileSize + this.tileSpacing);
    r = 2/3 * -y / (this.tileSize + this.tileSpacing);
  } else {
    q = 2/3 * x / (this.tileSize + this.tileSpacing);
    r = (1/3 * Math.sqrt(3) * -y - 1/3 * x) / (this.tileSize + this.tileSpacing);
  }

  q /= scale;
  r /= scale;

  return { q: q, r: r }
}

Grid.prototype.neighborCoordinates = function (q, r) {
  var result = [];
  var neighbors = [
    [+1,  0], [+1, -1], [ 0, -1],
    [-1,  0], [-1, +1], [ 0, +1]
  ];

  for (var i = 0; i < 6; i++) {
    var d = neighbors[i];
    result.push({ q: q + d[0], r: r + d[1]});
  }

  return result;
}

Grid.prototype.axialDistance = function (q1, r1, q2, r2) {
  return (Math.abs(q1 - q2) + Math.abs(r1 - r2) + Math.abs(q1 + r1 - q2 - r2)) / 2;
};

Grid.prototype.pixelToAxial = function (x, y) {
  var decimalQR = this.pixelToDecimalQR(x, y),
      cube = this.axialToCube(decimalQR),
      roundedCube = this.roundCube(cube);

  return this.cubeToAxial(roundedCube);
};

Grid.prototype.roundCube = function (coordinates) {
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

Grid.prototype.cubeToAxial = function (cube) {
  return { q: cube.x, r: cube.y }
};

Grid.prototype.axialToCube = function (axial) {
  return { x: axial.q, y: axial.r, z: -axial.q-axial.r }
};

module.exports = Grid;
