#!/bin/bash

# OS判定
OS_TYPE=$(uname -s)
IS_WINDOWS=false

# Windows判定（Git Bash, MSYS2, WSL）
if [[ "$OS_TYPE" == "MINGW64_NT"* ]] || [[ "$OS_TYPE" == "MSYS_NT"* ]]; then
    IS_WINDOWS=true
elif [[ "$OS_TYPE" == "Linux" ]]; then
    # WSL判定
    if grep -qi microsoft /proc/version 2>/dev/null; then
        IS_WINDOWS=true
    fi
fi

echo "OS detected: $OS_TYPE"
echo "Is Windows environment: $IS_WINDOWS"

# ================================
# Node.js インストール関数
# ================================
install_nodejs() {
    echo ""
    echo "================================"
    echo "📦 Checking Node.js installation..."
    echo "================================"
    
    # Node.js がインストール済みか確認
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version)
        echo "✓ Node.js $NODE_VERSION is already installed"
        return 0
    fi
    
    echo "⚠️  Node.js is not installed. Installing Node.js..."
    echo ""
    
    if [ "$IS_WINDOWS" = true ]; then
        install_nodejs_windows
    else
        case "$OS_TYPE" in
            Linux)
                install_nodejs_linux
                ;;
            Darwin)
                install_nodejs_mac
                ;;
            *)
                echo "⚠️  Unsupported OS for automatic Node.js installation"
                echo "   Please install Node.js manually from https://nodejs.org/"
                return 1
                ;;
        esac
    fi
}

install_nodejs_windows() {
    echo "Installing Node.js for Windows..."
    
    # Chocolatey がある場合
    if command -v choco &> /dev/null; then
        echo "Using Chocolatey to install Node.js..."
        choco install nodejs -y
    # Scoop がある場合
    elif command -v scoop &> /dev/null; then
        echo "Using Scoop to install Node.js..."
        scoop install nodejs
    # Windows Package Manager (winget) がある場合
    elif command -v winget &> /dev/null; then
        echo "Using Windows Package Manager (winget) to install Node.js..."
        winget install OpenJS.NodeJS
    else
        echo "❌ No package manager found (Chocolatey, Scoop, or winget)"
        echo "   Please install one of the following package managers:"
        echo "   - Chocolatey: https://chocolatey.org/install"
        echo "   - Scoop: https://scoop.sh"
        echo "   - Windows Package Manager (winget): Built-in Windows 10/11"
        echo ""
        echo "   Then run this script again."
        return 1
    fi
    
    if command -v node &> /dev/null; then
        echo "✓ Node.js $(node --version) installed successfully"
    else
        echo "❌ Node.js installation failed"
        return 1
    fi
}

install_nodejs_linux() {
    # ディストリビューション判定
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        echo "❌ Cannot detect Linux distribution"
        return 1
    fi
    
    case "$DISTRO" in
        ubuntu|debian)
            echo "Installing Node.js for Debian/Ubuntu..."
            sudo apt update
            sudo apt install -y nodejs npm
            ;;
        fedora|rhel|centos)
            echo "Installing Node.js for Fedora/RHEL/CentOS..."
            sudo dnf install -y nodejs npm
            ;;
        arch|manjaro)
            echo "Installing Node.js for Arch/Manjaro..."
            sudo pacman -S nodejs npm --noconfirm
            ;;
        alpine)
            echo "Installing Node.js for Alpine..."
            sudo apk add nodejs npm
            ;;
        *)
            echo "❌ Unsupported Linux distribution: $DISTRO"
            echo "   Please install Node.js manually from https://nodejs.org/"
            return 1
            ;;
    esac
    
    if command -v node &> /dev/null; then
        echo "✓ Node.js $(node --version) installed successfully"
    else
        echo "❌ Node.js installation failed"
        return 1
    fi
}

install_nodejs_mac() {
    echo "Installing Node.js for macOS..."
    
    # Homebrew がある場合
    if command -v brew &> /dev/null; then
        echo "Using Homebrew to install Node.js..."
        brew install node
    else
        echo "❌ Homebrew is not installed"
        echo "   Install Homebrew first: https://brew.sh"
        echo "   Then run this script again."
        return 1
    fi
    
    if command -v node &> /dev/null; then
        echo "✓ Node.js $(node --version) installed successfully"
    else
        echo "❌ Node.js installation failed"
        return 1
    fi
}

