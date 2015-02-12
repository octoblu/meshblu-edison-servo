{Pwm} = require 'mraa'

class Servo
  constructor: (pinNumber) ->
    @pin = new Pwm pinNumber

  enable: =>
    @pin.enable(true)

  pwMicroSeconds: (value) =>
    @pin.pulsewidth_us value


module.exports = Servo
  
