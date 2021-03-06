require 'matrix'
require 'pp'
#class MultiLayerPerceptron
#  attr_accessor :inputs # x
#  attr_accessor :outputs # y
#  attr_accessor :d
#  attr_accessor :layer_size
#  attr_accessor :errors
#
#  def initialize(inputs, d, layer_size=2)
#    @inputs = inputs
#    @d = d
#    @layer_size = layer_size
#
#
#    # 誤差関数はとりあえず二乗誤差で定義
#    @error_function = ErrorFunction.new lambda do |outputs, d|
#      0.5 * (outputs.zip(d).inject(0) {|sum, item| sum + (item[0] - item[1])**2})
#    end
#
#    @perceptrons = []
#    for num in 2..layer_size
#      @perceptrons << Perceptron.new(inputs)
#    end
#  end
#  
#  def feed_forward
#    @outputs = @perceptrons.inject(@inputs) {|output, perceptron| perceptron.feed_forward }
#
#    # 最後に誤差を算出
#    @errors = @error_function.call(@outputs, @d)
#  end
#
#  def back_propagation
#  end
#
#end

class Perceptron
  attr_accessor :w # Matrix
  attr_accessor :z # Matrix
  attr_accessor :b # the column vector
  attr_accessor :output_size

  def initialize(
      z,
      output_unit_size)

    # A element of inputs is regarded as column of the matrix x
    @z = z

    # Weight Matrix
    @w = Matrix.build(output_unit_size, @z.row_size) { Random.normal_rand }

    p "@w.row_size"
    p @w.row_size
    p "@z.column_size"
    p @z.column_size
    @b = Matrix.build(@w.row_size, @z.column_size) { Random.normal_rand }

    p "New perceptron (w)"
    pp @w
    p "New perceptron (z)"
    pp @z
    p "New perceptron (b)"
    pp @b
  end

  def activation_function(u, func_name = nil)

    return 1 / (1 + Math.exp(u)) if func_name.nil?  
    if func_name == 'tanh'
      return Math.tanh(u)
    elsif func_name == 'retified'
      return [u, 0].max
    else
      return 1 / (1 + Math.exp(u))
    end
  end
  
  # As Default, Act the activation function to units.
  def feed_forward(is_activation_funciton=true)
    wz = @w * @z
    p "@w*@z"
    p wz
    p "@b"
    p @b
    (wz + @b).map { |ele| (is_activation_funciton)? activation_function(ele) : ele }
  end

  # TODO 
  def back_propagation
  end
end


class Random
  include Math
  
  # Box-Muller's method
  def self.normal_rand(mu = 0, sigma = 1.0)
    (Math.sqrt(-2*Math.log(rand()))* Math.sin(2*PI*rand()) * sigma) + mu
  end
end

class ErrorFunction
  def initialize(&strategy)
    @strategy = strategy 
  end
  def calc(inputs)
    @strategy.call(inputs)
  end
end

# try the 3-th layer. 
z = Matrix[[1,30,30], [300,1,300], [-300,-300,-1]]
output_unit_size = 2

# 1-th layer
z_1 = Matrix[[1,30,30], [300,1,300], [-300,-300,-1]]
output_unit_size = 2
perceptron_1 = Perceptron.new(z_1, output_unit_size)
z_2 = perceptron_1.feed_forward # feed forward

# 2-th layer TODO Should change the output_unit_size by each layer.
perceptron_2 = Perceptron.new(z_2, output_unit_size) 
y = perceptron_2.feed_forward(false) # feed forward

# For test
p "z_1 1-th layer"
p z_1
p "z_2 2-th layer"
p z_2
p "y "
p y
