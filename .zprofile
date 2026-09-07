# ============================================================================
# ZSH LOGIN ENVIRONMENT
#
# This file is responsible for environment variables and PATH configuration
# that should be available to login shells and applications launched from
# the desktop session.
#
# Keep interactive-only configuration in ~/.zshrc.
# ============================================================================


# ============================================================================
# XDG BASE DIRECTORY SPECIFICATION
# ============================================================================

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"


# ============================================================================
# EDITOR CONFIGURATION
# ============================================================================

export EDITOR="nvim"
export VISUAL="nvim"


# ============================================================================
# LANGUAGE / LOCALE
# ============================================================================

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


# ============================================================================
# PATH CONFIGURATION
# ============================================================================

# Zsh's $path array is tied to $PATH.
# typeset -U prevents duplicate PATH entries.
typeset -U path


# Function to safely add an existing directory to the front of PATH.
add_to_path() {
    [[ -d "$1" ]] && path=("$1" $path)
}


# ----------------------------------------------------------------------------
# Local binaries
# ----------------------------------------------------------------------------

add_to_path "$HOME/.local/bin"


# ----------------------------------------------------------------------------
# Go
# ----------------------------------------------------------------------------

export GOPATH="$HOME/go"
add_to_path "$GOPATH/bin"


# ----------------------------------------------------------------------------
# Development Tools
# ----------------------------------------------------------------------------

DEV_TOOLS="$HOME/DevTools"
ANDROID_HOME="$DEV_TOOLS/Android/Sdk"

export ANDROID_HOME


# ----------------------------------------------------------------------------
# Android SDK
# ----------------------------------------------------------------------------

if [[ -d "$ANDROID_HOME" ]]; then
    add_to_path "$ANDROID_HOME/cmdline-tools/tools/bin"
    add_to_path "$ANDROID_HOME/platform-tools"
    add_to_path "$ANDROID_HOME/tools"
    add_to_path "$ANDROID_HOME/emulator"
fi


# ============================================================================
# MISE
#
# IMPORTANT:
#
# Use mise shims here instead of regular interactive activation.
#
# This makes mise-managed tools available to the environment inherited by
# GUI applications, IDEs, VS Code, language servers, build systems, etc.
#
# DO NOT initialize mise again in ~/.zshrc.
# ============================================================================

if [[ -x "$HOME/.local/bin/mise" ]]; then
    eval "$("$HOME/.local/bin/mise" activate zsh --shims)"
fi


# ============================================================================
# DENO
#
# Deno's environment file can modify PATH and related environment variables,
# so it belongs in the login environment rather than interactive-only config.
# ============================================================================

if [[ -f "$HOME/.deno/env" ]]; then
    source "$HOME/.deno/env"
fi


# ============================================================================
# CLEANUP
# ============================================================================

unset -f add_to_path
