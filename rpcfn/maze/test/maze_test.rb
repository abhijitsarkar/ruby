require 'minitest/autorun'

require_relative '../lib/maze'

class MazeTest < MiniTest::Unit::TestCase
  MAZE1 = %{#####################################
# #   #     #         #     #       #
# # # # # # ####### # ### # ####### #
# # #   # #         #     # #       #
# ##### # ################# # #######
#     # #       #   #     # #   #   #
##### ##### ### ### # ### # # # # # #
#   #     #   # #   #   # # # #   # #
# # ##### ##### # # ### # # ####### #
# #     # #   # # #   # # # #       #
# ### ### # # # # ##### # # # ##### #
#   #       #   #       #     #     #
#####################################}
  # Maze 1 should SUCCEED, [1 ,13] -> [7, 23]

  MAZE2 = %{#####################################
# #       #             #     #     #
# ### ### # ########### ### # ##### #
# #   # #   #   #   #   #   #       #
# # ### ##### # # # # ### ###########
#   #   #     #   # # #   #         #
####### # ### ####### # ### ####### #
#       # #   #       # #       #   #
# ####### # # # ####### # ##### # # #
#       # # # #   #       #   # # # #
# ##### # # ##### ######### # ### # #
#     #   #                 #     # #
#####################################}
  # Maze 2 should SUCCEED, [4, 7] -> [11, 35]

  MAZE3 = %{#####################################
# #   #           #                 #
# ### # ####### # # # ############# #
#   #   #     # #   # #     #     # #
### ##### ### ####### # ##### ### # #
# #       # #     #   #       #   # #
# ######### ##### # ####### ### ### #
#               ###       # # # #   #
# ### ### ####### ####### # # # # ###
# # # #   #     # #   #   # # #   # #
# # # ##### ### # # # # ### # ##### #
#   #         #     #   #           #
#####################################}
  # Maze 3 should FAIL, [5, 15] -> [9, 17]

  @@maze1 = Maze::AMaze.new(MAZE1)
  @@maze2 = Maze::AMaze.new(MAZE2)
  @@maze3 = Maze::AMaze.new(MAZE3)
  def test_initialize()
    vertex_3_3 = @@maze1.at_location([3, 3])
    vertex_7_21 = @@maze1.at_location([7, 21])
    assert(vertex_3_3.neighbor?(DataStructures::Components::Vertex.new([1, 3])))
    assert(vertex_7_21.neighbor?(DataStructures::Components::Vertex.new([7, 23])))

    vertex_1_1 = @@maze2.at_location([1, 1])
    vertex_4_7 = @@maze2.at_location([4, 7])
    assert(vertex_1_1.neighbor?(DataStructures::Components::Vertex.new([5, 1])))
    assert(vertex_4_7.neighbor?(DataStructures::Components::Vertex.new([7, 7])))
  end

  def test_reachable_maze1_1_13_to_7_23()
    assert(@@maze1.reachable?([1, 13], [7, 23]))
  end

  def test_reachable_maze2_4_7_to_11_35()
    assert(@@maze2.reachable?([4, 7], [1, 35]))
  end

  def test_not_reachable_maze3_5_15_to_9_17()
    refute(@@maze3.reachable?([5, 15], [9, 17]))
  end
end