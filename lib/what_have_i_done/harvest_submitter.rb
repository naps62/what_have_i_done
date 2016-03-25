require "harvested"

class WhatHaveIDone::HarvestSubmitter
  def initialize(data:)
    @data = data
  end

  def submit
    data.each do |project, entries|
      project_id = harvest_id_for_project(project)
      if !project_id
        puts "skipping project #{project}"
        next
      end

      entries.each do |entry|
        task_id = harvest_id_for_task(entry[:task])
        require 'pry'; binding.pry
        if !task_id
          puts "skipping entry for #{project}: #{entry}"
          next
        end

        puts "creating time entry for #{project}"

        client.time.create(
          notes: entry[:notes],
          hours: entry[:hours],
          task_id: task_id,
          project_id: project_id,
        )
      end
    end
  end

  def harvest_id_for_project(project_name)
    harvest_projects.find do |project|
      project.name.downcase == project_name.downcase
    end
  end

  def harvest_id_for_task(task_name)
    harvest_tasks.find do |task|
      task.name.downcase == task_name.downcase
    end
  end

  private

  attr_reader :data

  def harvest_projects
    @_harvest_projects ||= client.projects.all
  end

  def harvest_tasks
    @_harvest_tasks ||= client.tasks.all
  end

  def client
    @_client ||= Harvest.client(
      subdomain: "subvisual",
      username: "miguel@subvisual.co",
      password: File.read(File.join(ENV["HOME"], ".harvest")).strip
    )
  end
end
