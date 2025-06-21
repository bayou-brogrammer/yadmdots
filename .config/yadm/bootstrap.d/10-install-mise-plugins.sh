#!/usr/bin/env bash

# Mise Development Tools Installation Script
# Installs and configures development tools via mise (version manager)

set -euo pipefail

# Check if mise is available
if ! command -v mise >/dev/null 2>&1; then
    echo "❌ mise not found. Please install mise first."
    exit 1
fi

echo "🔧 Installing and configuring development tools via mise..."

# Navigate to home directory for global installations
cd "${HOME}"

# Install/update mise plugins and tools
echo "📦 Installing mise tools..."

# Core development tools to install via mise
declare -A mise_tools=(
    ["node"]="lts"      # Node.js LTS
    ["python"]="latest" # Python latest
    ["golang"]="latest" # Go latest
    ["deno"]="latest"   # Deno runtime
    ["bun"]="latest"    # Bun runtime
)

# Additional tools that might be useful
declare -A optional_tools=(
    ["rust"]="latest" # Rust (if not already installed)
    # ["zig"]="latest"            # Zig programming language
    ["lua"]="latest" # Lua
    # ["ruby"]="latest"           # Ruby
    # ["php"]="latest"            # PHP
    # ["dart"]="latest"           # Dart
    # ["elixir"]="latest"         # Elixir
)

# Global cargo tools
declare -A cargo_tools=(
    ["bat"]="latest"       # Better cat
    ["exa"]="latest"       # Better ls (keeping for compatibility, though we have eza via brew)
    ["ripgrep"]="latest"   # Better grep
    ["fd"]="latest"        # Better find
    ["tokei"]="latest"     # Code statistics
    ["hyperfine"]="latest" # Benchmarking tool
    ["dust"]="latest"      # Better du
    ["procs"]="latest"     # Better ps
    ["bottom"]="latest"    # Better top
    ["zoxide"]="latest"    # Better cd
    ["starship"]="latest"  # Shell prompt
)

# Global npm tools
declare -A npm_tools=(
    # ["typescript"]="latest"  # TypeScript compiler
    # ["ts-node"]="latest"     # TypeScript runner
    # ["@types/node"]="latest" # Node.js types
    # ["eslint"]="latest"      # Linting
    # ["prettier"]="latest"    # Code formatting
    # ["nodemon"]="latest"     # Development server
)

# Tool descriptions for better selection
declare -A optional_tools_desc=(
    ["rust"]="Systems programming language"
    ["lua"]="Lightweight scripting language"
)

declare -A cargo_tools_desc=(
    ["bat"]="Better cat with syntax highlighting"
    ["exa"]="Better ls with colors and icons"
    ["ripgrep"]="Better grep (extremely fast)"
    ["fd"]="Better find (simple and fast)"
    ["tokei"]="Code statistics and line counting"
    ["hyperfine"]="Command-line benchmarking tool"
    ["dust"]="Better du (disk usage analyzer)"
    ["procs"]="Better ps (process viewer)"
    ["bottom"]="Better top (system monitor)"
    ["zoxide"]="Better cd (smart directory navigation)"
    ["starship"]="Cross-shell prompt customization"
)

declare -A npm_tools_desc=(
    ["typescript"]="TypeScript compiler and language server"
    ["ts-node"]="TypeScript execution environment"
    ["@types/node"]="Node.js type definitions"
    ["eslint"]="JavaScript/TypeScript linting"
    ["prettier"]="Code formatting tool"
    ["nodemon"]="Development server with auto-restart"
)

