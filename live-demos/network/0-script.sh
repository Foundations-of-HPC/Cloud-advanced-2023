# mount correct proc and run folders in our mount namespace
mount -t tmpfs tmpfs /run
mount -t proc proc /proc
# create the two name spaces
ip netns add $namespace1
ip netns add $namespace2
ip netns list
# check their status
ip netns exec $namespace1 ip ad
ip netns exec $namespace2 ip ad
# create the veth (and chek on it)
ip link add ptp-$interface1 type veth peer name ptp-$interface2
# (from)ptp-veth-client@ptp-veth-server(to)
ip link set ptp-$interface1 netns $namespace1
# (from)ptp-veth-client@ifX(to interface X)
ip link set ptp-$interface2 netns $namespace2
ip -all netns exec ip addr
# set static IPs
ip netns exec $namespace1 ip addr add $ip_address1 dev ptp-$interface1
ip netns exec $namespace2 ip addr add $ip_address2 dev ptp-$interface2
# bring interfaces up
ip netns exec $namespace1 ip link set dev ptp-$interface1 up
ip netns exec $namespace2 ip link set dev ptp-$interface2 up
