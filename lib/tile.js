"use strict"

var module = module || {};

function Tile (grid, context) {
  this.grid = grid;
  this.context = context;

  this.size = 100;
  this.angle = 0;
  this.color = "rgba(0,0,0,0)";
  this.lineWidth = 1;
  this.lineColor = "rgba(0,0,0,1)";
  this.coordinates = false;
  this.coordinateColor = "rgba(0,0,0,1)";
  this.coordinateFont = "12px Arial";
}

Tile.prototype.draw = function (q, r) {
  var centers = this.grid.getCenterXY(q, r),
      centerX = centers.x,
      centerY = centers.y;

  this.context.save();
  this.context.beginPath();

  this.context.lineWidth = this.lineWidth;
  this.context.strokeStyle = this.lineColor;

  for (var iCorner = 0; iCorner <= 6; iCorner++) {
    var angle = 2 * Math.PI / 6 * (iCorner + this.angle),
        cornerX = centerX + this.size * Math.cos(angle),
        cornerY = centerY + this.size * Math.sin(angle);

    if (iCorner > 0) {
      this.context.lineTo(cornerX, cornerY);
    } else {
      this.context.moveTo(cornerX, cornerY);
    }
  }

  if (this.lineColor && this.lineWidth > 0) {
    this.context.stroke();
  }

  if (this.color) {
    this.context.fillStyle = this.color;
    this.context.fill();
  }

  this.context.restore();

  if (this.coordinates) {
    this.context.save();
    this.context.textAlign = "center";
    this.context.textBaseline = "middle";
    this.context.fillStyle = this.coordinateColor;
    this.context.font = this.coordinateFont;
    this.context.fillText(q+","+r, centerX, centerY);
    this.context.restore();
  }
};

module.exports = Tile;
