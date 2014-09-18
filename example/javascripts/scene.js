"use strict"

function Scene () {
  this.q = 0;
  this.r = 0;
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

  this.grid = new Grid();
  this.tile = new Tile(this.grid, this.context)

  this.grid.tileSize = 50;
  this.grid.withOrigin = true;
  this.tile.coordinates = true;
  this.tile.size = 50;

  return this;
};

Scene.prototype.draw = function () {
  var coordinates = this.grid.hexagonCoordinates(this.q, this.r, 2);
  for (var i = 0; i < coordinates.length; i++) {
    this.tile.draw(coordinates[i].q, coordinates[i].r)
  }
};

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
