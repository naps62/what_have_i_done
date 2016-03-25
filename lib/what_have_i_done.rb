require "togglv8"
require "redcarpet"

module WhatHaveIDone
  def self.root
    File.dirname __dir__
  end

  def self.lib_path
    File.join root, "lib"
  end
end

require "what_have_i_done/markdown_editor"
require "what_have_i_done/markdown_parser"
require 'what_have_i_done/toggl'
require "what_have_i_done/harvest_submitter"
require 'what_have_i_done/runner'
