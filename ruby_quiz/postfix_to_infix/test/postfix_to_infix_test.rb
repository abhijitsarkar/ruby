require 'minitest/autorun'

require_relative '../lib/postfix_to_infix'

class PostfixToInfixTest < MiniTest::Unit::TestCase
  def test_valid_postfix_eqn
    assert_equal("2 + 3", Translator.translate("2 3 +"))
    assert_equal("56 * (34 + 213.7) - 678", Translator.translate("56 34 213.7 + * 678 -"))
    assert_equal("1 + (56 + 35) / (16 - 9)", Translator.translate("1 56 35 + 16 9 - / +"))
    assert_equal("1 / (56 + 35 + (16 - 9))", Translator.translate("1 56 35 + 16 9 - + /"))
    assert_equal("1 / ((56 - 35) * (16 - 9))", Translator.translate("1 56 35 - 16 9 - * /"))
    assert_equal("5 + (1 + 2) * 4 - 3", Translator.translate("5 1 2 + 4 * + 3 -"))
  end
end