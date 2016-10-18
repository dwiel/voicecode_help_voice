pack = Packages.register
  name: "voicecode"
  description: "adding help mode for voicecode"

pack.commands
  "help voice":
    spoken: "help voice"
    description: "show voice code commands window and optionally search description for whatever is spoken next.  'help voice tag' will start the search and tag mode.  'help voice tag select' will search the command page for the tag: select"
    continuous: false
    enabled: true
    grammarType: "textCapture"
    action: (input) ->
      window = global.windowController.get('main')
      window.show()
      window.focus()

      @do 'core:show-commands-page'
      @delay 250
      @do 'common:find'
      @do 'delete:lines'
      if input[0] == 'tag'
        @string 'tag:'
        input = input[1..]
      else if input[0] == 'package'
        @string 'package:'
        input = input[1..]
      else if input[0] == 'spoken' or input[0] == 'commands'
        @string 'commands:'
        input = input[1..]
      else
        @string 'description:'

      if input?
        @string input.join(' ')
