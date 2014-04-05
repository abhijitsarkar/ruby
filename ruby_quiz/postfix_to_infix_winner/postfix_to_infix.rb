PREC = {:+ => 0,:- => 0,:* => 1,:/ => 1,:% => 1,:^ => 2}
LEFT_ASSOCS = {:+ => true,:- => true,:* => true,:/ => true,
          :% => true,:^ => false}
RIGHT_ASSOCS = {:+ => true,:- => false,:* => true,:/ => false,
          :% => false,:^ => true}
class TreeNode

  # Each node has an element, or operator, as well as the subexpressions to the left and right.
  # These subexpresions can be Float objects or additional nodes in the tree.
  attr_accessor :el,:left,:right

  def initialize(el,left,right)
    @el,@left,@right = el,left,right
  end

  def TreeNode.from_postfix(exp_arr)
    stack = []
    exp_arr.each do |exp_str|
      if PREC.keys.include? exp_str.to_sym
        op2,op1 = stack.pop,stack.pop
        stack.push(TreeNode.new(exp_str.to_sym,op1,op2))
      else
        stack.push(exp_str.to_f)
      end
    end
    stack.first
  end

  # First, convert the left and right subexpressions.
  # For Floats this amounts to the helper method that Stringifies them with or
  # without trailing decimal digits at the bottom of the code.
  # For another TreeNode this is just a recursive process.

  # Once we have the minimal left and right subexpression the question becomes,
  # do they need parentheses?
  # If a subexpression isn't a simple Float (which won't have an el() method)
  # and it has a precedence lower than us or the same us when we aren't a left associative operator,
  # parentheses are added.
  # A similar check then is made for the right side using the right associativity table.
  # With any needed parenthesis in place, the expression is simply
  # the left subexpression followed by our operator and the right subexpression.
  def to_minparen_infix
    l,r = [left,right].map{ |o| o.to_minparen_infix}
    l = "(#{l})" if left.respond_to?(:el) and
    ( PREC[left.el]<PREC[self.el] or
    ( PREC[self.el]==PREC[left.el] and
    not LEFT_ASSOCS[self.el] ) )
    r= "(#{r})" if right.respond_to?(:el) and
    ( PREC[right.el]<PREC[self.el] or
    ( PREC[self.el]==PREC[right.el] and
    not RIGHT_ASSOCS[self.el] ) )
    l+" #{self.el} " +r
  end
end

class Float
  def to_minparen_infix
    if self % 1 == 0
      to_i.to_s
    else
      to_s
    end
  end
end

puts TreeNode.from_postfix(ARGV.first.split(/ /)).to_minparen_infix