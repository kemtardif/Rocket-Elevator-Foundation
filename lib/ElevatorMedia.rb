module ElevatorMedia

    def textContent(hour)
        if hour >= 0 && hour <= 12
            return '<div> morning text </div>'
        elsif hour > 12 && hour <= 24
            return '<div> afternoon text </div>'
        end
    end

    def videoContent(hour)
        if hour >= 0 && hour <= 12
            return '<div> morning video </div>'
        elsif hour > 12 && hour <= 24
            return '<div> afternoon video </div>'
        end
    end



end


class Streamer

    extend ElevatorMedia

    def self.getContent(hour)

        content = Array.new

        content << textContent(hour)

        content << videoContent(hour)

        return content

    end
end