# ================================
# dein インストール関数
# ================================
install_dein() {
    echo ""
    echo "================================"
    echo "📦 Installing dein.vim..."
    echo "================================"
    
    mkdir -p ~/dotfiles/.vim/dein
    cd ~/dotfiles/.vim/dein
    curl -fSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh | sh -s -- ~/dotfiles/.vim/dein
    
    if [ $? -eq 0 ]; then
        echo "✓ dein.vim installed successfully"
    else
        echo "❌ dein.vim installation failed"
        return 1
    fi
}

# ================================
# dotfiles セットアップ関数
# ================================
setup_dotfiles() {
    echo ""
    echo "================================"
    echo "🔗 Setting up dotfiles..."
    echo "================================"
    
    cd ~/dotfiles
    
    DOT_FILES=(.vimrc .gvimrc .vim .latexmkrc)
    
    if [ "$IS_WINDOWS" = true ]; then
        echo "Using Windows setup (symbolic link or copy method)"
        
        for file in ${DOT_FILES[@]}
        do
            SOURCE="$HOME/dotfiles/$file"
            TARGET="$HOME/$file"
            
            # ターゲットが既に存在する場合は削除
            if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
                echo "Removing existing $TARGET"
                rm -rf "$TARGET"
            fi
            
            # シンボリックリンク作成を試みる
            if ln -s "$SOURCE" "$TARGET" 2>/dev/null; then
                echo "✓ Created symlink: $TARGET -> $SOURCE"
            else
                # シンボリックリンク失敗時はコピー
                echo "✓ Copying (symlink failed): $TARGET"
                cp -r "$SOURCE" "$TARGET"
            fi
        done
    else
        echo "Using Unix setup (symbolic link method)"
        
        for file in ${DOT_FILES[@]}
        do
            SOURCE="$HOME/dotfiles/$file"
            TARGET="$HOME/$file"
            
            # ターゲットが既に存在する場合は削除
            if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
                echo "Removing existing $TARGET"
                rm -rf "$TARGET"
            fi
            
            ln -s "$SOURCE" "$TARGET"
            echo "✓ Created symlink: $TARGET -> $SOURCE"
        done
    fi
}

# ================================
# Yarn インストール関数
# ================================
install_yarn() {
    echo ""
    echo "================================"
    echo "📦 Checking Yarn installation..."
    echo "================================"
    
    if command -v yarn &> /dev/null; then
        YARN_VERSION=$(yarn --version)
        echo "✓ Yarn $YARN_VERSION is already installed"
        return 0
    fi
    
    echo "⚠️  Yarn is not installed. Installing Yarn..."
    npm install -g yarn
    
    if command -v yarn &> /dev/null; then
        echo "✓ Yarn $(yarn --version) installed successfully"
    else
        echo "❌ Yarn installation failed"
        return 1
    fi
}

# ================================
# メイン処理
# ================================
echo ""
echo "=================================================="
echo "🚀 Dotfiles Setup Script"
echo "=================================================="

# Node.js インストール
install_nodejs
if [ $? -ne 0 ]; then
    echo ""
    echo "⚠️  Skipping dein and Yarn setup (Node.js not available)"
else
    # dein インストール
    install_dein
    
    # Yarn インストール
    install_yarn
fi

# dotfiles セットアップ
setup_dotfiles

echo ""
echo "=================================================="
echo "✓ Setup completed successfully!"
echo "=================================================="
echo ""
echo "📝 Summary:"
echo "  • dein.vim installed in: ~/.vim/dein"
echo "  • Dotfiles linked in: $HOME"
echo "  • Node.js version: $(node --version 2>/dev/null || echo 'Not installed')"
if command -v yarn &> /dev/null; then
    echo "  • Yarn version: $(yarn --version 2>/dev/null)"
fi
echo ""
echo "🎉 You can now use Vim with your dotfiles!"
echo "   coc.nvim and other Node.js-based plugins are ready to use!"
echo ""

if [ "$IS_WINDOWS" = true ]; then
    echo "⚠️  Note for Windows users:"
    echo "  • If symlinks failed, files were copied instead"
    echo "  • For true symlinks, run as Administrator"
fi

echo ""
