class FileManager
  def self.load_inputs (file_path)
    lines = []
    file = File.new(file_path, 'r')
    while line = file.gets
      lines << line
    end
    file.close
    return lines
  end
end