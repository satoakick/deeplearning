#file_path = '/Users/sawadasatoaki/Downloads/train-images-idx3-ubyte'
file_path = '/Users/sawadasatoaki/Downloads/train-labels-idx1-ubyte'
f = open(file_path, "rb")


count = 0

train_label
f.each_byte do |c|
  printf"%02X ",c

  count += 1
end
puts ""
f.close
