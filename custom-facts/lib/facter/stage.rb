# Fact: stage
#
# Purpose: Returns the stage of the host.
#
# Resolution: Takes the fourth character of the hostname to determine the stage.
#
# hostname
# fourth
# character     location        stage
# 1             Madrid          Development
# 2             Rome            Development
# 3             Madrid          Production
# 4             Rome            Production

Facter.add(:stage) do
  setcode do
    host = Facter.value(:hostname)
    if host[3,1] == "1" or host[3,1] == "2" 
      "Development"
    elsif host[3,1] == "3" or host[3,1] == "4" 
     "Production"
    end
  end
end

Facter.add(:stage) do
  setcode do
    "Unknown"
  end
end
