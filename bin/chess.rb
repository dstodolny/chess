#!/usr/bin/env ruby
require_relative "../lib/chess.rb"

puts "Welcome to chess"

Chess::Game.new.play
