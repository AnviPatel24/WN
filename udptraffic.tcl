set ns [new Simulator]


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


$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail




$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n0 $n2 orient down
$ns duplex-link-op $n0 $n3 orient left-down

#FOR NODE 1
set udp1 [new Agent/UDP]
$ns attach-agent $n0 $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

set nullag1 [new Agent/Null]
$ns attach-agent $n1 $nullag1

$ns connect $udp1 $nullag1
$ns at 0.5 "$cbr1 start"
$ns at 1.0 "$cbr1 stop"

#FOR NODE 2
set udp2 [new Agent/UDP]
$ns attach-agent $n0 $udp2
set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 500
$cbr2 set interval_ 0.005
$cbr2 attach-agent $udp2

set nullag2 [new Agent/Null]
$ns attach-agent $n2 $nullag2

$ns connect $udp2 $nullag2

$ns at 1.1 "$cbr2 start"
$ns at 1.5 "$cbr2 stop"

#FOR NODE 3
set udp3 [new Agent/UDP]
$ns attach-agent $n0 $udp3
set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 500
$cbr3 set interval_ 0.005
$cbr3 attach-agent $udp3

set nullag3 [new Agent/Null]
$ns attach-agent $n3 $nullag3

$ns connect $udp3 $nullag3

$ns at 1.6 "$cbr3 start"
$ns at 2.0 "$cbr3 stop"

$ns at 2.1 "finish"

$ns run
