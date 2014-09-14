"use strict"

var module = module || {};

function Grid (context) {
  this.origin        = { q: 0, r: 0 };
  this.context       = context;

  this.gridRings      = 1;
  this.gridDrawOrigin = true;

  this.tileSpacing   = 0;
  this.tilePointy    = false;
  this.tileSize      = 100;
  this.tileLineColor = "rgba(0,0,0,1)";
  this.tileLineWidth = 1;
  this.tileColor     = "rgba(0,0,0,0)";

  this.tileCoordinates = false;
  this.tileCoordinateColor = "rgba(0,0,0,1)";
  this.tileCoordinateFont = "12px Arial";
}

Grid.prototype.drawRingGrid = function (q, r) {
  // Used below to move the to the next tile positioning and drawing
  var moveDirections = [
  //  q   r
    [ 1,  0],
    [ 0, -1],
    [-1,  0],
    [-1,  1],
    [ 0,  1],
    [ 1,  0],
    [ 1, -1]
  ];

  // Set grid center
  var currentQ = q;
  var currentR = r;

  // Draw grid center?
  if (this.gridDrawOrigin) {
    this.drawTile(q, r);
  }

  // Traverse through ring "currentRing" starting with ring one (1)
  for (var currentRing = 1; currentRing <= this.gridRings; currentRing++) {
    // Reset origin for the draw loop
    currentQ = q;
    currentR = r;

    // Move east and draw, then move south-west and draw, then move west and draw and so forth.
    for(var moveDirection = 0; moveDirection < moveDirections.length; moveDirection++) {

      // How many times we have to move in each direction to draw the entire ring
      for(var moveCounter = 0; moveCounter < currentRing; moveCounter++) {
        // Move into position
        currentQ += moveDirections[moveDirection][0];
        currentR += moveDirections[moveDirection][1];

        // The first move is for getting into position, not drawing
        if (moveDirection != 0) {
          // Draw tile for position
          this.drawTile(currentQ, currentR);
        }
      }
    }
  }
};

Grid.prototype.getCenterXY = function (q, r) {
  var x, y;

  if (this.tilePointy) {
    x = (this.tileSize + this.tileSpacing) * Math.sqrt(3) * (q + r / 2);
    y = -((this.tileSize + this.tileSpacing) * 3/2 * r);
  } else {
    x = (this.tileSize + this.tileSpacing) * 3/2 * q;
    y = -((this.tileSize + this.tileSpacing) * Math.sqrt(3) * (r + q / 2));
  }

  return { x: x, y: y };
};

Grid.prototype.drawTile = function (q, r) {
  var centers = this.getCenterXY(q, r),
      centerX = centers.x,
      centerY = centers.y,
      tileAngle = 0;

  this.context.save();
  this.context.beginPath();

  this.context.lineWidth = this.tileLineWidth;
  this.context.strokeStyle = this.tileLineColor;

  if (this.tilePointy) {
    tileAngle = 0.5;
  }

  for (var iCorner = 0; iCorner <= 6; iCorner++) {
    var angle   = 2 * Math.PI / 6 * (iCorner + tileAngle),
        cornerX = centerX + this.tileSize * Math.cos(angle),
        cornerY = centerY + this.tileSize * Math.sin(angle);

    if (iCorner > 0) {
      this.context.lineTo(cornerX, cornerY);
    } else {
      this.context.moveTo(cornerX, cornerY);
    }
  }

  this.context.stroke();
  this.context.fillStyle = this.tileColor;
  this.context.fill();
  this.context.restore();

  if (this.tileCoordinates) {
    this.context.save();
    this.context.textAlign = "center";
    this.context.textBaseline = "middle";
    this.context.fillStyle = this.tileCoordinateColor;
    this.context.font = this.tileCoordinateFont;
    this.context.fillText(q+","+r, centerX, centerY);
    this.context.restore();
  }
};

module.exports = Grid;
