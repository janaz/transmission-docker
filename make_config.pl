#!/usr/bin/env perl

use warnings;
use strict;
use JSON;
use Scalar::Util qw(looks_like_number);

my %cfg = (
  "alt-speed-down"                 => 50,
  "alt-speed-enabled"              => JSON::false,
  "alt-speed-time-begin"           => 540,
  "alt-speed-time-day"             => 127,
  "alt-speed-time-enabled"         => JSON::false,
  "alt-speed-time-end"             => 1020,
  "alt-speed-up"                   => 10,
  "bind-address-ipv4"              => "0.0.0.0",
  "bind-address-ipv6"              => "::",
  "blocklist-enabled"              => JSON::false,
  "blocklist-url"                  => "http://www.example.com/blocklist",
  "cache-size-mb"                  => 4,
  "dht-enabled"                    => JSON::true,
  "download-dir"                   => "/nonexistent/Downloads",
  "download-queue-enabled"         => JSON::false,
  "download-queue-size"            => 5,
  "encryption"                     => 1,
  "idle-seeding-limit"             => 30,
  "idle-seeding-limit-enabled"     => JSON::false,
  "incomplete-dir"                 => "/nonexistent/Downloads",
  "incomplete-dir-enabled"         => JSON::false,
  "lpd-enabled"                    => JSON::false,
  "message-level"                  => 2,
  "peer-congestion-algorithm"      => "",
  "peer-id-ttl-hours"              => 6,
  "peer-limit-global"              => 200,
  "peer-limit-per-torrent"         => 50,
  "peer-port"                      => 9999,
  "peer-port-random-high"          => 9999,
  "peer-port-random-low"           => 9999,
  "peer-port-random-on-start"      => JSON::false,
  "peer-socket-tos"                => "default",
  "pex-enabled"                    => JSON::true,
  "port-forwarding-enabled"        => JSON::false,
  "preallocation"                  => 1,
  "prefetch-enabled"               => JSON::true,
  "queue-stalled-enabled"          => JSON::true,
  "queue-stalled-minutes"          => 30,
  "ratio-limit"                    => 2,
  "ratio-limit-enabled"            => JSON::false,
  "rename-partial-files"           => JSON::true,
  "rpc-authentication-required"    => JSON::true,
  "rpc-bind-address"               => "0.0.0.0",
  "rpc-enabled"                    => JSON::true,
  "rpc-password"                   => "",
  "rpc-port"                       => 8080,
  "rpc-url"                        => "/transmission/",
  "rpc-username"                   => "",
  "rpc-whitelist"                  => "0.0.0.0",
  "rpc-whitelist-enabled"          => JSON::true,
  "scrape-paused-torrents-enabled" => JSON::true,
  "script-torrent-done-enabled"    => JSON::true,
  "script-torrent-done-filename"   => "/app/done-script.sh",
  "seed-queue-enabled"             => JSON::false,
  "seed-queue-size"                => 10,
  "speed-limit-down"               => 20,
  "speed-limit-down-enabled"       => JSON::false,
  "speed-limit-up"                 => 5,
  "speed-limit-up-enabled"         => JSON::true,
  "start-added-torrents"           => JSON::true,
  "trash-original-torrent-files"   => JSON::false,
  "umask"                          => 18,
  "upload-slots-per-torrent"       => 10,
  "utp-enabled"                    => JSON::true
);

foreach my $k(keys %cfg) {
  my $env_name = uc($k);
  $env_name =~ s/-/_/g;
  $env_name = "TR_$env_name";
  if (exists $ENV{$env_name}) {
    my $passed_env = $ENV{$env_name};
    if ($passed_env eq "true") {
      $cfg{$k} = JSON::true;
    } elsif (looks_like_number($passed_env)) {
      $cfg{$k} = $passed_env + 0;
    } else {
      $cfg{$k} = $passed_env;
    }
  }
}

my $json = JSON->new->allow_nonref;
print $json->utf8(1)->pretty(1)->encode(\%cfg);
