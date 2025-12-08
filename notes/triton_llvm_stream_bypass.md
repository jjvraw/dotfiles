# Triton LLVM Streaming Bypass

Download appropriate `.tar.gz`.


```
# Get hash
REV=$(head -c8 cmake/llvm-hash.txt)

# Unzip into appropriate directory. (`~/.triton` is default. See triton README for custom path.)
tar -xzf ~/Downloads/llvm-...     -C ~/.triton/llvm

# Jippo a `version.txt` for Triton's to ignore.
# Double check URL, may change. Located in `setup.py`. 
# Note: doesn't expect an EOF.
printf 'https://oaitriton.blob.core.windows.net/public/llvm-builds/llvm-%s-ubuntu-x64.tar.gz' "$REV"   > "$HOME/.triton/llvm/llvm-${REV}-ubuntu-x64/version.txt

# Begin with install.
# I like verbose, and MAX_JOBS helps with overuse of RAM.
MAX_JOBS=12 pip install -e  . -vv
```
