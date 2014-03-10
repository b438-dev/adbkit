Command = require '../../command'
Protocol = require '../../protocol'
Tracker = require '../../tracker'
HostDevicesCommand = require './devices'

class HostTrackDevicesCommand extends HostDevicesCommand
  execute: (callback) ->
    this._send 'host:track-devices'
    @parser.readAscii 4
      .then (reply) =>
        switch reply
          when Protocol.OKAY
            new Tracker @connection
          when Protocol.FAIL
            @parser.readError()
          else
            @parser.unexpected reply, 'OKAY or FAIL'

module.exports = HostTrackDevicesCommand
