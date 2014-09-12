"use strict"

var module = module || {};

var Trapezoidal = {
  cubeToAxial: function (cube) {
    if (cube.x+cube.y+cube.z !== 0)
      console.warn("The trapezoidal coordinate system have the contraint x + y + z = 0, read more at: http://www.redblobgames.com/grids/hexagons/");

    return { q: cube.x, r: cube.z }
  },

  axialToCube: function (axial) {
    return { x: axial.q, y: -axial.q-axial.r, z: axial.r }
  },

  axialDistance: function (origin, destination) {
    var q1 = origin.q,
        r1 = origin.r,
        q2 = destination.q,
        r2 = destination.r;

    return (Math.abs(q1 - q2) + Math.abs(r1 - r2) + Math.abs(q1 + r1 - q2 - r2)) / 2;
  },

  roundCube: function (coordinates) {
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
}

module.exports = Trapezoidal;
