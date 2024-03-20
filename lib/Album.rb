class Album
    attr_accessor :year, :decade, :name, :cover
    
    def initialize(year,name,cover)
        @year = year.to_i
        @name = name
        @decade = getDecade(@year)
        @cover = cover
    end

    def getDecade(year)
        decade = (year / 10) * 10
    end

    def <=>(other_album)
        result = @year <=> other_album.year
        if result == 0
            result = @name <=> other_album.name
        end
        result
    end
end
