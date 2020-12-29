# == Class: ec2api::policy
#
# Configure the ec2api policies
#
# === Parameters
#
# [*policies*]
#   (Optional) Set of policies to configure for ec2api
#   Example :
#     {
#       'ec2api-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'ec2api-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (Optional) Path to the nova policy.yaml file
#   Defaults to /etc/ec2api/policy.yaml
#
class ec2api::policy (
  $policies    = {},
  $policy_path = '/etc/ec2api/policy.yaml',
) {

  include ec2api::deps
  include ec2api::params

  validate_legacy(Hash, 'validate_hash', $policies)

  Openstacklib::Policy::Base {
    file_path   => $policy_path,
    file_user   => 'root',
    file_group  => $::ec2api::params::group,
    file_format => 'yaml',
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'ec2api_config': policy_file => $policy_path }

}
