require 'beaver'

$beaver.cache_dir = "../.beaver/c"

# TODO: other platforms
linux_platforms = ["amd64", "arm64"]
env :DOCKER_USER, "jomy10"

container_mgr = "podman"

cmd :build do
  call :build_linux_gnu_images 
end

cmd :publish do
  call :tag_linux_gnu
  call :push_linux_gnu
end

def linux_gnu_tag(arch)
  "clang-linux-gnu-#{arch}"
end

def linux_gnu_docker_tag(arch)
  "#{DOCKER_USER}/clang-linux-gnu:#{arch}-latest"
end

cmd :build_linux_gnu_images, each("images/linux-gnu") do |file|
  linux_platforms.each do |arch|
    sh %(#{container_mgr} build --platform linux/#{arch} -t #{linux_gnu_tag(arch)} --file #{file} .)
  end
end

cmd :tag_linux_gnu do
  linux_platforms.each do |arch|
    sh %(#{container_mgr} image tag #{linux_gnu_tag(arch)} #{linux_gnu_docker_tag(arch)})
  end
end

cmd :push_linux_gnu do
  linux_platforms.each do |arch|
    sh %(#{container_mgr} image push #{linux_gnu_docker_tag(arch)}) 
  end
end

