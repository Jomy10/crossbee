: "${CONTAINER_MANAGER=podman}"

all_args=$@
os=$1
arch=$2
args=("${all_args[@]:2}") # remove os and arch argument and read rest into args

if [[ $os == "linux" ]]; then
	$CONTAINER_MANAGER run --platform $1/$2 docker.io/jomy10/clang-linux-gnu:arm64-latest clang $args
else
	echo "Invalid os $os"
	exit 1
fi
