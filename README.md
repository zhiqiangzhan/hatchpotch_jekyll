
### 设置多个GitHub账号

#### 生成独立的SSH Key

```bash
ssh-keygen -t rsa -C "zizhizhan@gmail.com"
pbcopy < ~/.ssh/id_rsa_personal.pub
```

#### 添加GITHUB SSH配置

* Go to your Account Settings
* Click “SSH Keys” then “Add SSH key”
* Paste your key into the “Key” field and add a relevant title
* Click “Add key” then enter your Github password to confirm


#### 添加.ssh/config

```bash
touch ~/.ssh/config
```

添加如下内容

```yaml
# github personal
Host personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa

# github public
Host work
    HostName p.github.com
    User git
    IdentityFile ~/.ssh/id_rsa_personal
```

#### 库同步

```bash
git clone git@p.github.com:zizhizhan/hatchpotch_jekyll.git
```