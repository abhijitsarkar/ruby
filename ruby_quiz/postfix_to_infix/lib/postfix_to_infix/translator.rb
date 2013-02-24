class Translator
  OPERATOR_PRECEDENCE = "/*+-"
  OPERATOR_PRECEDENCE_REGEX = Regexp.new("[" + Regexp.escape(OPERATOR_PRECEDENCE)  + "]")
  def self.translate(postfix_equation)
    stack = []
    infix_equation = nil

    postfix_equation.split.each { |s|
      if (self.number?(s))
        stack << s
      else
        operand1 = stack.pop
        operand2 = stack.pop

        operand1 = self.parenthesize?(operand1, s) ? "(" + operand1 + ")" : operand1
        operand2 = self.parenthesize?(operand2, s) ? "(" + operand2 + ")" : operand2

        infix_equation = operand2 + " " + s + " " + operand1
        stack << infix_equation
      end
    }
    return infix_equation
  end

  private

  def self.parenthesize?(operand, operator)
    # find the middle operator, if any, in the operand and compare it with the
    # current operator. if the current operator precedence is greater,
    # parenthesize is needed
    operators = operand.scan(OPERATOR_PRECEDENCE_REGEX)
    middle_operator = operators[(operators.length / 2).floor]
    (middle_operator != nil) and (OPERATOR_PRECEDENCE.index(operator) < OPERATOR_PRECEDENCE.index(middle_operator))
  end

  def self.number?(str)
    str.match(/^[\d\.]+$/) != nil
  end
end