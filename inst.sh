#!/bin/bash

# Script to install gitpush command to PATH
# This script will:
# 1. Create the gitpush script
# 2. Make it executable
# 3. Add it to your PATH permanently

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Installing gitpush helper script...${NC}"

# Create bin directory if it doesn't exist
BIN_DIR="$HOME/bin"
if [ ! -d "$BIN_DIR" ]; then
    echo "Creating directory $BIN_DIR..."
    mkdir -p "$BIN_DIR"
fi

# Create the gitpush script
cat > "$BIN_DIR/gitpush" << 'EOF'
#!/bin/bash

# gitpush - A script to simplify git add, commit, and push operations
# Usage: gitpush "Your commit message"

# Check if a commit message was provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide a commit message."
    echo "Usage: gitpush \"Your commit message\""
    exit 1
fi

# Store the commit message
COMMIT_MESSAGE="$1"

# Add all changes
echo "Adding all changes..."
git add .

# Check if git add was successful
if [ $? -eq 0 ]; then
    echo "Successfully added changes."
else
    echo "Error: Failed to add changes."
    exit 1
fi

# Commit with the provided message
echo "Committing changes with message: \"$COMMIT_MESSAGE\""
git commit -m "$COMMIT_MESSAGE"

# Check if git commit was successful
if [ $? -eq 0 ]; then
    echo "Successfully committed changes."
else
    echo "Error: Failed to commit changes."
    exit 1
fi

# Push to the remote repository
echo "Pushing to origin main..."
git push -u origin main

# Check if git push was successful
if [ $? -eq 0 ]; then
    echo "Successfully pushed changes to origin main."
else
    echo "Error: Failed to push changes to origin main."
    exit 1
fi

echo "All git operations completed successfully!"
EOF

# Make the script executable
chmod +x "$BIN_DIR/gitpush"
echo -e "${GREEN}✓ Created gitpush script and made it executable${NC}"

# Detect shell and add bin directory to PATH
SHELL_PROFILE=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_PROFILE="$HOME/.bashrc"
else
    # Try to detect based on default shell
    if [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_PROFILE="$HOME/.zshrc"
    else
        SHELL_PROFILE="$HOME/.bashrc"
    fi
fi

# Check if PATH already contains our bin directory
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "Adding $BIN_DIR to your PATH in $SHELL_PROFILE..."
    echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_PROFILE"
    echo -e "${GREEN}✓ Added $BIN_DIR to PATH${NC}"
else
    echo -e "${GREEN}✓ $BIN_DIR is already in your PATH${NC}"
fi

echo -e "\n${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}To start using gitpush immediately, run:${NC}"
echo -e "    source $SHELL_PROFILE"
echo -e "\n${YELLOW}Example usage:${NC}"
echo -e "    gitpush \"Initial commit\""
echo -e "\n${GREEN}Happy coding!${NC}"
