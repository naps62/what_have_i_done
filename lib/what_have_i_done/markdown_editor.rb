require "erb"
require "tempfile"

class WhatHaveIDone::MarkdownEditor
  def initialize(data:)
    @data = data
  end

  def markdown
    renderer = ERB.new(File.read(template_path))

    renderer.result(binding)
  end

  def edit_interactively
    file = Tempfile.new("what_have_i_done")
    file.write(markdown)
    file.flush
    system("$EDITOR #{file.path}")
    file.rewind
    result = file.read
    file.close
    file.unlink

    result
  end

  def template_path
    File.join(WhatHaveIDone.lib_path, "what_have_i_done", "templates", "tasks.md.erb")
  end

  def formatted_task(task)
    [
      task["description"],
      "@development",
      task["duration"],
      Time.at(task["duration"]).utc.strftime("%H:%M"),
    ].join(" ")
  end
end
