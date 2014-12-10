# Fact: server_function
#
# Purpose: Returns the function of the host.
#
# Resolution: Takes the first three characters of the hostname to determine the function.
#
#
# dbs	database server
# web	web server
# ovs	Oracle VM server

Facter.add(:server_function) do
  setcode do
    host = Facter.value(:hostname)
    if host.match(/^dbs/)
      "database_server"
    elsif host.match(/^web/)
     "web_server"
    elsif host.match(/^ovs/)
     "ovs_server"
    elsif host.match(/^ora/)
     "Oracle_server"
    end
  end
end

Facter.add(:server_function) do
  setcode do
    "Unknown"
  end
end
