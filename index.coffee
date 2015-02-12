'use strict';
util           = require 'util'
{EventEmitter} = require 'events'
debug          = require('debug')('meshblu-edison-servo')
debug = require('debug')('meshblu:edison-servo:index')
Servo = require './src/servo'

MESSAGE_SCHEMA =
  type: 'object'
  properties:
    left:
      type: 'string'
      required: true
    right:
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
    debug 'onMessage', message
    payload = message.payload;

    return unless payload

    @servos.left?.pwMicroSeconds  parseInt payload.left  if payload.left?
    @servos.right?.pwMicroSeconds parseInt payload.right if payload.right?

  onConfig: (device) =>
    debug 'onConfig', device
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
