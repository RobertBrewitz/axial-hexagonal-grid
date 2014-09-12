"use strict"

var module = module || {};

function Grid (context) {
  this.origin        = { q: 0, r: 0 };
  this.context       = context;
  this.tilePointy    = true;
  this.tileSpacing   = 0;
  this.tileSize      = 100;
  this.tileLineColor = "rgba(0,0,0,1)";
  this.tileLineWidth = 1;
}

Grid.prototype.drawTile = function (q, r) {
  var centers = { x: 0, y: 0 }, // TODO: Get center x,y based on q,r and context state
      centerX = centers.x,
      centerY = centers.y,
      tileAngle = 0;

  this.context.save();

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
  
  this.context.restore();
};

module.exports = Grid;
