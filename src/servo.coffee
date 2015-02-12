{Pwm} = require 'mraa'
debug = require('debug')('meshblu:edison-servo:servo')

class Servo
  constructor: (pinNumber) ->
    debug 'new Servo', pinNumber
    @pin = new Pwm pinNumber

  enable: =>
    debug 'enable'
    @pin.enable(true)

  pwMicroSeconds: (value) =>
    debug 'pwMicroSeconds', value
    @pin.pulsewidth_us value


module.exports = Servo
  
