# Coding Enviroment

## Docker
```shell
sudo pacman -S docker docker-compose

sudo usermod -aG docker $USER
newgrp docker

sudo systemctl start docker
```

## Programing Language
### C/C++ 
```shell
sudo pacman -S gcc gdb make
```

### Python
```shell
git clone https://github.com/pyenv/pyenv.git
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
```
WARNING: Pyenv require to be init properly in .zshrc. Check ~/.zsh/zsh_init for more details.

Usage: 
```shell
pyenv install <VERSION>
pyenv uninstall <VERSION>

pyenv versions
pyenv global <VERSION>
pyenv local <VERSION>
pyenv shell <VERSION>

pyenv virtualenvs
pyenv virtualenv [VERSION] <NAME>
pyenv virtualenv-delete <NAME>
```

### Java
```shell
```

### Rust

### JavaScript/TypeScript

