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
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail



$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n3 $n4 orient right

set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packet_size_ 1000
$ftp1 set rate_ 1mb

set tcp2 [new Agent/TCP]
$tcp2 set class_ 2
$ns attach-agent $n1 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ftp2 set packet_size_ 1000
$ftp2 set rate_ 1mb

set tcp3 [new Agent/TCP]
$tcp3 set class_ 2
$ns attach-agent $n2 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
$ns connect $tcp3 $sink3

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set type_ FTP
$ftp3 set packet_size_ 1000
$ftp3 set rate_ 1mb

set tcp4 [new Agent/TCP]
$tcp4 set class_ 2
$ns attach-agent $n3 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n4 $sink4
$ns connect $tcp4 $sink4

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ftp4 set type_ FTP
$ftp4 set packet_size_ 1000
$ftp4 set rate_ 1mb

$ns at 1.0 "$ftp1 start"
$ns at 1.5 "$ftp1 stop"

$ns at 2.0 "$ftp2 start"
$ns at 2.5 "$ftp2 stop"

$ns at 3.0 "$ftp3 start"
$ns at 3.5 "$ftp3 stop"

$ns at 4.0 "$ftp4 start"
$ns at 4.5 "$ftp4 stop"

$ns at 4.5 "finish"
$ns run

