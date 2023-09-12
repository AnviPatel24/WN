set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red

set nf [open out.nam w]
$ns namtrace-all $nf


proc finish {} {
    global ns nf
    $ns flush-trace

    close $nf
    
    exec nam out.nam &

    exit 0
}



set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


$ns duplex-link $n0 $n1 2Mb 10ms DropTail
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n0 $n3 1.7Mb 20ms DropTail

#set queue size of link (n0-n3) to 10
$ns queue-limit $n0 $n3 10

$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n0 $n2 orient down
$ns duplex-link-op $n0 $n3 orient left-down

#monitoring the queue for link (n0-n3) 
$ns duplex-link-op $n0 $n3 queuePos 0.5


#setting tcp connection 
set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1

#setting ftp over tcp connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP


#setting udp connection
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set nullag1 [new Agent/Null]
$ns attach-agent $n3 $nullag1
$ns connect $udp1 $nullag1
$udp1 set fid_ 2


#setting cbr over udp connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set type_ CBR
$cbr1 set packetSize_ 500
$cbr1 set rate_ 1mb
$cbr1 set random_ false


$ns at 0.1 "$cbr1 start"
$ns at 1.0 "$ftp1 start"
$ns at 4.0 "$ftp1 stop"
$ns at 4.5 "$cbr1 stop"


$ns at 4.5 "$ns detach-agent $n0 $tcp1; $ns detach-agent $n2 $sink1"

$ns at 5.0 "finish"


puts "CBR packet size= [$cbr1 set packet_size_]"
puts "CBR interval= [$cbr1 set interval_]"
$ns run



