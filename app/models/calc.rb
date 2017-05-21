require 'bigdecimal'
class Calc
  def self.doMath(left,operation,right)
    leftNum = BigDecimal.new(left)
    rightNum = BigDecimal.new(right)
    result = nil

    case (operation)
    when "*"
      result = leftNum * rightNum
    when "**"
      result = leftNum ** rightNum
    when "/"
      result = leftNum / rightNum
    when "+"
      result = leftNum + rightNum
    when "-"
      result = leftNum - rightNum
    when "sqrt"
      result = rightNum.sqrt(0)
    end

    return result.to_s()
  end
end
