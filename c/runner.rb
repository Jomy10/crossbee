CONTAINER_MANAGER=ENV["CONTAINER_MANAGER"]||"podman"

tool=ARGV[0]
os=ARGV[1]
arch=ARGV[2]
args=ARGV[3..]

if os == "linux"
  system "#{CONTAINER_MANAGER} run \
    --rm \
    --platform #{os}/#{arch} \
    --volume .:/work \
    --workdir /work \
    docker.io/jomy10/clang-linux-gnu:#{arch}-latest \
    #{tool} #{args.map { |a| "\"#{a}\"" }.join(" ")}"
else
  puts "Invalid os #{os}"
end
