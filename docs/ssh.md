# Setup SSH 

```shell
sudo pacman -S openssh

cd
mkdir .ssh
cd .ssh
ssh-keygen
```

Then in the `.ssh` folder, create the file `config` like this:
```
# Comment

Host github.com
    Hostname github.com
    User git
    IdentityFile ~/.ssh/keyname
    IdentitiesOnly yes
```

You can add as many host as needed.

Test:
```
ssh -T git@github.com
```
