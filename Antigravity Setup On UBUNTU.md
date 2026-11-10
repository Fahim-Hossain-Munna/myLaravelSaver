### প্রথমবার ইনস্টল
```
sudo apt update
sudo apt install -y curl libnspr4 libnss3
```
```
mkdir -p ~/antigravity-installers
cd ~/antigravity-installers
curl -fsSL -o install-antigravity-ide.sh "https://gist.github.com/mattezell/febc265a34f9f60058fa48d0f000364d/raw/31b1d6985db619d8877080506b48b92d33e1d4f8/install-antigravity-ide.sh"
curl -fsSL -o uninstall-antigravity-ide.sh "https://gist.github.com/mattezell/febc265a34f9f60058fa48d0f000364d/raw/31b1d6985db619d8877080506b48b92d33e1d4f8/uninstall-antigravity-ide.sh"
```

# antigravity.google/download থেকে Antigravity IDE (Linux x64) tarball নামান
```
cd ~/Downloads
tar xzf "Antigravity IDE.tar.gz"
bash ~/antigravity-installers/install-antigravity-ide.sh "./Antigravity IDE"
rm ~/Downloads/"Antigravity IDE.tar.gz"
```
```
antigravity-ide
```
### নতুন ভার্সন এলে আপডেট (IDE বন্ধ করে, নতুন tarball নামিয়ে)

```
cd ~/Downloads
tar xzf "Antigravity IDE.tar.gz"
bash ~/antigravity-installers/install-antigravity-ide.sh "./Antigravity IDE"
rm ~/Downloads/"Antigravity IDE.tar.gz"
```

### আনইনস্টল

```
bash ~/antigravity-installers/uninstall-antigravity-ide.sh
```
