"use strict"

function Scene () {
  this.mouse = {
    over: false,
    down: false,
    moved: false,
    x: 0,
    y: 0,
    q: 0,
    r: 0
  };
}

Scene.prototype.initialize = function (stage) {
  this.stage   = stage;
  this.element = stage.element;
  this.context = stage.context;
  this.grid = new Grid(this.context);

  this.grid.gridRings      = 2;
  this.grid.gridDrawOrigin = true;
  this.grid.tileSpacing    = 2;
  this.grid.tilePointy     = true;
  this.grid.tileSize       = 25;
  this.grid.tileLineColor  = "rgba(0,0,0,1)";
  this.grid.tileLineWidth  = 1;
  this.grid.tileColor      = "rgba(0,0,0,0)";
  this.grid.tileCoordinates = true;

  return this;
};

Scene.prototype.setQR = function (q, r) {
  if (this.mouse.q != q || this.mouse.r != r) {
    this.onTileFocus();
  }

  this.mouse.q = q;
  this.mouse.r = r;
};

Scene.prototype.onTileFocus = function () {};

Scene.prototype.draw = function () {
  this.grid.drawRingGrid(0,0);
};

Scene.prototype.drawBackground = function () {};

Scene.prototype.addEventListeners = function () {
  this.mouseUpEventHandler = this.mouseUp.bind(this);
  this.element.addEventListener("mouseup", this.mouseUpEventHandler);

  this.mouseDownEventHandler = this.mouseDown.bind(this);
  this.element.addEventListener("mousedown", this.mouseDownEventHandler);

  this.mouseMoveEventHandler = this.mouseMove.bind(this);
  this.element.addEventListener("mousemove", this.mouseMoveEventHandler);

  this.mouseEnterEventHandler = this.mouseEnter.bind(this);
  this.element.addEventListener("mouseenter", this.mouseEnterEventHandler);

  this.mouseLeaveEventHandler = this.mouseLeave.bind(this);
  this.element.addEventListener("mouseleave", this.mouseMoveEventHandler);

  this.mouseWheelEventHandler = this.mouseWheel.bind(this);
  this.element.addEventListener("mousewheel", this.mouseWheelEventHandler);
};

Scene.prototype.removeEventListeners = function () {
  this.element.removeEventListener("mouseup", this.mouseUpEventHandler);
  this.element.removeEventListener("mousedown", this.mouseDownEventHandler);
  this.element.removeEventListener("mousemove", this.mouseMoveEventHandler);
  this.element.removeEventListener("mouseenter", this.mouseEnterEventHandler);
  this.element.removeEventListener("mouseleave", this.mouseLeaveEventHandler);
  this.element.removeEventListener("mousewheel", this.mouseMoveWheelHandler);
};

Scene.prototype.mouseDown = function (event) {
  this.mouse.down = true;
  this.mouse.moved = false;
  this.mouse.x = event.clientX;
  this.mouse.y = event.clientY;
};

Scene.prototype.mouseUp = function (event) {
  this.mouse.down = false;
};

Scene.prototype.mouseMove = function (event) {
  this.mouse.moved = true;
  if (this.mouse.down) {
    this.stage.translate.x = this.stage.translate.x - (this.mouse.x - (event.clientX));
    this.stage.translate.y = this.stage.translate.y - (this.mouse.y - (event.clientY));
  }
  this.mouse.x = event.clientX;
  this.mouse.y = event.clientY;
};

Scene.prototype.mouseEnter = function (event) {
  this.mouse.over = true;
};

Scene.prototype.mouseLeave = function (event) {
  this.mouse.over = false;
};

Scene.prototype.mouseWheel = function (event) {
  var delta = event.wheelDelta;

  if (delta > 20) { delta = 20; }
  if (delta < -20) { delta = -20; }

  if (delta > 0) {
    if (!(this.scale >= 3)) {
      this.stage.scale = this.stage.scale + delta / 1000;
    }
  } else {
    if (!(this.scale <= 0.75)) {
      this.stage.scale = this.stage.scale + delta / 1000;
    }
  }
};
