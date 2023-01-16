use IO::Async::Loop;
use Net::Async::WebSocket::Client;

my $client = Net::Async::WebSocket::Client->new(
	on_text_frame => sub {
		my ($self, $frame) = @_;
		print $frame;
	},
);

my $loop = IO::Async::Loop->new;
$loop->add($client);

$client->connect(
	url => "ws://localhost:8080",	
)->then(sub {
	$client->send_text_frame("Hello!\n");
})->get;

$loop->run;
