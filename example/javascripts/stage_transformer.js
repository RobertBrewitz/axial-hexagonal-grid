/*
* Author: Robert Brewitz <hello@robertbrewitz.com>
* License: MIT
*/

"use strict";

function StageTransformer () {
  this.element = null;
  this.stage = null;
  this.mouse = null;
  this.scaling = null;
  this.minScaleX = null;
  this.minScaleY = null;
  this.maxScaleX = null;
  this.maxScaleY = null;
  this.panning = null;
}

StageTransformer.prototype.initialize = function (params) {
  this.element = params.element;
  this.stage = params.stage;
  this.mouse = params.mouse || {
    over: false,
    down: false,
    moved: false
  };

  this.scaling = params.scaling || true;
  this.minScaleX = params.minScaleX || 0.01;
  this.minScaleY = params.minScaleY || 0.01;
  this.maxScaleX = params.maxScaleX || 10;
  this.maxScaleY = params.maxScaleY || 10;

  this.panning = params.panning || true;

  return this;
};

StageTransformer.prototype.addEventListeners = function () {
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

StageTransformer.prototype.removeAllEventListeners = function () {
  this.element.removeEventListener("mouseup", this.mouseUpEventHandler);
  this.element.removeEventListener("mousedown", this.mouseDownEventHandler);
  this.element.removeEventListener("mousemove", this.mouseMoveEventHandler);
  this.element.removeEventListener("mouseenter", this.mouseEnterEventHandler);
  this.element.removeEventListener("mouseleave", this.mouseLeaveEventHandler);
  this.element.removeEventListener("mousewheel", this.mouseMoveWheelHandler);
};

StageTransformer.prototype.mouseDown = function (event) {
  this.mouse.down = true;
  this.mouse.moved = false;
  this.mouse.x = event.clientX;
  this.mouse.y = event.clientY;
};

StageTransformer.prototype.mouseUp = function (event) {
  this.mouse.down = false;
};

StageTransformer.prototype.mouseMove = function (event) {
  if (this.mouse.down) {
    this.mouse.moved = true;

    if (this.panning) {
      this.pan(event);
    }
  }
};

StageTransformer.prototype.mouseEnter = function (event) {
  this.mouse.over = true;
};

StageTransformer.prototype.mouseLeave = function (event) {
  this.mouse.over = false;
};

StageTransformer.prototype.mouseWheel = function (event) {
  if (this.scaling) {
    this.scale(event);
  }
};

StageTransformer.prototype.pan = function (event) {
  this.stage.x = this.stage.x - (this.mouse.x - (event.clientX));
  this.stage.y = this.stage.y - (this.mouse.y - (event.clientY));
  this.mouse.x = event.clientX;
  this.mouse.y = event.clientY;
};

StageTransformer.prototype.scale = function (event) {
  var delta = event.wheelDelta;

  if (delta > 100) { delta = 100; }
  if (delta < -100) { delta = -100; }

  if (delta > 0) {
    this.stage.scaleX = this.stage.scaleX + delta / 1000;
    this.stage.scaleY = this.stage.scaleY + delta / 1000;
    if (this.stage.scaleX > this.maxScaleX) { this.stage.scaleX = this.maxScaleX; }
    if (this.stage.scaleY > this.maxScaleY) { this.stage.scaleY = this.maxScaleY; }
  } else {
    this.stage.scaleX = this.stage.scaleX + delta / 1000;
    this.stage.scaleY = this.stage.scaleY + delta / 1000;
    if (this.stage.scaleX < this.minScaleX) { this.stage.scaleX = this.minScaleX; }
    if (this.stage.scaleY < this.minScaleY) { this.stage.scaleY = this.minScaleY; }
  }
};
