module WhatHaveIDone
  class Toggl
    def initialize()
    end

    def get_tasks(date)
      entries = client.
        get_time_entries(
          start_date: date.to_datetime,
          end_date: date.to_datetime + 1,
        ).
        reject { |entry| entry["duration"] <= 0 }

      entries_by_project = entries.group_by { |entry| entry["pid"] }
      project_ids = entries.map { |entry| entry["pid"] }.uniq
      projects = Hash[project_ids.map do |project_id|
        [
          client.get_project(project_id)["name"],
          entries_by_project[project_id]
        ]
      end]
    end

    private

    def client
      @_client ||= TogglV8::API.new
    end
  end
end
