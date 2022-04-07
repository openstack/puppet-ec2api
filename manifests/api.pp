# == Class: ec2api::api
#
# EC2 API class to configure the API service via puppet.
#
# === Parameters
#
# All options are optional unless specified otherwise.
# All options defaults to $::os_service_default and
# the default values from the service are used.
#
# === API
#
# [*keystone_ec2_tokens_url*]
#   URL to authenticate token from ec2 request.
#   Default: $::os_service_default
#
# [*ec2_timestamp_expiry*]
#   Time in seconds before ec2 timestamp expires.
#   Default: $::os_service_default
#
# === Service
#
# [*ec2api_listen*]
#   The IP address on which the EC2 API will listen.
#   Default: $::os_service_default
#
# [*ec2api_listen_port*]
#   The port on which the EC2 API will listen.
#   Default: $::os_service_default
#
# [*ec2api_use_ssl*]
#   Enable ssl connections or not for EC2 API.
#   Default: $::os_service_default
#
# [*ec2api_workers*]
#   Number of workers for EC2 API service.
#   The default will be equal to the number of CPUs available.
#   Default: $::os_workers
#
# [*service_down_time*]
#   Maximum time since last check-in for up service.
#   Default: $::os_service_default
#
# === WSGI
#
# [*api_paste_config*]
#   File name for the paste.deploy config for ec2api.
#   Default: $::os_service_default
#
# [*ssl_ca_file*]
#   CA certificate file to use to verify  connecting clients.
#   Default: $::os_service_default
#
# [*ssl_cert_file*]
#   SSL certificate of API server.
#   Default: $::os_service_default
#
# [*ssl_key_file*]
#   SSL private key of API server.
#   Default: $::os_service_default
#
# [*tcp_keepidle*]
#   Sets the value of TCP_KEEPIDLE in seconds for each
#   server socket. Not supported on OS X.
#   Default: $::os_service_default
#
# [*wsgi_default_pool_size*]
#   Size of the pool of greenthreads used by wsgi.
#   Default: $::os_service_default
#
# [*max_header_line*]
#   Maximum line size of message headers to be accepted.
#   max_header_line may need to be increased when using
#   large tokens (typically those generated by the
#   Keystone v3 API with big service catalogs).
#   Default: $::os_service_default
#
# === API clients
#
# [*nova_service_type*]
#   Service type of Compute API, registered in Keystone
#   catalog. Should be v2.1 with microversion support.
#   If it is obsolete v2, a lot of useful EC2 compliant
#   instance properties will be unavailable.
#   Default: $::os_service_default
#
# [*cinder_service_type*]
#   Service type of Volume API, registered in Keystone catalog.
#   Default: $::os_service_default
#
# [*admin_user*]
#   Admin user to access specific cloud resourses.
#   Default: $::os_service_default
#
# [*admin_password*]
#   Admin password.
#   Default: $::os_service_default
#
# [*admin_tenant_name*]
#   Admin tenant name.
#   Default: $::os_service_default
#
# === Auth
#
# [*api_rate_limit*]
#   Whether to use per-user rate limiting for the API.
#   Default: $::os_service_default
#
# [*use_forwarded_for*]
#   Treat X-Forwarded-For as the canonical remote address.
#   Only enable this if you have a sanitizing proxy.
#   Default: $::os_service_default
#
# === ec2utils
#
# [*external_network*]
#   Name of the external network, which is used to connect VPCs to
#   Internet and to allocate Elastic IPs.
#   Default: $::os_service_default
#
# === Availability zone
#
# [*internal_service_availability_zone*]
#   The availability_zone to show internal services under.
#   Default: $::os_service_default
#
# [*my_ip*]
#   IP address of this host.
#   Default: $::os_service_default
#
# [*ec2_host*]
#   The IP address of the EC2 API server.
#   Default: $::os_service_default
#
# [*ec2_port*]
#   The port of the EC2 API server.
#   Default: $::os_service_default
#
# [*ec2_scheme*]
#   The protocol to use when connecting to the EC2 API server (http, https).
#   Default: $::os_service_default
#
# [*ec2_path*]
#   The path prefix used to call the ec2 API server.
#   Default: $::os_service_default
#
# [*region_list*]
#   List of region=fqdn pairs separated by commas.
#   Default: $::os_service_default
#
# === DHCP options
#
# [*network_device_mtu*]
#   MTU size to set by DHCP for instances.
#   Corresponds with the network_device_mtu in ec2api.conf.
#   Default: $::os_service_default
#
# === Common
#
# [*full_vpc_support*]
#   True if server supports Neutron for full VPC access.
#   Default: $::os_service_default
#
# === Instance
#
# [*ec2_private_dns_show_ip*]
#   Return the IP address as private dns hostname in describe instances
#   Default: $::os_service_default
#
# [*default_flavor*]
#   A flavor to use as a default instance type
#   Default: $::os_service_default
#
# === Exception
#
# [*fatal_exception_format_errors*]
#   Make exception message format errors fatal.
#   Default: $::os_service_default
#
# === Paths
#
# [*tempdir*]
#   Explicitly specify the temporary working directory.
#   Default: $::os_service_default
#
# [*pybasedir*]
#   Directory where the ec2api python module is installed.
#   Default: $::os_service_default
#
# [*bindir*]
#   Directory where ec2api binaries are installed.
#   Default: $::os_service_default
#
# [*state_path*]
#   Top-level directory for maintaining ec2api's state.
#   Default: $::os_service_default
#
# === Manage service
#
# [*manage_service*]
#   Should the API service actually be managed by Puppet?
#   Default: true
#
# [*service_name*]
#   The real system name of the API service.
#   Default: $::ec2api::params::api_service_name
#
# [*enabled*]
#   Should the service be enabled and started (true) of disabled and stopped (false).
#   Default: true
#
# DEPRECATED PARAMETERS
#
# [*use_tpool*]
#   Enable the experimental use of thread pooling for
#   all DB API calls
#   Default: $::os_service_default
#
# [*ssl_insecure*]
#   Verify HTTPS connections.
#   Default: undef
#
class ec2api::api (
  # API
  $keystone_ec2_tokens_url            = $::os_service_default,
  $ec2_timestamp_expiry               = $::os_service_default,
  # Service
  $ec2api_listen                      = $::os_service_default,
  $ec2api_listen_port                 = $::os_service_default,
  $ec2api_use_ssl                     = $::os_service_default,
  $ec2api_workers                     = $::os_workers,
  $service_down_time                  = $::os_service_default,
  # WSGI
  $api_paste_config                   = $::os_service_default,
  $ssl_ca_file                        = $::os_service_default,
  $ssl_cert_file                      = $::os_service_default,
  $ssl_key_file                       = $::os_service_default,
  $tcp_keepidle                       = $::os_service_default,
  $wsgi_default_pool_size             = $::os_service_default,
  $max_header_line                    = $::os_service_default,
  # API clients
  $nova_service_type                  = $::os_service_default,
  $cinder_service_type                = $::os_service_default,
  $admin_user                         = $::os_service_default,
  $admin_password                     = $::os_service_default,
  $admin_tenant_name                  = $::os_service_default,
  # auth
  $api_rate_limit                     = $::os_service_default,
  $use_forwarded_for                  = $::os_service_default,
  # ec2utils
  $external_network                   = $::os_service_default,
  # Availability zone
  $internal_service_availability_zone = $::os_service_default,
  $my_ip                              = $::os_service_default,
  $ec2_host                           = $::os_service_default,
  $ec2_port                           = $::os_service_default,
  $ec2_scheme                         = $::os_service_default,
  $ec2_path                           = $::os_service_default,
  $region_list                        = $::os_service_default,
  # DHCP options
  $network_device_mtu                 = $::os_service_default,
  # Common
  $full_vpc_support                   = $::os_service_default,
  # Instance
  $ec2_private_dns_show_ip            = $::os_service_default,
  $default_flavor                     = $::os_service_default,
  # Exception
  $fatal_exception_format_errors      = $::os_service_default,
  # Paths
  $tempdir                            = $::os_service_default,
  $pybasedir                          = $::os_service_default,
  $bindir                             = $::os_service_default,
  $state_path                         = $::os_service_default,
  # Manage service
  $manage_service                     = true,
  $service_name                       = $::ec2api::params::api_service_name,
  $enabled                            = true,
  # DEPRECATED PARAMETERS
  $use_tpool                          = undef,
  $ssl_insecure                       = undef,
) inherits ec2api::params {

  include ec2api::deps

  validate_legacy(Boolean, 'validate_bool', $manage_service)
  validate_legacy(String, 'validate_string', $service_name)
  validate_legacy(Boolean, 'validate_bool', $enabled)

  ec2api_config {
    'DEFAULT/keystone_ec2_tokens_url':            value => $keystone_ec2_tokens_url;
    'DEFAULT/ec2_timestamp_expiry':               value => $ec2_timestamp_expiry;
    'DEFAULT/ec2api_listen':                      value => $ec2api_listen;
    'DEFAULT/ec2api_listen_port':                 value => $ec2api_listen_port;
    'DEFAULT/ec2api_use_ssl':                     value => $ec2api_use_ssl;
    'DEFAULT/ec2api_workers':                     value => $ec2api_workers;
    'DEFAULT/service_down_time':                  value => $service_down_time;
    'DEFAULT/api_paste_config':                   value => $api_paste_config;
    'DEFAULT/ssl_ca_file':                        value => $ssl_ca_file;
    'DEFAULT/ssl_cert_file':                      value => $ssl_cert_file;
    'DEFAULT/ssl_key_file':                       value => $ssl_key_file;
    'DEFAULT/tcp_keepidle':                       value => $tcp_keepidle;
    'DEFAULT/wsgi_default_pool_size':             value => $wsgi_default_pool_size;
    'DEFAULT/max_header_line':                    value => $max_header_line;
    'DEFAULT/nova_service_type':                  value => $nova_service_type;
    'DEFAULT/cinder_service_type':                value => $cinder_service_type;
    'DEFAULT/admin_user':                         value => $admin_user;
    'DEFAULT/admin_password':                     value => $admin_password, secret => true;
    'DEFAULT/admin_tenant_name':                  value => $admin_tenant_name;
    'DEFAULT/api_rate_limit':                     value => $api_rate_limit;
    'DEFAULT/use_forwarded_for':                  value => $use_forwarded_for;
    'DEFAULT/external_network':                   value => $external_network;
    'DEFAULT/internal_service_availability_zone': value => $internal_service_availability_zone;
    'DEFAULT/my_ip':                              value => $my_ip;
    'DEFAULT/ec2_host':                           value => $ec2_host;
    'DEFAULT/ec2_port':                           value => $ec2_port;
    'DEFAULT/ec2_scheme':                         value => $ec2_scheme;
    'DEFAULT/ec2_path':                           value => $ec2_path;
    'DEFAULT/region_list':                        value => $region_list;
    'DEFAULT/network_device_mtu':                 value => $network_device_mtu;
    'DEFAULT/full_vpc_support':                   value => $full_vpc_support;
    'DEFAULT/ec2_private_dns_show_ip':            value => $ec2_private_dns_show_ip;
    'DEFAULT/default_flavor':                     value => $default_flavor;
    'DEFAULT/fatal_exception_format_errors':      value => $fatal_exception_format_errors;
    'DEFAULT/tempdir':                            value => $tempdir;
    'DEFAULT/pybasedir':                          value => $pybasedir;
    'DEFAULT/bindir':                             value => $bindir;
    'DEFAULT/state_path':                         value => $state_path;
  }

  if $use_tpool != undef {
    warning('The use_tpool parameter is deprecated and will be removed in a future release.')
  }
  ec2api_config {
    'DEFAULT/use_tpool': value => pick($use_tpool, $::os_service_default);
  }

  if $ssl_insecure != undef {
    warning('The ssl_insecure parameter is deprecated and has no effect.')
  }
  ec2api_config {
    'DEFAULT/ssl_insecure': value => $ssl_insecure;
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }

    service { 'openstack-ec2-api-service' :
      ensure     => $service_ensure,
      name       => $service_name,
      enable     => $enabled,
      hasstatus  => true,
      hasrestart => true,
      tag        => 'ec2api-service',
    }
  }

}
