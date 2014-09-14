"use strict"

function Stage () {
  this.tick      = null;
  this.translate = { x: 0, y: 0 };
  this.scale     = 1;
  this.scenes    = {};
}

Stage.prototype.initialize = function () {
  this.element = document.getElementById("stage");
  this.context = this.element.getContext("2d");
  this.translate.x = this.element.width / 2
  this.translate.y = this.element.height / 2

  this.animation = new Animation().initialize(this);
  this.scenes.main = new Scene().initialize(this);

  this.activeSetting = this.scenes.main;
  this.activeSetting.addEventListeners();

  return this;
};

Stage.prototype.play = function () {
  this.tick = new CustomEvent("tick", { detail: { started: +new Date() } });
  this.animation.start(this);
};

Stage.prototype.stop = function () {
  this.animation.stop();
};

Stage.prototype.changeScene = function (scene) {
  this.activeSetting.removeEventListeners();
  this.activeSetting = this.scenes[scene];
  this.activeSetting.addEventListeners();
}

Stage.prototype.draw = function () {
  this.context.save();
  this.context.clearRect(0, 0, this.element.width, this.element.height);
  this.context.scale(this.scale, this.scale);
  this.context.translate(this.translate.x / this.scale, this.translate.y / this.scale);
  this.activeSetting.draw();
  this.context.restore();
};
