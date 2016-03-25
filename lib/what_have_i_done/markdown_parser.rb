class WhatHaveIDone::MarkdownParser
  def initialize(markdown:)
    @markdown = markdown
    @result = Hash.new { |hash, key| hash[key] = [] }
  end

  attr_reader :markdown

  def parse
    markdown.
      lines.
      map(&:strip).
      reject(&:empty?).
      each do |line|
        if line.match /^#/
          parse_new_project(line)
        else
          parse_task(line)
        end
      end

    @result
  end

  private

  def parse_new_project(line)
    @current_project = line.gsub(/^#+/, "").strip
    puts @current_project
  end

  def parse_task(line)
    return unless @current_project

    words = line.split(/\s+/)

    hours = Time.parse(words.pop).to_i / 60.0
    task = words.last.match(/^@/) ? words.pop.delete("@") : "development"
    notes = words.join(" ")

    @result[@current_project].push({
      notes: notes,
      task: task,
      hours: hours,
    })
  end
end
