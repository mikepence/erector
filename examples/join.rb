# It is a fairly common situation to have a number of items which
# are to be output with a separator between them, but no separator
# before the first one or after the last.  The usual way to do this
# in some non-erector frameworks is to build up an array of rendered
# HTML and then join it (using rendered HTML as the separator).
# Although this is possible in erector, it requires careful use of
# the "raw" method, thus violating the guideline of "keep HTML
# in Widget objects, and non-HTML in strings".

# Here is an example where the goal is to render a set of
# navigation links (or tabs), but where only some of the tabs
# are displayed (based on potentially complex logic which is
# represented here by the show_one and show_two flags).

# This file presents a solution using erector's join method, which
# is designed to solve the join problem.  The file join-with-dummy-array.rb
# is an alternate solution which requires no special erector feature, 
# but builds an array to keep track of which tabs will be rendered.

dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift("#{dir}/../lib")
require 'erector'

class Tabs < Erector::Widget

  def initialize(show_one, show_two)
    @show_one = show_one
    @show_two = show_two
    super()
  end

  def render
    tabs = []
    tabs << Erector::Widget.new { a "One", :href => "/one" } if @show_one
    tabs << Erector::Widget.new { a "Two", :href => "/two" } if @show_two
    join tabs, (Erector::Widget.new { text nbsp(" |"); text " " })
  end

end

puts Tabs.new(false, false).to_s
puts Tabs.new(true, false).to_s
puts Tabs.new(false, true).to_s
puts Tabs.new(true, true).to_s

