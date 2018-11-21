default['environment_essentials']['update']['frequency'] = 86_400
default['environment_essentials']['packages'] = {
  # packageName => service configuration
  'htop'              => false,
  'git'               => false,
  'memcached'         => {
    supportsStatus: true,
    action: [:enable, :start]
  },
  'curl'              => false,
  'nfs-kernel-server' => false
}
