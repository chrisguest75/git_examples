# README.md
Unittests for the script

```sh
brew install bats-core
git clone https://github.com/bats-core/bats-support test/test_helper/bats-support
git clone https://github.com/bats-core/bats-assert test/test_helper/bats-assert  
git clone https://github.com/grayhemp/bats-mock test/test_helper/bats-mock
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