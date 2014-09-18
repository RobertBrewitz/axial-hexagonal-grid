"use strict"

function Animation () {
  this.running = false;
}

Animation.prototype.initialize = function (stage) {
  this.element = stage.element;
  this.context = stage.context;
  return this;
};

Animation.prototype.loop = function (stage) {
  var self = this;

  document.dispatchEvent(stage.tick);

  this.context.clearRect(0, 0, this.element.width, this.element.height);

  stage.draw();

  if (this.running) {
    this.requestNextAnimationFrame(function () {
      self.loop(stage);
    });
  }
};

Animation.prototype.stop = function () {
  this.running = false;
}

Animation.prototype.start = function (stage) {
  this.running = true;
  this.loop(stage);
}

Animation.prototype.requestNextAnimationFrame = function (callback) {
  return window.requestAnimationFrame(callback)       ||
         window.webkitRequestAnimationFrame(callback) ||
         window.mozRequestAnimationFrame(callback)    ||
         window.oRequestAnimationFrame(callback)      ||
         window.msRequestAnimationFrame(callback)
};
