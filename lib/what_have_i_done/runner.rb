require 'rainbow'

module WhatHaveIDone
  class Runner
    def initialize()
      @client = TogglV8::API.new
    end

    def run
      entries = client.get_time_entries(start_date: Date.today.to_datetime)
      entries_by_project = entries.group_by { |entry| entry["pid"] }
      projects = entries_by_project.keys.map { |pid| client.get_project(pid) }

      projects.each do |project|
        project_entries = entries_by_project[project["id"]]
        time_spent = duration_for_entries(project_entries)
        entries_str = project_entries.map do |entry|
          entry["description"]
        end.uniq.join('; ')

        subtitle project['name']
        subtitle "#{seconds_as_time(time_spent)} (#{seconds_as_hours(time_spent)})"
        text "#{entries_str}\n\n"
      end

      total_time = duration_for_entries(entries)

      title "Total time today:"
      title "#{seconds_as_time(total_time)} (#{seconds_as_hours(total_time)})"
    end

    private

    attr_reader :client

    def duration_for_entries(entries)
      entries.map { |entry| entry["duration"] }.inject(0, &:+)
    end

    def seconds_as_time(seconds)
      Time.at(seconds).utc.strftime("%H:%M:%S")
    end

    def seconds_as_hours(seconds)
      (seconds / (60.0 * 60.0)).round(2).to_s + "h"
    end

    def subtitle(txt)
      puts Rainbow("# #{txt}").blue
    end

    def title(txt)
      puts Rainbow("# #{txt}").green
    end

    def text(txt)
      puts txt
    end
  end
end
