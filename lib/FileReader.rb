class FileReader

    def read(fileName)
        filesLines = []
        File.foreach(fileName) do |line| 
            filesLines.push(line)
        end
        filesLines
    end 
end
