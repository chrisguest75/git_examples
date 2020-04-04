# README.md
Unittests for the script

```sh
brew install bats-core
git clone https://github.com/ztombol/bats-support test/test_helper/bats-support
git clone https://github.com/ztombol/bats-assert test/test_helper/bats-assert  
```

```sh
which bats
ls -al /usr/local/bin/bats   
ls -la /usr/local/Cellar/bats-core/1.1.0
cat /usr/local/Cellar/bats-core/1.1.0/README.md   
```

```sh
bats test/tests.bats 
test/tests.bats 
```

```sh
docker run -it bats/bats:latest --version
docker run -it -v $(pwd):/mnt --workdir /mnt bats/bats:latest test/tests.bats         
```