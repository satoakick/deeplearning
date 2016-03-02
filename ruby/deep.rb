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
  attr_accessor :w # 行列
  attr_accessor :z # 行列
  attr_accessor :b # 列ベクトル
  attr_accessor :output_size

  def initialize(z, # サンプルベクトルを並べた配列(一つ一つの配列を列ベクトルと見做す)
                 b=nil, # バイアス 
                 output_unit_size)

    # A element of inputs is regarded as column of the matrix x
    @z = Matrix.columns(z)

    # Weight Matrix
    @w = Matrix.build(output_unit_size, @z.row_size) { Random.normal_rand }
    #@w = Matrix.build(output_unit_size, @z.row_size) { 2 } for test

    #バイアスが引数に渡されていない場合、適当に初期化する
    if b.nil?
      @b = Matrix.build(@w.row_size, @z.column_size) { Random.normal_rand } if b.nil?
    else
      @b = b
    end

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

  def feed_forward
    (@w * @z + @b).map { |ele| activation_function(ele) }
  end

  # TODO 
  def back_propagation
  end
end


class Random
   include Math

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

# for test
z = [[1,30,30], [300,1,300], [-300,-300,-1]]
output_unit_size = 2
b = Matrix.build(output_unit_size, z.first.size) { 10 }
per = Perceptron.new(z, b, output_unit_size)

# for test
p "feed_forward"
pp per.feed_forward
