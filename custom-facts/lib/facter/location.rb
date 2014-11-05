# Fact: location
#
# Purpose: Returns the physical location of the host.
#
# Resolution: Takes the fourth character of the hostname to determine the physical location.
# 
# fourth
# character	location	stage
# 1		Madrid		Development
# 2		Rome		Development
# 3		Madrid          Testing
# 4		Rome            Testing
# 5		Madrid		Production
# 6		Rome		Production

Facter.add(:location) do
  setcode do
    host = Facter.value(:hostname)
    if host[3,1] == "1" or host[3,1] == "3" or host[3,1] == "5" 
      "Madrid"
    elsif host[3,1] == "2" or host[3,1] == "4" or host[3,1] == "6"
     "Rome"
    end
  end
end

Facter.add(:location) do
  setcode do
    "Unknown"
  end
end
