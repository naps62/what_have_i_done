require 'rainbow'

module WhatHaveIDone
  class Runner
    def initialize()
      @client = TogglV8::API.new
    end

    def run
      toggl_tasks = Toggl.new.get_tasks(Date.today)
      markdown_tasks = MarkdownEditor.new(data: toggl_tasks).edit_interactively
      harvest_tasks = MarkdownParser.new(markdown: markdown_tasks).parse

      HarvestSubmitter.new(data: harvest_tasks).submit
    end
  end
end
