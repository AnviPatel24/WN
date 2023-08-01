set ns [new Simulator]


set nf [open out.nam w]
$ns namtrace-all $nf

#define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace

    #close the trace file
    close $nf

    #execute nam on the trace file
    exec nam out.nam &

    exit 0
}


#create node
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]


$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail



$ns duplex-link-op $n0 $n1 orient right-up
$ns duplex-link-op $n0 $n2 orient left-up
$ns duplex-link-op $n0 $n3 orient left-down
$ns duplex-link-op $n0 $n4 orient right-down


set udp0 [new Agent/UDP]

$ns attach-agent $n0 $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0


set null0 [new Agent/Null]
$ns attach-agent $n1 $null0

$ns connect $udp0 $null0




#Schedule events for CBR traffic
$ns at 0.5 "$cbr0 start"
$ns at 2.5 "$cbr0 stop"

$ns at 5.0 "finish"

$ns run


