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


$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail



$ns duplex-link-op $n0 $n1 orient right-up
$ns duplex-link-op $n0 $n2 orient left-up
$ns duplex-link-op $n0 $n3 orient left-down
$ns duplex-link-op $n0 $n4 orient right-down

set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n0 $sink1
$ns connect $tcp1 $sink1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packet_size_ 1000
$ftp1 set rate_ 1mb

set tcp2 [new Agent/TCP]
$tcp2 set class_ 2
$ns attach-agent $n0 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ftp2 set packet_size_ 1000
$ftp2 set rate_ 1mb

$ns at 1.0 "$ftp1 start"
$ns at 2.0 "$ftp1 stop"

$ns at 2.0 "$ftp2 start"
$ns at 3.0 "$ftp2 stop"

$ns at 3.0 "finish"
$ns run