# Interactive tool selection function
select_tools_interactively() {
    local category="$1"
    local -n tools_ref=$2
    local -n descriptions_ref=$3
    local selected_tools=()

    echo ""
    echo "🔧 Select ${category} tools to install:"
    echo "   Enter the numbers of tools you want (e.g., 1 3 5) or 'all' for everything:"
    echo ""

    # Display available tools with numbers
    local i=1
    local tool_keys=()
    for tool in "${!tools_ref[@]}"; do
        tool_keys+=("$tool")
        local description="${descriptions_ref[$tool]:-No description}"
        printf "   %2d) %-20s - %s\n" "$i" "$tool" "$description"
        ((i++))
    done

    echo ""
    read -p "Select tools (numbers separated by spaces, or 'all', or 'none'): " selection

    if [[ "$selection" =~ ^[Aa]ll$ ]]; then
        # Select all tools
        for tool in "${!tools_ref[@]}"; do
            selected_tools+=("$tool")
        done
    elif [[ "$selection" =~ ^[Nn]one$ ]] || [[ -z "$selection" ]]; then
        # Select no tools
        echo "⏭️  No ${category} tools selected"
        return 1
    else
        # Parse individual selections
        for num in $selection; do
            if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#tool_keys[@]}" ]; then
                local tool_index=$((num - 1))
                selected_tools+=("${tool_keys[$tool_index]}")
            else
                echo "⚠️  Invalid selection: $num (ignored)"
            fi
        done
    fi

    if [ ${#selected_tools[@]} -eq 0 ]; then
        echo "⏭️  No valid ${category} tools selected"
        return 1
    fi

    echo ""
    echo "📋 Selected ${category} tools: ${selected_tools[*]}"

    # Return selected tools via global variable
    selected_tools_result=("${selected_tools[@]}")
    return 0
}

# Function to install mise tool safely
install_mise_tool() {
    local tool="$1"
    local version="$2"

    echo "Installing ${tool}@${version}..."
    if mise use --global "${tool}@${version}" 2>/dev/null; then
        echo "✅ Successfully installed ${tool}@${version}"
        return 0
    else
        echo "⚠️  Failed to install ${tool}@${version}"
        return 1
    fi
}

# Install core tools
echo "📋 Installing core development tools..."
for tool in "${!mise_tools[@]}"; do
    version="${mise_tools[$tool]}"
    install_mise_tool "$tool" "$version"
done

# Ask about optional tools
echo ""
echo "🤔 Would you like to install optional development tools?"
read -p "Install optional tools? [y/N]: " install_optional

if [[ "$install_optional" =~ ^[Yy]$ ]]; then
    if select_tools_interactively "optional mise" optional_tools optional_tools_desc; then
        echo "📋 Installing selected optional development tools..."
        for tool in "${selected_tools_result[@]}"; do
            version="${optional_tools[$tool]}"
            install_mise_tool "$tool" "$version"
        done
    fi
fi

# Ask about cargo tools
echo ""
echo "🤔 Would you like to install useful Rust tools?"
read -p "Install cargo tools? [y/N]: " install_cargo

# Install useful cargo packages if Rust is available
if [[ "$install_cargo" =~ ^[Yy]$ ]]; then
    if command -v cargo >/dev/null 2>&1; then
        if select_tools_interactively "Rust cargo" cargo_tools cargo_tools_desc; then
            echo "🦀 Installing selected Rust tools..."

            # Install cargo tools with cargo-binstall if available (faster)
            if command -v cargo-binstall >/dev/null 2>&1; then
                echo "📦 Using cargo-binstall for faster installation..."
                for tool in "${selected_tools_result[@]}"; do
                    echo "Installing ${tool} via cargo-binstall..."
                    if cargo binstall --no-confirm "$tool" 2>/dev/null; then
                        echo "✅ Installed ${tool}"
                    else
                        echo "⚠️  Failed to install ${tool} via cargo-binstall"
                    fi
                done
            else
                echo "📦 Installing via cargo install (this may take a while)..."
                for tool in "${selected_tools_result[@]}"; do
                    if cargo install --quiet "$tool" 2>/dev/null; then
                        echo "✅ Installed ${tool}"
                    else
                        echo "⚠️  Failed to install ${tool}"
                    fi
                done
            fi
        fi
    else
        echo "⚠️  Cargo not available. Install Rust first to use cargo tools."
    fi
fi

# Ask about npm tools
echo ""
echo "🤔 Would you like to install useful global npm packages?"
read -p "Install npm tools? [y/N]: " install_npm

if [[ "$install_npm" =~ ^[Yy]$ ]]; then
    # Install global npm packages if Node is available
    if command -v npm >/dev/null 2>&1; then
        if select_tools_interactively "npm global" npm_tools npm_tools_desc; then
            echo "📦 Installing selected global npm packages..."

            for tool in "${selected_tools_result[@]}"; do
                echo "Installing ${tool}..."
                if npm install -g "$tool" >/dev/null 2>&1; then
                    echo "✅ Installed ${tool}"
                else
                    echo "⚠️  Failed to install ${tool}"
                fi
            done
        fi
    else
        echo "⚠️  npm not available. Install Node.js first to use npm tools."
    fi
fi

# Update all mise tools
echo "🔄 Updating all mise installations..."
mise upgrade

# Show installed tools
echo ""
echo "📋 Currently installed mise tools:"
mise list

echo ""
echo "🎉 Mise development tools setup completed!"
echo "💡 Tip: Use 'mise use <tool>@<version>' to add tools to your project"
echo "💡 Tip: Use 'mise list-all <tool>' to see available versions for a tool"
