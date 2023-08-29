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
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n2 $n4 1Mb 10ms DropTail
$ns duplex-link $n3 $n5 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n4 1Mb 10ms DropTail
$ns duplex-link $n1 $n5 1Mb 10ms DropTail
$ns duplex-link $n3 $n2 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n5 $n2 1Mb 10ms DropTail

$ns duplex-link-op $n0 $n1 orient left-down
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n3 orient down
$ns duplex-link-op $n2 $n4 orient down
$ns duplex-link-op $n3 $n5 orient right-down
$ns duplex-link-op $n4 $n5 orient left-down
$ns duplex-link-op $n0 $n3 orient right-down
$ns duplex-link-op $n0 $n5 orient down
$ns duplex-link-op $n0 $n4 orient left-down
$ns duplex-link-op $n1 $n2 orient left
$ns duplex-link-op $n1 $n4 orient left-down
$ns duplex-link-op $n1 $n5 orient left-down
$ns duplex-link-op $n3 $n2 orient left-up
$ns duplex-link-op $n1 $n5 orient left
$ns duplex-link-op $n5 $n2 orient left-up


$ns at 1.0 "finish"
$ns run

