# CrossBee

A cross-compilation toolchain using docker for any build system.

> [!WARNING]
> **In early development**

## Examples

```sh
crossbee start linux arm64 make clang ar
```

Runs `make` with the commands `clang` and `ar` replaced by versions running in Docker.

```sh
crossbee start linux x86_64 "ruby make.rb" clang++ ar
```

Runs `ruby make.rb` with the commands `clang++` and `ar` replaced by versions running in Docker.

## License

Mozilla Public License 2.0

