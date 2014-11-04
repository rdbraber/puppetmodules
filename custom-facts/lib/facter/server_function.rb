# Fact: server_function
#
# Purpose: Returns the function of the host.
#
# Resolution: Takes the first three characters of the hostname to determine the function.
#
#

Facter.add(:server_function) do
  setcode do
    host = Facter.value(:hostname)
    if host.match(/^dbs/)
      "Database server"
    elsif host.match(/^web/)
     "Web server"
    elsif host.match(/^ovs/)
     "OVS server"
    end
  end
end

Facter.add(:server_function) do
  setcode do
    "Unknown"
  end
end
