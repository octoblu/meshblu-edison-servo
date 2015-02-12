'use strict';
util           = require 'util'
{EventEmitter} = require 'events'
debug          = require('debug')('meshblu-edison-servo')
Servo = require './src/servo'

MESSAGE_SCHEMA =
  type: 'object'
  properties:
    leftServoPulseWidth:
      type: 'string'
      required: true
    rightServoPulseWidth:
      type: 'string'
      required: true

OPTIONS_SCHEMA =
  type: 'object'
  properties:
    leftServoPin:
      type: 'integer'
      required: true
      default: 6
    rightServoPin:
      type: 'integer'
      required: true
      default: 9

class Plugin extends EventEmitter
  constructor: ->
    @options = {}
    @messageSchema = MESSAGE_SCHEMA
    @optionsSchema = OPTIONS_SCHEMA
    @servos = {}

  onMessage: (message) =>
    payload = message.payload;

    @servos.left?.psMicroSeconds  payload.left  if payload.left?
    @servos.right?.psMicroSeconds payload.right if payload.right?

  onConfig: (device) =>
    @setOptions device.options

  setOptions: (options={}) =>
    @options = options
    if options.leftServoPin?
      @servos.left  = new Servo options.leftServoPin
      @servos.left.enable()
    if options.rightServoPin?
      @servos.right = new Servo options.rightServoPin
      @servos.right.enable()

module.exports =
  messageSchema: MESSAGE_SCHEMA
  optionsSchema: OPTIONS_SCHEMA
  Plugin: Plugin
