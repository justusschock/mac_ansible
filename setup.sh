#! /bin/sh

# Install homebrew
if [ ! -d /opt/homebrew ]
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

export PATH=$PATH:/opt/homebrew/bin

# install chezmoi
brew install chezmoi

# install oh my zsh
if [ ! -d ${HOME}/.oh-my-zsh ]
then
  /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install oh my zsh passion theme
if [ ! -d ${HOME}/.oh-my-zsh/custom/themes/passion-theme ]
then 
  # core.autocrlf=input prevents https://github.com/robbyrussell/oh-my-zsh/issues/4402
  git clone -c core.autocrlf=input --depth=1 https://github.com/justusschock/ohmyzsh-theme-passion.git ${HOME}/.oh-my-zsh/custom/themes/passion-theme
fi
# symlink theme
ln -sfF ${HOME}/.oh-my-zsh/custom/themes/passion-theme/passion.zsh-theme ${HOME}/.oh-my-zsh/custom/themes/passion.zsh-theme

if [ ! -d ${HOME}/ngrams ]
then
  mkdir ${HOME}/ngrams
  curl https://languagetool.org/download/ngram-data/ngrams-de-20150819.zip --output ngrams-de.zip
  curl  https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip --output ngrams-en.zip
  unzip *.zip -d ${HOME}/ngrams
  rm -rf *.zip
fi

# Init and apply dotfiles
chezmoi init --apply justusschock
chezmoi update

# Install rosetta for all the intel stuff
sudo softwareupdate --install-rosetta

# install all applications
brew bundle --file=${HOME}/.config/Brewfile

# initialize packer before nvim setup
if [ ! -d ${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim ]
then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
# nvim setup
# nvim -c q
# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# nvim --headless -c 'LspInstall --sync rome, cmake, julials, bashls, ltex, texlab, pyright, ccls, dockerls, jsonls, remark_ls' -c q

/usr/bin/bash ${HOME}/.config/.osx


